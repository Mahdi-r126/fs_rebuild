class User {
  String phoneNumber;
  int? otpCode;
  int? wallet;

  User({required this.phoneNumber, this.otpCode, this.wallet});

  factory User.fromJson(Map<String, dynamic> json) {
    var phoneNumber = json['phoneNumber'];
    var otpCode = json['otpCode'];
    var wallet = json['wallet'];
    return User(phoneNumber: phoneNumber, otpCode: otpCode, wallet: wallet);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'phoneNumber': phoneNumber,
      'otpCode': otpCode,
      'wallet': wallet,
    });
  }
}