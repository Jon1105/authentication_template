import 'package:authentication_template/authentication/widgets/authenticationWrapper.dart';
import 'package:authentication_template/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/screens/authenticationPage.dart';
import 'providers.dart';

void main() {
  runApp(Providers(child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Template',
      home: AuthenticationWrapper(HomePage(), AuthenticationPage()),
      darkTheme: ThemeData.dark(),
    );
  }
}
