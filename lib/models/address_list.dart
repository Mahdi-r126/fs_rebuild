import 'package:flutter_contacts/flutter_contacts.dart';

class AddressList {
  List<Address> addressList;

  AddressList({required this.addressList});

  factory AddressList.fromJson(Map<String, dynamic> json) {
    var list = json['addresses'] as List;
    List<Address> addressList = list.map((i) => Address.fromJson(i)).toList();
    return AddressList(addressList: addressList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'addresses': addressList.map((x) => x.toJson()).toList(),
    });
  }
}