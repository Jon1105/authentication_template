import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  final Widget homePage;
  final Widget authenticationPage;
  const AuthenticationWrapper(this.homePage, this.authenticationPage, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<User?>() == null ? authenticationPage : homePage;
  }
}