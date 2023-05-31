import '../../../domain/repositories/sponsor_ads/get_sponsor_ads_repository.dart';
import '../../datasources/remote/sponsor_ads/get_sponsor_ads_remote_data_source.dart';
import '../../models/ads_list_model.dart';

class GetSponsorAdsRepositoryImpl implements GetSponsorAdsRepository {

  final GetSponsorAdsRemoteDataSource getSponsorAdsRemoteDataSource;

  GetSponsorAdsRepositoryImpl({required this.getSponsorAdsRemoteDataSource});

  @override
  Future<AdsListModel> getSponsorAds() async {
    AdsListModel sponsorAds = await getSponsorAdsRemoteDataSource.getSponsorAds();
    return sponsorAds;
  }
  
}