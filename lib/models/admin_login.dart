
class AdminLogin{
  String accessToken;
  String refreshToken;

  AdminLogin(
      {required this.accessToken,
      required this.refreshToken});

  factory AdminLogin.fromJson(Map<String, dynamic> json) {
    var accessToken = json['accessToken'];
    var refreshToken = json['refreshToken'];
    return AdminLogin(accessToken: accessToken, refreshToken: refreshToken);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'accessToken': accessToken,
      'refreshToken': refreshToken
    });
  }
}