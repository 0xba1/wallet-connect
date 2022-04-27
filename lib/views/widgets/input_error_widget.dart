import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/app_theme.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';

/// {@template input}
/// For displaying errors due to bad input in signin screen (connect wallet)
/// {@end_template}
class InputErrorWidget extends StatelessWidget {
  /// {@macro input}
  const InputErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context);

    if (authPro.inputError == null) {
      return const SizedBox();
    } else {
      return Text(
        '${authPro.inputError}',
        style: AppTheme.textTheme.subtitle1?.copyWith(color: Colors.red),
      );
    }
  }
}

/// {@template verify}
/// For displaying errors due to bad verification code input
/// {@end_template}
class VerificationErrorWidget extends StatelessWidget {
  /// {@macro verify}
  const VerificationErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context);

    if (authPro.verificationError == null) {
      return const SizedBox();
    } else {
      return Text(
        '${authPro.verificationError}',
        style: AppTheme.textTheme.subtitle1?.copyWith(color: Colors.red),
      );
    }
  }
}
