import 'package:equatable/equatable.dart';
import 'package:freesms/data/models/audit_ads_model.dart';

import '../../../data/models/ads_list_model.dart';

abstract class SponsorAdsState extends Equatable {
  const SponsorAdsState();

  @override
  List<Object> get props => [];
}

class SponsorAdsInitial extends SponsorAdsState {}

class SponsorAdsLoading extends SponsorAdsState {}

class SponsorAdsSuccess extends SponsorAdsState {
final AdsListModel adsListModel;
  const SponsorAdsSuccess(this.adsListModel);

  @override
  List<Object> get props => [];
}

class SponsorAdsFailure extends SponsorAdsState {
  final String error;

  const SponsorAdsFailure(this.error);

  @override
  List<Object> get props => [error];
}
