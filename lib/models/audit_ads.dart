import 'package:freesms/models/sponsor_ad.dart';

class AuditAds {
  List<SponsorAd> adsList;

  AuditAds(
      {required this.adsList});

  factory AuditAds.fromJson(Map<String, dynamic> json) {

    var adsList = List<SponsorAd>.from((json['ads']).map((e) => SponsorAd.fromJson(e)).toList());
    var ads = adsList;
    return AuditAds(adsList: ads);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'ads': adsList,
    });
  }
}