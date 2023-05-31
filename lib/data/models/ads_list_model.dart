import '../../models/ad.dart';

class AdsListModel {
  List<Ad> adsList;


  AdsListModel({required this.adsList});

  factory AdsListModel.fromJson(Map<String, dynamic> json) {
    var list = json['ads'] as List;
    List<Ad> adsList = list.map((i) => Ad.fromJson(i)).toList();
    return AdsListModel(adsList: adsList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'ads': adsList.map((x) => x.toJson()).toList(),
    });
  }
}