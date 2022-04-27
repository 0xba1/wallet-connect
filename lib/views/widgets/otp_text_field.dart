import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';
import 'package:wallet_connect/views/screens/welcome.dart';
import 'package:wallet_connect/views/widgets/otp_box.dart';

/// {@template otp_field}
/// An otp textfield with a minimum of 2 characters, if less use [OtpBox]
/// {@end_template}
class OtpTextField extends StatefulWidget {
  /// {@macro otp_field}
  const OtpTextField({Key? key, required this.numberOfBoxes})
      : assert(
          numberOfBoxes > 1,
          'Number of boxes must be more than 1',
        ),
        super(key: key);

  /// Number of characters in OTP
  final int numberOfBoxes;

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late List<TextEditingController> controllers;
  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.numberOfBoxes,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getFullCode() {
    return controllers.fold(
      '',
      (previousValue, TextEditingController controller) =>
          previousValue + controller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context, listen: false);
    return Row(
      children: [
        OtpBox(controller: controllers.first),
        ...List.generate(
          widget.numberOfBoxes - 2,
          (index) => OtpBox(controller: controllers[index + 1]),
        ),
        OtpBox(
          controller: controllers.last,
          onComplete: () async {
            // To unfocus keyboard after last input
            FocusScope.of(context).unfocus();
            final code = getFullCode();
            await authPro.verifyCode(code);
            if (authPro.verificationError == null) {
              unawaited(
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Welcome()),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
