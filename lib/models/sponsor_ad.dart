class SponsorAd {
  String? adId;
  String text;
  String? additionalText;
  String themeId;
  String categoryId;
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
  String? status;

  SponsorAd({
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

  factory SponsorAd.fromJson(Map<String, dynamic> json) {
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
    var image = json['image'];
    var status = json['status'];

    return SponsorAd(
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
      'image': image,
      'status': status
    });
  }
}
