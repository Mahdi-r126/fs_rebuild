import '../../../domain/repositories/login/request_otp_code_repository.dart';
import '../../datasources/remote/login/request_otp_code_remote_data_source.dart';

class RequestOtpCodeRepositoryImpl implements RequestOtpCodeRepository {

  final RequestOtpCodeRemoteDataSource requestOtpCodeRemoteDataSource;

  RequestOtpCodeRepositoryImpl({required this.requestOtpCodeRemoteDataSource});

  @override
  Future<int> requestOtpCode(String phoneNumber,{String? refferalCode}) async {
    int otpCode = await requestOtpCodeRemoteDataSource.requestOtpCode(phoneNumber,refferalCode:refferalCode );
    return otpCode;
  }
  
}