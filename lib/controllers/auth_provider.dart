import 'package:flutter/foundation.dart';
import 'package:wallet_connect/models/auth_type.dart';
import 'package:wallet_connect/services/auth_repo/auth_exceptions.dart';
import 'package:wallet_connect/services/auth_repo/auth_repo.dart';
import 'package:wallet_connect/validator.dart';

/// {@template auth_pro}
/// Authentication UI controller
/// {@end_template}
class AuthProvider extends ChangeNotifier {
  /// {@macro auth_repo}
  AuthProvider(this.authRepo);

  /// Authentication service
  final AuthRepo authRepo;

  /// Value inputed by user, either email or phone
  String currentInputValue = '';

  AuthType _currentInputType = AuthType.phone;

  /// Current textfield input type
  AuthType get currentInputType => _currentInputType;

  /// Toggle input type
  void toggleInputType() {
    if (_currentInputType == AuthType.phone) {
      _currentInputType = AuthType.email;
    } else {
      _currentInputType = AuthType.phone;
    }
    notifyListeners();
  }

  String? _inputError;

  /// Error when inputing email or phone number
  String? get inputError => _inputError;

  set inputError(String? inputError) {
    _inputError = inputError;
    notifyListeners();
  }

  String? _verificationError;

  /// Error when inputing verification code
  String? get verificationError => _verificationError;

  set verificationError(String? verificationError) {
    _verificationError = verificationError;
    notifyListeners();
  }

  Future<void> _verifyPhone(String phoneNumber) async {
    try {
      await authRepo.verifyPhoneNumber(phoneNumber);
      verificationError = null;
    } on InvalidPhoneNumber catch (e) {
      debugPrint(e.message);
    }
  }

  /// Verify OTP
  Future<void> verifyCode(String code) async {
    try {
      await authRepo.verifyCode(code);
      inputError = null;
    } on IncorrectCode catch (e) {
      verificationError = 'Please enter correct code';
      debugPrint(e.message);
    }
  }

  Future<void> _signInWithEmail(String email) async {
    try {
      await authRepo.signInWithEmail(email);
      inputError = null;
    } on InvalidEmail catch (e) {
      debugPrint(e.message);
    }
  }

  // Add '+' if phone number does not begin with '+'
  String _sanitizePhone(String phone) {
    if (phone[0] == '+') return phone;
    return '+$phone';
  }

  /// Authenticate phone number or email
  Future<void> submit() async {
    if (Validator.isPhone(currentInputValue.trim())) {
      _currentInputType = AuthType.phone;
      await _verifyPhone(_sanitizePhone(currentInputValue));
    } else if (Validator.isEmail(currentInputValue.trim())) {
      _currentInputType = AuthType.email;
      await _signInWithEmail(currentInputValue);
    } else {
      inputError = 'Enter valid text';
    }
  }

  /// Checks whether email has been verified
  Future<bool> get isEmailVerified async {
    final user = authRepo.user;
    if (user == null) {
      return false;
    } else {
      await user.reload();
      return user.emailVerified;
    }
  }
}
