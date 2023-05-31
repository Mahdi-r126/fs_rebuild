import 'package:dartz/dartz.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/data/models/audit_ads_model.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';

class GetAdsForAuditRemoteDataSourceImpl implements GetAdsForAuditRemoteDataSource {

  Apis api = Apis();

  GetAdsForAuditRemoteDataSourceImpl({required this.api});

  @override
  Future<AuditAdsModel> getAdsForAudit(int limit, int page) async {
    Either<Failure, AuditAdsModel> response = await api.getAdsForAudition(limit, page);
    return response.fold((failure) => throw Failure(failure.message), (res) => res);
  }
}

abstract class GetAdsForAuditRemoteDataSource {
   Future<AuditAdsModel> getAdsForAudit(int limit, int page);
}