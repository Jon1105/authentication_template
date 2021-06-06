import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/authentication/authenticationService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Text('Home Page', style: Theme.of(context).textTheme.headline1)),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<AuthenticationService>().signOut()),
    );
  }
}
