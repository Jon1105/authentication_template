import 'package:authentication_template/authentication/authenticationService.dart';
import 'package:authentication_template/authentication/widgets/space.dart';
import 'package:authentication_template/authentication/widgets/actionRow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/authentication/widgets/inputField.dart';
import '/authentication/widgets/confirmationButton.dart';
import '/authentication/screens/authenticationPage.dart';

class SignUpView extends StatefulWidget {
  final void Function(String) errorSetter;
  final void Function(AuthPage) pageNavigator;

  const SignUpView(this.errorSetter, this.pageNavigator, {Key? key})
      : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var hidePassword = true;
  var showPasswordToggle = false;
  var loading = false;

  // void _setLoading(bool v) => setState(() => loading = v);

  void _signUp(BuildContext context) async {
    // _setLoading(true);
    var result = await context.read<AuthenticationService>().signUpEmail(
          emailController.text.trim(),
          passwordController.text,
        );
    if (result.cancelled)
      widget.errorSetter('cancelled');
    else if (result.hasError) widget.errorSetter(result.errorMessage!);
    // _setLoading(false);
  }

  void _togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sign Up', style: Theme.of(context).textTheme.headline3),
        Space(),
        InputField(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
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
            text: 'Sign Up', onPressed: _signUp, loading: loading),
        Divider(),
        ActionRow(
            mainText: 'Already have an account?',
            actionText: 'Sign In',
            action: () => widget.pageNavigator(AuthPage.signIn)),
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
