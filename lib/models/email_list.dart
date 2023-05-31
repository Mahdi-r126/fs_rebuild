import 'ad.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class EmailList {
  List<Email> emailList;

  EmailList({required this.emailList});

  factory EmailList.fromJson(Map<String, dynamic> json) {
    var list = json['emails'] as List;
    List<Email> emailList = list.map((i) => Email.fromJson(i)).toList();
    return EmailList(emailList: emailList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'emails': emailList.map((x) => x.toJson()).toList(),
    });
  }
}