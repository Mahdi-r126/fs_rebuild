import '../../../data/models/ads_list_model.dart';

abstract class GetSponsorAdsRepository {
  Future<AdsListModel> getSponsorAds();
}