import 'dart:convert';

class Organization {
  String organizationId;
  String username;
  List<dynamic> confirmedAdsId;


  Organization(
      {required this.organizationId,
      required this.username,
      required this.confirmedAdsId});

  factory Organization.fromJson(Map<String, dynamic> json) {
    var organizationId = json['organizationId'];
    var username = json['username'];
    List<dynamic> adsId = json['confirmedAdsId'].map((e) => e).toList();
    var confirmedAdsId = adsId;
    return Organization(organizationId: organizationId, username: username, confirmedAdsId: confirmedAdsId);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'organizationId': organizationId,
      'username': username,
      'confirmedAdsId': confirmedAdsId
    });
  }
}