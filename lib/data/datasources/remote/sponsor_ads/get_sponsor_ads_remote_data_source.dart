import 'package:dartz/dartz.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/models/ads_list.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';

import '../../../../helpers/constants.dart';
import '../../../models/ads_list_model.dart';

class GetSponsorAdsRemoteDataSourceImpl implements GetSponsorAdsRemoteDataSource {

  Apis api = Apis();

  GetSponsorAdsRemoteDataSourceImpl({required this.api});

  @override
  Future<AdsListModel> getSponsorAds() async {
    //TODO comment this and uncomment next
    // return AdsListModel.fromJson(Constants.defaultAds);

    Either<Failure, AdsListModel> response = await api.getSponsorAds();
    return response.fold((failure) => throw Failure(failure.message), (res) => res);
  }
}

abstract class GetSponsorAdsRemoteDataSource {
   Future<AdsListModel> getSponsorAds();
}