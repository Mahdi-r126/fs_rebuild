import '../../../models/tokens.dart';

abstract class VerifyOtpCodeRepository {
  Future<Tokens> verifyOtpCode(String phoneNumber, int otpCode);
}