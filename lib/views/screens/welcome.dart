import 'package:flutter/material.dart';
import 'package:wallet_connect/keys.dart';

/// {@template welcome}
/// A dummy welcome screen
/// {@end_template}
class Welcome extends StatelessWidget {
  /// {@macro template}
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: Keys.welcomeKey,
      body: Center(
        child: Text('Welcome to a whole new world!'),
      ),
    );
  }
}
