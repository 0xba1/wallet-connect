import 'package:flutter/material.dart';

/// {@template otp_box}
/// One box of an `OtpTextField`
/// {@end_template}
class OtpBox extends StatelessWidget {
  /// {@macro otp_box}
  const OtpBox(
      {Key? key,
      required this.controller,
      this.autofocus = false,
      this.onComplete})
      : super(key: key);

  /// [TextEditingController] for [OtpBox]
  final TextEditingController controller;

  /// For first [OtpBox] in `OtpTextField`
  final bool autofocus;

  /// For last [OtpBox] in `OtpTextField`
  final void Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: SizedBox(
        width: 47,
        height: 69,
        child: TextField(
          autofocus: autofocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          obscureText: true,
          maxLength: 1,
          decoration: InputDecoration(
            fillColor: const Color(0xFFECECEC),
            filled: true,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
              onComplete?.call();
            }
          },
        ),
      ),
    );
  }
}
