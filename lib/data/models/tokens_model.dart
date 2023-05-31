import '../../domain/entities/tokens.dart';

class TokensModel extends Tokens{

  TokensModel({required String accessToken, required String refreshToken}) : super(accessToken: accessToken, refreshToken: refreshToken);

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    var accessToken = json['accessToken'];
    var refreshToken = json['refreshToken'];
    return TokensModel(accessToken: accessToken, refreshToken: refreshToken);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'accessToken': accessToken,
      'refreshToken': refreshToken
    });
  }
}