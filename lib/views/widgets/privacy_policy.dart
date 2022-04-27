import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wallet_connect/app_theme.dart';

/// {@template policy}
/// Privacy policy
/// {@end_template}
class PrivacyPolicy extends StatelessWidget {
  /// {@macro policy}
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'By signing up I agree to Zëdfi’s ',
              style: AppTheme.textTheme.subtitle1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: AppTheme.textTheme.subtitle1,
            ),
            TextSpan(
              text: ' and ',
              style: AppTheme.textTheme.subtitle1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextSpan(
              text: 'Terms of Use',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: AppTheme.textTheme.subtitle1,
            ),
            TextSpan(
              text: ' and allow Zëdfi to use your information for future ',
              style: AppTheme.textTheme.subtitle1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextSpan(
              text: 'Marketing purposes',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: AppTheme.textTheme.subtitle1,
            ),
            TextSpan(
              text: '.',
              style: AppTheme.textTheme.subtitle1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
