
import 'package:freesms/data/models/audit_ads_model.dart';

abstract class GetAdsForAuditRepository {
  Future<AuditAdsModel> getAdsForAudit(int limit, int page);
}