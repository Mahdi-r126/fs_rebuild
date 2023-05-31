import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contactValue = [];

  List<Contact> get getContact => _contactValue;

  set setContact(List<Contact> newValue) {
    _contactValue = newValue;
    notifyListeners();
  }
}