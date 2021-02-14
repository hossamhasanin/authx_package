import 'package:authentication_x/states/AuthState.dart';

class SignupState extends AuthState {
  bool isSigned;
  Exception error;
  bool isSigning;

  SignupState({this.isSigned, this.error, this.isSigning});

  @override
  List<Object> get props => [isSigned, isSigning, error];

  SignupState copy({isSigned, isSigning, error}) {
    return SignupState(
        isSigned: isSigned ?? this.isSigned,
        isSigning: isSigning ?? this.isSigning,
        error: error ?? this.error);
  }
}
