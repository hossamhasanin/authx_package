import 'AuthState.dart';

class SignupState extends AuthState {
  bool isSigned;
  Exception? error;
  bool isSigning;

  SignupState(
      {required this.isSigned, required this.error, required this.isSigning});

  @override
  List<Object> get props => [isSigned, isSigning];

  SignupState copy({isSigned, isSigning, error}) {
    return SignupState(
        isSigned: isSigned ?? this.isSigned,
        isSigning: isSigning ?? this.isSigning,
        error: error ?? this.error);
  }
}
