import '../../../domain/repositories/login/verify_otp_code_repository.dart';
import '../../../models/tokens.dart';
import '../../datasources/remote/login/verify_otp_code_remote_data_source.dart';

class VerifyOtpCodeRepositoryImpl implements VerifyOtpCodeRepository {

  final VerifyOtpCodeRemoteDataSource verifyOtpCodeRemoteDataSource;

  VerifyOtpCodeRepositoryImpl({required this.verifyOtpCodeRemoteDataSource});

  @override
  Future<Tokens> verifyOtpCode(String phoneNumber, int otpCode) async {
    Tokens tokens = await verifyOtpCodeRemoteDataSource.verifyOtpCode(phoneNumber, otpCode);
    return tokens;
  }
}