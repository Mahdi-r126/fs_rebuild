import 'package:freesms/data/datasources/remote/splash/check_version_remote_data_source.dart';
import 'package:freesms/models/audit_ads.dart';
import '../../../domain/repositories/audit_ads/get_ads_for_audit_repository.dart';
import '../../../domain/repositories/splash/check_version_repository.dart';
import '../../../domain/repositories/sponsor_ads/get_sponsor_ads_repository.dart';
import '../../datasources/remote/audit_ads/get_ads_for_audit_remote_data_source.dart';
import '../../datasources/remote/sponsor_ads/get_sponsor_ads_remote_data_source.dart';
import '../../models/ads_list_model.dart';
import '../../models/audit_ads_model.dart';

class GetSponsorAdsRepositoryImpl implements GetSponsorAdsRepository {

  final GetSponsorAdsRemoteDataSource getSponsorAdsRemoteDataSource;

  GetSponsorAdsRepositoryImpl({required this.getSponsorAdsRemoteDataSource});

  @override
  Future<AdsListModel> getSponsorAds() async {
    AdsListModel sponsorAds = await getSponsorAdsRemoteDataSource.getSponsorAds();
    return sponsorAds;
  }
  
}