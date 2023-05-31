import 'package:equatable/equatable.dart';
import 'package:freesms/data/models/audit_ads_model.dart';

abstract class AuditAdsState extends Equatable {
  const AuditAdsState();

  @override
  List<Object> get props => [];
}

class AuditAdsInitial extends AuditAdsState {}

class AuditAdsLoading extends AuditAdsState {}

class AuditAdsSuccess extends AuditAdsState {
final AuditAdsModel auditAdsModel;
  const AuditAdsSuccess(this.auditAdsModel);

  @override
  List<Object> get props => [];
}

class AuditAdsFailure extends AuditAdsState {
  final String error;

  const AuditAdsFailure(this.error);

  @override
  List<Object> get props => [error];
}
