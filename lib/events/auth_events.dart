import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  String email;
  String password;

  Login({required this.email, required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}

class SignUp extends AuthEvent {
  String email;
  String password;
  String username;

  SignUp({required this.email, required this.username, required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email, password, username];
}
