import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactHelper {
  static final List<Contact> _contacts = [];
  static final Map<String, Contact> _contactsCash = {};

  static Future<void> init() async {
    await _resetAllInbox();
  }

  static Future<void> _resetAllInbox() async {
    final data = await ContactsService.getContacts(withThumbnails: false);
    for(Contact contact in data){
      if(contact.phones!.isNotEmpty){
        _contacts.add(contact);
      }
    }
    print("oooo"+_contacts[0].displayName!);
  }

  static getAll() {
    return _contacts;
  }

  static Future<List<Contact>> queryContacts(String query) async {
    List<Contact> _contacts = await ContactsService.getContacts(query : query);
    return _contacts;
  }

  static List<String> getAllNumbers() {
    List<String> _numbers = [];
    // _numbers.add("+989127785180");
    // return _numbers;
    for (Contact contact in _contacts) {
      for (Item phone in contact.phones!) {
        _numbers.add(phone.value!);
      }
    }
    print(_numbers);
    return _numbers;
  }

  static getContactName(String address) {
    if (_contactsCash.containsKey(address)) {
      return _contactsCash[address]!.displayName;
    }
    String addressSubstring = clearNumber(address);
    for (Contact contact in _contacts) {
      for (Item phone in contact.phones!) {
        if (addressSubstring == clearNumber(phone.value!)) {
          _contactsCash[address] = contact;
          return contact.displayName;
        }
      }
    }
    Contact notSavedContact = Contact();
    notSavedContact.displayName = address;
    _contactsCash[address] = notSavedContact;
    return address;
  }

  /// Clear numbers line +98912-128- 12-12 > 9121281212
  static clearNumber(String address, {int substringLength = 10}) {
    address = address
        .replaceAll('-', '')
        .replaceAll('+', '')
        .replaceAll(')', '')
        .replaceAll('(', '')
        .replaceAll(' ', '');
    if(address.startsWith("98")){
      address=address.substring(2);
    }
    return address.substring(max(address.length - substringLength, 0));
  }

  static Future<bool> permissionCheckAndRequest() async {
    print('object');
    if (await Permission.contacts.status.isDenied) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.contacts].request();
      return Future.value(
          statuses[Permission.contacts] == PermissionStatus.granted);
    } else {
      return Future.value(true);
    }
  }

  static getContactId(String address) {
    if (_contactsCash.containsKey(address)) {
      return _contactsCash[address]!.identifier;
    }
    String addressSubstring = clearNumber(address);
    for (Contact contact in _contacts) {
      for (Item phone in contact.phones!) {
        if (addressSubstring == clearNumber(phone.value!)) {
          _contactsCash[address] = contact;
          return contact.identifier;
        }
      }
    }
    return null;
  }

  static isInContact(String phoneNumber){
    for (Contact contact in getAll()) {
      for (Item phone in contact.phones!) {
        if (clearNumber(phoneNumber) == clearNumber(phone.value!)) {
          return true;
        }
      }
    }
    return false;
  }
}
