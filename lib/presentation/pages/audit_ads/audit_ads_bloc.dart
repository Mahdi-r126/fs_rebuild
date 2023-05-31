import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freesms/data/models/audit_ads_model.dart';
import '../../../domain/usecases/audit_ads/get_ads_for_audit.dart';
import '../../shared/entities/failure.dart';
import 'audit_ads_state.dart';

class AuditAdsBloc extends Cubit<AuditAdsState> {
  final GetAdsForAudit getAdsAudit;

  AuditAdsBloc({required this.getAdsAudit}) : super(AuditAdsInitial());

  Future<void> getAdsForAudit(int limit, int page) async {
    emit(AuditAdsLoading());
    try {
      AuditAdsModel auditAdsModel = await getAdsAudit(limit, page);
      emit(AuditAdsSuccess(auditAdsModel));
    } catch (e) {
      Failure failure = e as Failure;
      emit(AuditAdsFailure(failure.message));
    }
  }

  void resetState() {
    emit(AuditAdsInitial());
  }
}
