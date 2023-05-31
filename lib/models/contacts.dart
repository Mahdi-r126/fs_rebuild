import 'package:flutter_contacts/contact.dart';
class Contacts {
  List<Contact> contacts;

  Contacts({required this.contacts});

  factory Contacts.fromJson(Map<String, dynamic> json) {
    var list = json['contacts'] as List;
    List<Contact> contactsList = list.map((i) => Contact.fromJson(i)).toList();
    return Contacts(contacts: contactsList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'contacts': contacts.map((x) => x.toJson()).toList(),
    });
  }
}