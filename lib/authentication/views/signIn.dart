import 'package:authentication_template/authentication/authenticationService.dart';
import 'package:authentication_template/authentication/widgets/space.dart';
import 'package:authentication_template/authentication/widgets/actionRow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/authentication/widgets/inputField.dart';
import '/authentication/widgets/confirmationButton.dart';
import '/authentication/screens/authenticationPage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInView extends StatefulWidget {
  final void Function(String) errorSetter;
  final void Function(AuthPage) pageNavigator;

  const SignInView(this.errorSetter, this.pageNavigator, {Key? key})
      : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var hidePassword = true;
  var showPasswordToggle = false;
  var loading = false;

  // void _setLoading(bool v) => setState(() => loading = v);

  void _signInEmail(BuildContext context) async {
    var result = await context.read<AuthenticationService>().signInEmail(
          emailController.text.trim(),
          passwordController.text,
        );
    if (result.cancelled)
      widget.errorSetter('cancelled');
    else if (result.hasError) widget.errorSetter(result.errorMessage!);
  }

  void _signInAnonymous(BuildContext context) async {}

  void _togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sign In', style: Theme.of(context).textTheme.headline3),
        Space(),
        InputField(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          autofocus: true,
        ),
        Space(),
        InputField(
          hintText: 'Password',
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          onChanged: (s) => setState(() => showPasswordToggle = s.isNotEmpty),
          suffixIcon: showPasswordToggle
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                )
              : null,
        ),
        Space(),
        ConfirmationButton(
            text: 'Sign In', onPressed: _signInEmail, loading: loading),
        Space(),
        Text('or', style: Theme.of(context).textTheme.subtitle2),
        Space(),
        Row(children: [
          SignInButton(Buttons.GoogleDark, onPressed: () {}),
          SignInButton(Buttons.AppleDark, mini: true, onPressed: () {}),
          SignInButton(Buttons.GitHub, mini: true, onPressed: () {}),
          SignInButtonBuilder(
            backgroundColor: Colors.green,
            text: 'Sign in with phone',
            mini: true,
            icon: Icons.phone,
            onPressed: () {},
          ),
          SignInButtonBuilder(
            backgroundColor: Colors.black54,
            text: 'Sign in anonymously',
            mini: true,
            icon: FontAwesomeIcons.userSecret,
            onPressed: () {},
          )
        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        Divider(),
        ActionRow(
            mainText: 'Don\'t have an account?',
            actionText: 'Sign Up',
            action: () => widget.pageNavigator(AuthPage.signUp)),
        ActionRow(
            mainText: 'Forgot your password?',
            actionText: 'Reset Password',
            action: () => widget.pageNavigator(AuthPage.resetPassword)),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
