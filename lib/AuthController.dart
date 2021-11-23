import 'dart:async';
import 'dart:io';

import 'package:authentication_x/states/user_image_viewstate.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:models/User.dart';

import 'auth_usecase.dart';
import 'authx_datasource.dart';
import 'events/auth_events.dart';
import 'states/AuthState.dart';
import 'states/LoginState.dart';
import 'states/SignupState.dart';

const String LOGIN_TAG = "AUTHX_LOGIN";

const String SIGNUP_TAG = "AUTHX_SIGNUP";

enum NavigationDestiny { LOGIN, SIGNUP }

class AuthController extends GetxController {
  late AuthUseCase _authUseCase;
  StreamController<AuthEvent> _events = StreamController<AuthEvent>();

  Rx<AuthState> authState = AuthState().obs;
  Rx<NavigationDestiny> navigationHandler = NavigationDestiny.LOGIN.obs;

  Rx<UserImageViewState> userImageViewState = UserImageViewState(
          user: User(id: "", username: "", email: ""),
          uploading: false,
          pickedImage: null,
          error: "")
      .obs;

  AuthController({required AuthDataSource authDataSource}) {
    _authUseCase = AuthUseCase(dataSource: authDataSource);
    _events.stream.listen((event) async {
      if (event is Login) {
        await _login(event);
      } else if (event is SignUp) {
        await _signup(event);
      }
    });
  }

  login(String email, String password) {
    _events.sink.add(Login(email: email, password: password));
  }

  signup(String email, String password, String username) {
    _events.sink
        .add(SignUp(email: email, password: password, username: username));
  }

  Future _login(Login event) async {
    if (authState.value is LoginState) {
      if ((authState.value as LoginState).isLogging) {
        return;
      }
    }
    try {
      // authState.value =
      //     LoginState(isLogging: true, isLogged: false, error: null);
      await _authUseCase.login(event.email, event.password);
      authState.value =
          LoginState(isLogged: true, isLogging: false, error: null);
    } catch (e) {
      print("$LOGIN_TAG > $e");
      authState.value = AuthState();
      authState.value = LoginState(
          isLogging: false,
          isLogged: false,
          error: Exception("Error in logging in check your credentials agian"));
    }
  }

  Future _signup(SignUp event) async {
    if (authState.value is SignupState) {
      if ((authState.value as SignupState).isSigning) {
        return;
      }
    }
    try {
      print("koko we are here");
      authState.value =
          SignupState(isSigning: true, isSigned: false, error: null);
      await _authUseCase.signup(event.email, event.password, event.username);
      authState.value =
          SignupState(isSigning: false, isSigned: true, error: null);
    } catch (e) {
      print("$SIGNUP_TAG > $e");
      authState.value = AuthState();

      authState.value = SignupState(
          isSigning: false,
          isSigned: false,
          error: Exception("Error in logging in check your credentials agian"));
    }
  }

  bool isLoggedIn() {
    return _authUseCase.isLoggedIn();
  }

  Future logout() {
    return _authUseCase.logout();
  }

  Stream<User> get user => _authUseCase.user;

  Future uploadFile(File image) async {
    userImageViewState.value =
        userImageViewState.value!.copy(pickedImage: image, uploading: true);

    var storageReference = FirebaseStorage.instance
        .ref()
        .child('users_images')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    try {
      await storageReference.putFile(image);

      var fileURL = await storageReference.getDownloadURL();
      User user = userImageViewState.value!.user!;
      user.image = fileURL;
      userImageViewState.value =
          await _authUseCase.upadateUserData(userImageViewState.value!, user);
    } catch (e) {
      userImageViewState.value = userImageViewState.value!
          .copy(uploading: false, error: "Error while uploading");
    }
  }

  Future updateProfile(User user) async {
    userImageViewState.value =
        await _authUseCase.updateProfile(userImageViewState.value!, user);
  }

  @override
  void onClose() {
    _events.close();
    authState.close();
    navigationHandler.close();
    super.onClose();
  }
}
