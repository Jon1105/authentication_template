import 'package:authentication_template/authentication/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Providers extends StatelessWidget {
  final Widget child;
  const Providers({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthenticationService()),
        StreamProvider<User?>(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: child,
    );
  }
}
