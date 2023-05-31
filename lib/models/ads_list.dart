import 'ad.dart';

class AdsList {
  List<Ad> adsList;


  AdsList({required this.adsList});

  factory AdsList.fromJson(Map<String, dynamic> json) {
    var list = json['ads'] as List;
    List<Ad> adsList = list.map((i) => Ad.fromJson(i)).toList();
    return AdsList(adsList: adsList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'ads': adsList.map((x) => x.toJson()).toList(),
    });
  }
}