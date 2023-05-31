import '../../../models/tokens.dart';
import '../../repositories/login/verify_otp_code_repository.dart';

class VerifyOtpCode {
final VerifyOtpCodeRepository verifyOtpCodeRepository;

VerifyOtpCode({required this.verifyOtpCodeRepository});

Future<Tokens> call(String phoneNumber, int otpCode) async {
  return await verifyOtpCodeRepository.verifyOtpCode(phoneNumber, otpCode);
}

}