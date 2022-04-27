import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/app_theme.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';
import 'package:wallet_connect/keys.dart';
import 'package:wallet_connect/models/auth_type.dart';
import 'package:wallet_connect/views/screens/confirm.dart';
import 'package:wallet_connect/views/widgets/auth_text_field.dart';
import 'package:wallet_connect/views/widgets/privacy_policy.dart';

/// {@template connect}
/// Connect your wallet:  Authenticate user with email or phone number
/// {@end_template}
class ConnectYourWallet extends StatelessWidget {
  /// {@macro connect}
  const ConnectYourWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: Keys.homeKey,
        body: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                Text(
                  'Connect your wallet',
                  style: AppTheme.textTheme.headline1,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "We'll send you a confirmation code",
              style: AppTheme.textTheme.bodyText1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AuthTextField(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                key: Keys.submitKey,
                onPressed: () async {
                  await authPro.submit();
                  if (authPro.inputError == null) {
                    if (authPro.currentInputType == AuthType.phone) {
                      unawaited(
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfirmCode(),
                          ),
                        ),
                      );
                    } else {
                      unawaited(
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfirmEmail(),
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 51,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Continue',
                      style: AppTheme.textTheme.bodyText2
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const PrivacyPolicy(),
          ],
        ),
      ),
    );
  }
}
