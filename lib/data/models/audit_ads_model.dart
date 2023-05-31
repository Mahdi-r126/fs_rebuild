import 'package:freesms/models/sponsor_ad.dart';

//TODO create entity later
class AuditAdsModel {
  List<SponsorAd> adsList;
  int totalItems;

  AuditAdsModel(
      {required this.adsList, required this.totalItems});

  factory AuditAdsModel.fromJson(Map<String, dynamic> json) {

    var adsList = List<SponsorAd>.from((json['ads']).map((e) => SponsorAd.fromJson(e)).toList());
    var ads = adsList;
    var totalItems = json['totalItems'];
    return AuditAdsModel(adsList: ads, totalItems: totalItems);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'ads': adsList,
      'totalItems': totalItems,
    });
  }
}