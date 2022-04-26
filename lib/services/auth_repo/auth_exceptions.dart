/// {@template phone}
/// Exception due to error in inputing phone number
/// {@end_template}
class InvalidPhoneNumber implements Exception {
  /// {@macro phone}
  InvalidPhoneNumber([
    this.message = 'An unknown exception occured',
  ]);

  /// Error message
  final String message;
}

/// {@template code}
/// Exception due to error in inputing verification code
/// {@end_template}
class IncorrectCode implements Exception {
  /// {@macro code}
  IncorrectCode([
    this.message = 'An unknown exception occured',
  ]);

  /// Error message
  final String message;
}

/// {@template email}
/// Exception due to error in inputing email
/// {@end_template}
class InvalidEmail implements Exception {
  /// {@macro email}
  InvalidEmail([
    this.message = 'An unknown exception occured',
  ]);

  /// Error message
  final String message;
}
