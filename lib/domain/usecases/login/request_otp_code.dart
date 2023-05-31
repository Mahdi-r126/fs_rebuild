import '../../repositories/login/request_otp_code_repository.dart';

class RequestOtpCode {
final RequestOtpCodeRepository requestOtpCodeRepository;

RequestOtpCode({required this.requestOtpCodeRepository});

Future<int> call(String phoneNumber, {String?refferalCode}) async {
  return await requestOtpCodeRepository.requestOtpCode(phoneNumber,refferalCode: refferalCode);
}

}