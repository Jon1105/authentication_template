import 'package:authentication_template/authentication/views/resetPassword.dart';

import '/authentication/views/signIn.dart';
import '/authentication/views/signUp.dart';
import '/authentication/views/viewWrapper.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final pageController = PageController(initialPage: 1);

  void navigatePages(AuthPage page) {
    int index;
    switch (page) {
      case AuthPage.resetPassword:
        index = 0;
        break;
      case AuthPage.signIn:
        index = 1;
        break;
      case AuthPage.signUp:
        index = 2;
        break;
    }
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  void displayError(String errorMessage) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () =>
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: Center(
          child: ViewWrapper(
            PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ResetPasswordView(displayError, navigatePages),
                SignInView(displayError, navigatePages),
                SignUpView(displayError, navigatePages),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthPage { resetPassword, signIn, signUp }
