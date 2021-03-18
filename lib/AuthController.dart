import 'dart:async';

import 'package:get/get.dart';

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
    try {
      // authState.value =
      //     LoginState(isLogging: true, isLogged: false, error: null);
      await _authUseCase.login(event.email, event.password);
      authState.value =
          LoginState(isLogged: true, isLogging: false, error: null);
    } catch (e) {
      print("$LOGIN_TAG > $e");
      authState.value =
          LoginState(isLogging: false, isLogged: false, error: e as Exception);
    }
  }

  Future _signup(SignUp event) async {
    try {
      print("koko we are here");
      authState.value =
          SignupState(isSigning: true, isSigned: false, error: null);
      await _authUseCase.signup(event.email, event.password, event.username);
      authState.value =
          SignupState(isSigning: false, isSigned: true, error: null);
    } catch (e) {
      print("$SIGNUP_TAG > $e");
      authState.value =
          SignupState(isSigning: false, isSigned: false, error: e as Exception);
    }
  }

  bool isLoggedIn() {
    return _authUseCase.isLoggedIn();
  }

  @override
  void onClose() {
    _events.close();
    authState.close();
    navigationHandler.close();
    super.onClose();
  }
}
