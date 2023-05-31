import 'package:freesms/domain/entities/user.dart';

class UserModel extends User{

  UserModel({required String phoneNumber, int? otpCode,String? refferalCode}) : super(phoneNumber: phoneNumber, otpCode: otpCode,refferalCode: refferalCode);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var phoneNumber = json['phoneNumber'];
    var otpCode = json['otpCode'];
    var refferalCode=json['refferalCode'];
    return UserModel(phoneNumber: phoneNumber, otpCode: otpCode,refferalCode: refferalCode);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'phoneNumber': phoneNumber,
      'otpCode': otpCode,
      'refferalCode': refferalCode,
    });
  }
}