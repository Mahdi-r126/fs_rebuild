import '../../../domain/repositories/audit_ads/get_ads_for_audit_repository.dart';
import '../../datasources/remote/audit_ads/get_ads_for_audit_remote_data_source.dart';
import '../../models/audit_ads_model.dart';

class GetAdsForAuditRepositoryImpl implements GetAdsForAuditRepository {

  final GetAdsForAuditRemoteDataSource getAdsForAuditRemoteDataSource;

  GetAdsForAuditRepositoryImpl({required this.getAdsForAuditRemoteDataSource});

  @override
  Future<AuditAdsModel> getAdsForAudit(int limit, int page) async {
    AuditAdsModel auditAds = await getAdsForAuditRemoteDataSource.getAdsForAudit(limit, page);
    return auditAds;
  }
  
}