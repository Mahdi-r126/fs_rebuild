import '../../../data/models/ads_list_model.dart';
import '../../repositories/sponsor_ads/get_sponsor_ads_repository.dart';

class GetSponsorAds {
final GetSponsorAdsRepository getSponsorAdsRepository;

GetSponsorAds({required this.getSponsorAdsRepository});

Future<AdsListModel> call() async {
  return await getSponsorAdsRepository.getSponsorAds();
}

}