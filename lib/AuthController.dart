import 'dart:async';

import 'package:authentication_x/auth_usecase.dart';
import 'package:authentication_x/authx_datasource.dart';
import 'package:authentication_x/events/auth_events.dart';
import 'package:authentication_x/states/AuthState.dart';
import 'package:authentication_x/states/LoginState.dart';
import 'package:authentication_x/states/SignupState.dart';
import 'package:get/get.dart';

const String LOGIN_TAG = "AUTHX_LOGIN";

const String SIGNUP_TAG = "AUTHX_SIGNUP";

enum NavigationDestiny { LOGIN, SIGNUP }

class AuthController extends GetxController {
  AuthUseCase _authUseCase;
  StreamController<AuthEvent> _events = StreamController<AuthEvent>();

  Rx<AuthState> authState = AuthState().obs;
  Rx<NavigationDestiny> navigationHandler = NavigationDestiny.LOGIN.obs;

  AuthController({AuthDataSource authDataSource}) {
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
      authState.value =
          LoginState(isLogging: true, isLogged: false, error: null);
      await _authUseCase.login(event.email, event.password);
      authState.value =
          LoginState(isLogged: true, isLogging: false, error: null);
    } catch (e) {
      print("$LOGIN_TAG > $e");
      authState.value = LoginState(isLogging: false, isLogged: false, error: e);
    }
  }

  Future _signup(SignUp event) async {
    try {
      authState.value =
          SignupState(isSigning: true, isSigned: false, error: null);
      await _authUseCase.signup(event.email, event.password, event.username);
      authState.value =
          SignupState(isSigning: false, isSigned: true, error: null);
    } catch (e) {
      print("$SIGNUP_TAG > $e");
      authState.value =
          SignupState(isSigning: false, isSigned: false, error: e);
    }
  }

  @override
  void onClose() {
    _events.close();
    authState.close();
    navigationHandler.close();
    super.onClose();
  }
}
