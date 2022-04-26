/// RegExp validation for email and phone number
class Validator {
  /// Checks whether string is valid email
  static bool isEmail(String? test) {
    if (test == null) return false;
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(test);
  }

  /// Checks whether string is valid phone number
  static bool isPhone(String? test) {
    if (test == null) return false;
    const pattern = r'^\+?[\d\s]{7,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(test);
  }
}
