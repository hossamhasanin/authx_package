import '../AuthController.dart';
import '../states/LoginState.dart';
import '../states/SignupState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthWidget extends StatefulWidget {
  final Widget loginWidget;
  final Widget signupWidget;
  final Function(LoginState state) onLoginState;
  final Function(SignupState state) onSignupState;
  AuthController controller = Get.find();

  AuthWidget(
      {required this.loginWidget,
      required this.signupWidget,
      required this.onLoginState,
      required this.onSignupState});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.authState.stream.listen((state) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (state is LoginState) {
          widget.onLoginState(state);
        } else if (state is SignupState) {
          print("koko signup");

          widget.onSignupState(state);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (controller) {
        if (controller.navigationHandler.value == NavigationDestiny.LOGIN) {
          return widget.loginWidget;
        } else if (controller.navigationHandler.value ==
            NavigationDestiny.SIGNUP) {
          return widget.signupWidget;
        } else {
          throw Exception("No distination detected");
        }
      },
    );
  }
}
