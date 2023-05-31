class Ad {
  String? themeId;
  String? categoryId;
  String? text;
  String? status;
  bool? solid;
  int remainingOrderCount;
  List<String>? blackList;
  String? adId;
  String? additionalText;
  int fee;
  int orderCount;
  List<dynamic> targetPhoneNumbers;
  bool targetPhoneNumbersCanSent;
  bool targetPhoneNumbersCanReceive;
  int senderFee;
  int receiverFee;
  int maximumViewPerSender;
  int maximumViewPerReceiver;

  //TODO clear ? later when server become ok;
  String? startAt;
  String? endAt;
  List<dynamic> senderMobileTypes;
  List<dynamic> receiverMobileTypes;
  List<dynamic> senderOperators;
  List<dynamic> receiverOperators;
  List<dynamic> senderMobileNumbers;
  List<dynamic> receiverMobileNumbers;
  String image;

  Ad(
      {this.blackList,
      this.solid,
      required this.remainingOrderCount,
      this.adId,
      required this.text,
      this.additionalText,
      required this.themeId,
      required this.categoryId,
      required this.fee,
      required this.orderCount,
      required this.targetPhoneNumbers,
      required this.targetPhoneNumbersCanSent,
      required this.targetPhoneNumbersCanReceive,
      required this.senderFee,
      required this.receiverFee,
      required this.maximumViewPerSender,
      required this.maximumViewPerReceiver,
      this.startAt,
      this.endAt,
      required this.senderMobileTypes,
      required this.receiverMobileTypes,
      required this.senderOperators,
      required this.receiverOperators,
      required this.senderMobileNumbers,
      required this.receiverMobileNumbers,
      required this.image,
      this.status});

  factory Ad.fromJson(Map<String, dynamic> json) {
    var blackList = json['blackList'];
    var solid = json['solid'];
    var remainingOrderCount = json['remainingOrderCount'];
    var adId = json['adId'];
    var text = json['text'];
    var additionalText = json['additionalText'];
    var themeId = json['themeId'];
    var categoryId = json['categoryId'];
    var fee = json['fee'];
    var orderCount = json['orderCount'];
    var targetPhoneNumbers = json['targetPhoneNumbers'];
    var targetPhoneNumbersCanSent = json['targetPhoneNumbersCanSent'];
    var targetPhoneNumbersCanReceive = json['targetPhoneNumbersCanReceive'];
    var senderFee = json['senderFee'];
    var receiverFee = json['receiverFee'];
    var maximumViewPerSender = json['maximumViewPerSender'];
    var maximumViewPerReceiver = json['maximumViewPerReceiver'];
    var startAt = json['startAt'];
    var endAt = json['endAt'];
    var senderMobileTypes = json['senderMobileTypes'];
    var receiverMobileTypes = json['receiverMobileTypes'];
    var senderOperators = json['senderOperators'];
    var receiverOperators = json['receiverOperators'];
    var senderMobileNumbers = json['senderMobileNumbers'];
    var receiverMobileNumbers = json['receiverMobileNumbers'];
    var image = json['imageUrl'];
    var status = json['status'];

    return Ad(
        blackList: blackList,
        solid: solid,
        remainingOrderCount: remainingOrderCount,
        adId: adId,
        text: text,
        additionalText: additionalText,
        themeId: themeId,
        categoryId: categoryId,
        fee: fee,
        orderCount: orderCount,
        targetPhoneNumbers: targetPhoneNumbers,
        targetPhoneNumbersCanSent: targetPhoneNumbersCanSent,
        targetPhoneNumbersCanReceive: targetPhoneNumbersCanReceive,
        senderFee: senderFee,
        receiverFee: receiverFee,
        maximumViewPerSender: maximumViewPerSender,
        maximumViewPerReceiver: maximumViewPerReceiver,
        startAt: startAt,
        endAt: endAt,
        senderMobileTypes: senderMobileTypes,
        receiverMobileTypes: receiverMobileTypes,
        senderOperators: senderOperators,
        receiverOperators: receiverOperators,
        senderMobileNumbers: senderMobileNumbers,
        receiverMobileNumbers: receiverMobileNumbers,
        image: image,
        status: status);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'solid': solid,
      'remainingOrderCount': remainingOrderCount,
      'blackList': blackList,
      'adId': adId,
      'text': text,
      'additionalText': additionalText,
      'themeId': themeId,
      'categoryId': categoryId,
      'fee': fee,
      'orderCount': orderCount,
      'targetPhoneNumbers': targetPhoneNumbers,
      'targetPhoneNumbersCanSent': targetPhoneNumbersCanSent,
      'targetPhoneNumbersCanReceive': targetPhoneNumbersCanReceive,
      'senderFee': senderFee,
      'receiverFee': receiverFee,
      'maximumViewPerSender': maximumViewPerSender,
      'maximumViewPerReceiver': maximumViewPerReceiver,
      'startAt': startAt,
      'endAt': endAt,
      'senderMobileTypes': senderMobileTypes,
      'receiverMobileTypes': receiverMobileTypes,
      'senderOperators': senderOperators,
      'receiverOperators': receiverOperators,
      'senderMobileNumbers': senderMobileNumbers,
      'receiverMobileNumbers': receiverMobileNumbers,
      'imageUrl': image,
      'status': status
    });
  }
}

// class Ad {
//   String? adId;
//   String? themeId;
//   String? categoryId;
//   String image;
//   String? text;
//   String? additionalText;
//   int? fee;
//   String? status;
//   bool? solid;
//   int orderCount;
//   int remainingOrderCount;
//   List<String>? blackList;
//
//   Ad({required this.adId, required this.themeId, required this.categoryId, required this.image,
//     required this.text, required this.additionalText, this.fee, this.status, this.solid, required this.orderCount, required this.remainingOrderCount, this.blackList});
//
//   factory Ad.fromJson(Map<String, dynamic> json) {
//     var adId = json['adId'];
//     var themeId = json['themeId'];
//     var categoryId = json['categoryId'];
//     var image = json['image'];
//     var text = json['text'];
//     var additionalText = json['additionalText'];
//     var fee = json['fee'];
//     var status = json['status'];
//     var solid = json['solid'];
//     var orderCount = json['orderCount'];
//     var remainingOrderCount = json['remainingOrderCount'];
//     var blackList = json['blackList'];
//     return Ad(adId: adId, themeId: themeId, categoryId: categoryId, image: image,
//         text: text, additionalText: additionalText, fee: fee, status: status, solid: solid, orderCount: orderCount, remainingOrderCount: remainingOrderCount, blackList: blackList);  }
//
//   Map<String, dynamic> toJson() {
//     return Map<String, dynamic>.from({
//       'adId': adId,
//       'themeId': themeId,
//       'categoryId': categoryId,
//       'image': image,
//       'text': text,
//       'additionalText': additionalText,
//       'fee': fee,
//       'status': status,
//       'solid': solid,
//       'orderCount': orderCount,
//       'remainingOrderCount': remainingOrderCount,
//       'blackList': blackList
//     });
//   }
// }
