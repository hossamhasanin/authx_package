import 'package:authentication_x/states/AuthState.dart';

class LoginState extends AuthState {
  bool isLogging;
  Exception error;
  bool isLogged;

  LoginState({this.isLogged, this.error, this.isLogging});

  @override
  List<Object> get props => [isLogged, isLogging, error];

  LoginState copy({isLogging, isLogged, error}) {
    return LoginState(
        isLogged: isLogged ?? this.isLogged,
        isLogging: isLogging ?? this.isLogging,
        error: error ?? this.error);
  }
}
