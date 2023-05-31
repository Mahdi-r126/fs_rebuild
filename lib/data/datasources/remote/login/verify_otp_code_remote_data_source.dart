import 'package:dartz/dartz.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';
import '../../../../models/tokens.dart';
import '../../../models/user_model.dart';

class VerifyOtpCodeRemoteDataSourceImpl implements VerifyOtpCodeRemoteDataSource {

  Apis api = Apis();

  VerifyOtpCodeRemoteDataSourceImpl({required this.api});

  @override
  Future<Tokens> verifyOtpCode(String phoneNumber, int otpCode) async {
    Either<Failure, Tokens> response = await api.verifyOtpCode(UserModel(phoneNumber: phoneNumber, otpCode: otpCode));
    return response.fold((failure) => throw Failure(failure.message), (res) => res);
  }
}

abstract class VerifyOtpCodeRemoteDataSource {
   Future<Tokens> verifyOtpCode(String phoneNumber, int otpCode);
}