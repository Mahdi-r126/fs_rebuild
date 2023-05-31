class Tokens {
  String accessToken;
  String refreshToken;
  bool isFirstLogin;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstLogin,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    var accessToken = json['accessToken'];
    var refreshToken = json['refreshToken'];
    return Tokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      isFirstLogin: json['isFirstLogin'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from(
        {'accessToken': accessToken, 'refreshToken': refreshToken});
  }
}
