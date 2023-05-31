class User {
  final String phoneNumber;
  final int? otpCode;
  final String? refferalCode;

  User({
    required this.phoneNumber,
    this.otpCode,
    this.refferalCode
  });
}