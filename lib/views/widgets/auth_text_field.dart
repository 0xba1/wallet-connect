import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wallet_connect/app_theme.dart';
import 'package:wallet_connect/controllers/auth_provider.dart';
import 'package:wallet_connect/keys.dart';
import 'package:wallet_connect/models/auth_type.dart';
import 'package:wallet_connect/views/screens/confirm.dart';
import 'package:wallet_connect/views/widgets/input_error_widget.dart';

/// {@template auth_field}
/// TextField for auth, either phone or email
/// {@end_template}
class AuthTextField extends StatelessWidget {
  /// {@macro auth_field}
  const AuthTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: 327,
            height: 69,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (authPro.currentInputType == AuthType.phone)
                        Text(
                          'Phone',
                          style: AppTheme.textTheme.subtitle1?.copyWith(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      if (authPro.currentInputType == AuthType.phone)
                        const Expanded(
                          child: _PhoneTextField(),
                        )
                      else
                        const Expanded(
                          child: _EmailTextField(),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  key: Keys.inputToggleKey,
                  onPressed: authPro.toggleInputType,
                  icon: Icon(
                    authPro.currentInputType == AuthType.phone
                        ? Icons.phone_android_rounded
                        : Icons.email_rounded,
                  ),
                )
              ],
            ),
          ),
          const InputErrorWidget(),
        ],
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context, listen: false);
    return TextField(
      key: Keys.emailInputKey,
      autofocus: true,
      onChanged: (value) {
        authPro.currentInputValue = value;
      },
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        labelText: 'Phone number or Email',
        labelStyle: AppTheme.textTheme.bodyText1?.copyWith(
          color: Colors.black.withOpacity(0.6),
        ),
        floatingLabelStyle: AppTheme.textTheme.bodyText1?.copyWith(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      onSubmitted: (_) async {
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
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  const _PhoneTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context, listen: false);
    return IntlPhoneField(
      initialCountryCode: 'GB',
      autofocus: true,
      onChanged: (value) {
        authPro.currentInputValue = value.completeNumber;
      },
      textInputAction: TextInputAction.go,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
      ),
      onSubmitted: (_) async {
        await authPro.submit();
        if (authPro.inputError == null) {
          unawaited(
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfirmCode(),
              ),
            ),
          );
        }
      },
    );
  }
}
