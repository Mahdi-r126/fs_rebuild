import 'package:flutter_contacts/flutter_contacts.dart';

class PhoneList {
  List<Phone> phoneList;

  PhoneList({required this.phoneList});

  factory PhoneList.fromJson(Map<String, dynamic> json) {
    var list = json['phones'] as List;
    List<Phone> phoneList = list.map((i) => Phone.fromJson(i)).toList();
    return PhoneList(phoneList: phoneList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'phones': phoneList.map((x) => x.toJson()).toList(),
    });
  }
}