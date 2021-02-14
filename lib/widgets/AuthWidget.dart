import 'package:authentication_x/AuthController.dart';
import 'package:authentication_x/states/LoginState.dart';
import 'package:authentication_x/states/SignupState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthWidget extends GetView<AuthController> {
  final Widget loginWidget;
  final Widget signupWidget;
  final Function(LoginState state) onLoginState;
  final Function(SignupState state) onSignupState;

  AuthWidget(
      {this.loginWidget,
      this.signupWidget,
      this.onLoginState,
      this.onSignupState});

  @override
  Widget build(BuildContext context) {
    controller.authState.listen((state) {
      if (state is LoginState) {
        onLoginState(state);
      } else if (state is SignupState) {
        onSignupState(state);
      }
    });

    return GetX<AuthController>(
      builder: (controller) {
        if (controller.navigationHandler.value == NavigationDestiny.LOGIN) {
          return loginWidget;
        } else if (controller.navigationHandler.value ==
            NavigationDestiny.SIGNUP) {
          return signupWidget;
        } else {
          throw Exception("No distination detected");
        }
      },
    );
  }
}
