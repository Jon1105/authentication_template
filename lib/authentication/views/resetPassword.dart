import 'package:authentication_template/authentication/widgets/space.dart';
import 'package:authentication_template/authentication/widgets/actionRow.dart';
import 'package:flutter/material.dart';
import '/authentication/widgets/inputField.dart';
import '/authentication/widgets/confirmationButton.dart';
import '/authentication/screens/authenticationPage.dart';

class ResetPasswordView extends StatefulWidget {
  final void Function(String) errorSetter;
  final void Function(AuthPage) pageNavigator;

  const ResetPasswordView(this.errorSetter, this.pageNavigator, {Key? key})
      : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final emailController = TextEditingController();
  var loading = false;

  void _resetPassword(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Reset Password', style: Theme.of(context).textTheme.headline3),
        Space(),
        InputField(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          autofocus: true,
        ),
        Space(),
        ConfirmationButton(
            text: 'Reset Password',
            onPressed: _resetPassword,
            loading: loading),
        Divider(),
        ActionRow(
            mainText: 'Use an existing account',
            actionText: 'Sign In',
            action: () => widget.pageNavigator(AuthPage.signIn)),
        ActionRow(
            mainText: 'Create a new account',
            actionText: 'Sign Up',
            action: () => widget.pageNavigator(AuthPage.signUp))
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
