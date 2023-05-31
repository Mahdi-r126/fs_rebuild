import 'ad.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class WebsiteList {
  List<Website> websiteList;

  WebsiteList({required this.websiteList});

  factory WebsiteList.fromJson(Map<String, dynamic> json) {
    var list = json['websites'] as List;
    List<Website> websiteList = list.map((i) => Website.fromJson(i)).toList();
    return WebsiteList(websiteList: websiteList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'websites': websiteList.map((x) => x.toJson()).toList(),
    });
  }
}