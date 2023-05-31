import 'organization.dart';

class Organizations {
  Organization organization;
  String accessToken;
  String refreshToken;


  Organizations(
      {required this.organization,
      required this.accessToken,
      required this.refreshToken});

  factory Organizations.fromJson(Map<String, dynamic> json) {
    var organization = Organization.fromJson(json['organization']);
    var accessToken = json['accessToken'];
    var refreshToken = json['refreshToken'];
    return Organizations(organization: organization, accessToken: accessToken, refreshToken: refreshToken);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'organization': organization,
      'accessToken': accessToken,
      'refreshToken': refreshToken
    });
  }
}