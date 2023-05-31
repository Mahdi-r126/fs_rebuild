import 'ad.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AccountList {
  List<Account> accountList;

  AccountList({required this.accountList});

  factory AccountList.fromJson(Map<String, dynamic> json) {
    var list = json['accounts'] as List;
    List<Account> accountList = list.map((i) => Account.fromJson(i)).toList();
    return AccountList(accountList: accountList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'accounts': accountList.map((x) => x.toJson()).toList(),
    });
  }
}