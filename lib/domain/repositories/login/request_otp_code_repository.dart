
abstract class RequestOtpCodeRepository {
  Future<int> requestOtpCode(String phoneNumber,{String? refferalCode});
}