import '../../../data/models/audit_ads_model.dart';
import '../../repositories/audit_ads/get_ads_for_audit_repository.dart';

class GetAdsForAudit {
final GetAdsForAuditRepository getAdsForAuditRepository;

GetAdsForAudit({required this.getAdsForAuditRepository});

Future<AuditAdsModel> call(int limit, int page) async {
  return await getAdsForAuditRepository.getAdsForAudit(limit, page);
}

}