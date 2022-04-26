import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet_connect/services/auth_repo/auth_exceptions.dart';

/// Interface for authentication service
abstract class IAuthRepo {
  /// Authentication by email
  Future<void> signInWithEmail(String email);

  /// Authentication by phone number
  Future<void> verifyPhoneNumber(String phoneNumber);

  /// Verification using OTP
  Future<void> verifyCode(String code);
}

/// {@template auth_repo}
/// Firebase Authentication API
/// {@end_template}
class AuthRepo extends IAuthRepo {
  /// {@macro auth_repo}
  AuthRepo(this.auth);

  /// [FirebaseAuth] instance
  final FirebaseAuth auth;

  // Password to be used for passwordless signIn
  final String _password = 'connectYourWallet0';

  /// Verification id to be used in OTP verification
  String? verifyId;

  /// [User] to be signed in, `null` if no user
  User? get user => auth.currentUser;

  @override
  Future<void> signInWithEmail(String email) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: _password,
      );
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          await auth.signInWithEmailAndPassword(
            email: email.trim(),
            password: _password,
          );
        } catch (e) {
          debugPrint('$e');
          throw InvalidEmail();
        }
      } else {
        debugPrint('$e');
        throw InvalidEmail(e.code);
      }
    } catch (e) {
      debugPrint('$e');
      throw InvalidEmail();
    }
  }

  @override
  Future<void> verifyCode(String code) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verifyId!,
      smsCode: code,
    );
    try {
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      throw IncorrectCode(e.code);
    } catch (e) {
      debugPrint('$e');
      throw IncorrectCode();
    }
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
