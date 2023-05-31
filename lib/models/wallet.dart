class Wallet {
  String userId;
  String phoneNumber;
  int wallet;
  int totalMessages;

  Wallet({required this.userId, required this.phoneNumber, required this.wallet, required this.totalMessages});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    var userId = json["user"]['userId'];
    var phoneNumber = json["user"]['phoneNumber'];
    var wallet = json["user"]['wallet'];
    var totalMessages = json['totalMessages'];
    return Wallet(userId: userId, phoneNumber: phoneNumber, wallet: wallet, totalMessages: totalMessages);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'userId': userId,
      'phoneNumber': phoneNumber,
      'wallet': wallet,
      'totalMessages': totalMessages
    });
  }
}