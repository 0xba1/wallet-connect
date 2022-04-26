import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect/validator.dart';

void main() {
  group('Email validation', () {
    test('Email validation of null should return false', () {
      expect(Validator.isEmail(null), false);
    });
    test('Email validation of empty string should return false', () {
      expect(Validator.isEmail(''), false);
    });
    test('Email validation of `lol.com` should return false', () {
      expect(Validator.isEmail('lol.com'), false);
    });
    test('Email validation of `cryptography@crypto.gmail` should return true',
        () {
      expect(Validator.isEmail('cryptography@crypto.gmail'), true);
    });
  });
  group('Phone number validation', () {
    test('Phone number validation of null should return false', () {
      expect(Validator.isPhone(null), false);
    });
    test('Phone number validation of empty string should return false', () {
      expect(Validator.isPhone(''), false);
    });
    test('Phone number validation of `+1802452137` should return true', () {
      expect(Validator.isPhone('+1802452137'), true);
    });
    test('Phone number validation of `1802452137` should return true', () {
      expect(Validator.isPhone('1802452137'), true);
    });
  });
}
