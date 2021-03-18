import 'AuthState.dart';

class LoginState extends AuthState {
  bool isLogging;
  Exception? error;
  bool isLogged;

  LoginState(
      {required this.isLogged, required this.error, required this.isLogging});

  @override
  List<Object> get props => [isLogged, isLogging];

  LoginState copy({isLogging, isLogged, Exception? error}) {
    return LoginState(
        isLogged: isLogged ?? this.isLogged,
        isLogging: isLogging ?? this.isLogging,
        error: error ?? this.error);
  }
}
