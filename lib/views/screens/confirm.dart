import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/app_theme.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';
import 'package:wallet_connect/keys.dart';
import 'package:wallet_connect/views/screens/welcome.dart';
import 'package:wallet_connect/views/widgets/input_error_widget.dart';
import 'package:wallet_connect/views/widgets/otp_text_field.dart';
import 'package:wallet_connect/views/widgets/privacy_policy.dart';

/// {@template confirm}
/// Enter confirmation code
/// {@end_template}
class ConfirmCode extends StatelessWidget {
  /// {@macro confirm}
  const ConfirmCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
            Text(
              'We’ve sent you a code',
              style: AppTheme.textTheme.headline1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 4,
                bottom: 157,
              ),
              child: Text(
                'Enter the confirmation code below',
                style: AppTheme.textTheme.bodyText1?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            const OtpTextField(numberOfBoxes: 6),
            const SizedBox(
              height: 18,
            ),
            const VerificationErrorWidget(),
            const Timed(),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PrivacyPolicy(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template email}
/// Confirmation wait page for email verification
/// {@end_template}
class ConfirmEmail extends StatefulWidget {
  /// {@macro email}
  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkVerification();
  }

  Future<void> checkVerification() async {
    final authPro = Provider.of<AuthProvider>(context, listen: false);
    if (await authPro.isEmailVerified) {
      unawaited(
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome(),
          ),
        ),
      );
      return;
    }
    timer = Timer.periodic(const Duration(seconds: 5), (_timer) async {
      if (await authPro.isEmailVerified) {
        _timer.cancel();
        unawaited(
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute(
              builder: (context) => const Welcome(),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      key: Keys.verifyKey,
      body: Column(
        children: [
          const SizedBox(
            height: 75,
          ),
          Text(
            'Check your email',
            style: AppTheme.textTheme.headline1,
          ),
          const SizedBox(
            height: 128,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              // ignore: lines_longer_than_80_chars
              'Click the confirmation link in the mail sent to ${authPro.currentInputValue}',
              style: AppTheme.textTheme.bodyText1?.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PrivacyPolicy(),
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template timed}
/// Timer to enable resend code
/// {@end_template}
class Timed extends StatefulWidget {
  /// {@macro timed}
  const Timed({Key? key}) : super(key: key);

  @override
  State<Timed> createState() => _TimedState();
}

class _TimedState extends State<Timed> {
  Timer? timer;
  int secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_timer) {
        if (_timer.tick == 59) _timer.cancel();
        setState(() {
          secondsRemaining -= 1;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Didn't receive a code? ",
            style: AppTheme.textTheme.subtitle1?.copyWith(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          if (secondsRemaining != 0)
            TextSpan(
              text: 'Wait for $secondsRemaining sec',
              style: AppTheme.textTheme.subtitle1,
            )
          else
            TextSpan(
              text: 'Resend code',
              style: AppTheme.textTheme.subtitle1,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .submit();
                  unawaited(
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmCode(),
                      ),
                    ),
                  );
                },
            )
        ],
      ),
    );
  }
}
