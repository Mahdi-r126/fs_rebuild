// import 'package:dartz/dartz.dart';
// import 'package:freesms/apis/apis.dart';
// import 'package:freesms/presentation/shared/entities/failure.dart';
// import '../../../models/user_model.dart';
//
// class CheckVersionRemoteDataSourceImpl implements CheckVersionRemoteDataSource {
//
//   Apis api = Apis();
//
//   CheckVersionRemoteDataSourceImpl({required this.api});
//
//   @override
//   Future<String> checkVersion() async {
//     Either<Failure, String> response = await api.checkVersion();
//     return response.fold((failure) => throw Failure(failure.message), (res) => res);
//   }
// }
//
// abstract class CheckVersionRemoteDataSource {
//    Future<String> checkVersion();
// }