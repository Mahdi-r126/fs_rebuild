import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/ads_list_model.dart';
import '../../../domain/usecases/sponsor_ads/get_sponsor_ads.dart';
import '../../shared/entities/failure.dart';
import 'sponsor_ads_state.dart';

class SponsorAdsBloc extends Cubit<SponsorAdsState> {
  final GetSponsorAds getSponsorAds;

  SponsorAdsBloc({required this.getSponsorAds}) : super(SponsorAdsInitial());

  Future<void> getAdsOfSponsor() async {
    emit(SponsorAdsLoading());
    try {
      AdsListModel adsList = await getSponsorAds();
      emit(SponsorAdsSuccess(adsList));
    } catch (e) {
      Failure failure = e as Failure;
      emit(SponsorAdsFailure(failure.message));
    }
  }
  //
  // void resetState() {
  //   emit(AuditAdsInitial());
  // }
}
