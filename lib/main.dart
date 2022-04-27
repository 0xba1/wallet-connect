import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/app_theme.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';
import 'package:wallet_connect/firebase_options.dart';
import 'package:wallet_connect/services/auth_repo/auth_repo.dart';
import 'package:wallet_connect/views/screens/connect.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepo = AuthRepo(FirebaseAuth.instance);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(authRepo),
      child: const MyApp(),
    ),
  );
}

/// {@template app}
/// Material app
/// {@end_template}
class MyApp extends StatelessWidget {
  /// {@macro app}
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: const ConnectYourWallet(),
      debugShowCheckedModeBanner: false,
    );
  }
}
