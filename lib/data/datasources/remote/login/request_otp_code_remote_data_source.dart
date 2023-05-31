import 'package:dartz/dartz.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';
import '../../../models/user_model.dart';

class RequestOtpCodeRemoteDataSourceImpl implements RequestOtpCodeRemoteDataSource {

  Apis api = Apis();

  RequestOtpCodeRemoteDataSourceImpl({required this.api});

  @override
  Future<int> requestOtpCode(String phoneNumber,{String? refferalCode}) async {
    print('dfsdfsdfsdf $phoneNumber');
    Either<Failure, int> response = await api.requestOtpCode(UserModel(phoneNumber: phoneNumber,refferalCode:refferalCode ));
    return response.fold((failure) => throw Failure(failure.message), (res) => res);
  }
}

abstract class RequestOtpCodeRemoteDataSource {
   Future<int> requestOtpCode(String phoneNumber,{String? refferalCode});
}