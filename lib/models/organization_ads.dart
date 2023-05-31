

import 'ad.dart';

class OrganizationAds {
  List<Ad> solid;
  List<Ad> waiting;
  List<Ad> confirmed;


  OrganizationAds(
      {required this.solid,
      required this.waiting,
      required this.confirmed});

  factory OrganizationAds.fromJson(Map<String, dynamic> json) {

    var solidList = List<Ad>.from((json['solid']).map((e) => Ad.fromJson(e)).toList());
    var waitingList = List<Ad>.from((json['waiting']).map((e) => Ad.fromJson(e)).toList());
    var confirmedList = List<Ad>.from((json['confirmed']).map((e) => Ad.fromJson(e)).toList());
    var solid = solidList;
    var waiting = waitingList;
    var confirmed = confirmedList;
    return OrganizationAds(solid: solid, waiting: waiting, confirmed: confirmed);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'solid': solid,
      'waiting': waiting,
      'confirmed': confirmed
    });
  }
}