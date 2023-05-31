import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/contacts.dart';
import '../models/event_list.dart';
import '../models/account_list.dart';
import '../models/address_list.dart';
import '../models/contact_entity.dart';
import '../models/group_list.dart';
import '../models/note_list.dart';
import '../models/organization_list.dart';
import '../models/phone_list.dart';
import '../models/email_list.dart';
import '../models/socialmedia_list.dart';
import '../models/website_list.dart';
import '../objectbox.g.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

Future<Contacts?> readContacts() async {
  if (await FlutterContacts.requestPermission()) {
    return Contacts(
        contacts: await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true));
  } else {
    return null;
  }
}

Future<List<ContactEntity>> contactsToEntities() async {
  Contacts? contacts = await readContacts();
  List<ContactEntity> contactEntities = contacts!.contacts.map((contact) {
    return ContactEntity.name(
      uid: contact.id,
      displayName: contact.displayName,
      thumbnail: contact.thumbnail,
      photo: contact.photo,
      photoOrThumbnail: contact.photoOrThumbnail,
      isStarred: contact.isStarred,
      name: contact.name,
      phones: json.encode(PhoneList(phoneList: contact.phones).toJson()),
      emails: json.encode(EmailList(emailList: contact.emails).toJson()),
      addresses: json.encode(AddressList(addressList: contact.addresses).toJson()),
      organizations: json.encode(OrganizationList(organizationList: contact.organizations).toJson()),
      websites: json.encode(WebsiteList(websiteList: contact.websites).toJson()),
      socialMedias: json.encode(SocialMediaList(socialMediaList: contact.socialMedias).toJson()),
      events: json.encode(EventList(eventList: contact.events).toJson()),
      notes: json.encode(NoteList(noteList: contact.notes).toJson()),
      accounts: json.encode(AccountList(accountList: contact.accounts).toJson()),
      groups: json.encode(GroupList(groupList: contact.groups).toJson()),
      thumbnailFetched: contact.thumbnailFetched,
      photoFetched: contact.photoFetched,
      isUnified: contact.isUnified,
      propertiesFetched: contact.propertiesFetched,
    );
  }).toList();
  return contactEntities;
}

Future<int> saveToDb() async {
  List<ContactEntity> contactEntities = await contactsToEntities();
  final store = await openStore();
  final contactBox = store.box<ContactEntity>();
  contactBox.removeAll();
  var res = contactBox.putMany(contactEntities).length;
  store.close();
  return res;
}

Future<List<ContactEntity>> getAllbyPagination(int page) async {
  final store = await openStore();
  final contactBox = store.box<ContactEntity>();
  Query<ContactEntity> query;
  query = contactBox.query().build();
  query.offset = page * 10;
  query.limit = 10;
  List<ContactEntity> contacts = query.find();
  store.close();
  return contacts;
}

Future<List<ContactEntity>> queryContacts(String searchTerm) async {
  final store = await openStore();
  final contactBox = store.box<ContactEntity>();
  Query<ContactEntity> query = contactBox.query(
      ContactEntity_.displayName.contains(searchTerm, caseSensitive: false) | ContactEntity_.phones.contains(searchTerm, caseSensitive: false)
  ).build();
  List<ContactEntity> contacts = query.find();
  store.close();
  return contacts;
}

// String formatDateTime(DateTime dateTime) {
//   DateTime now = DateTime.now();
//   DateTime today = DateTime(now.year, now.month, now.day);
//   DateFormat timeFormat = DateFormat('jm');
//   DateFormat dayFormat = DateFormat('EEEE');
//   final difference = now.difference(dateTime).inDays;
//
//   if (dateTime.isBefore(today)) {
//     return dayFormat.format(dateTime);
//   } else if (difference < 7) {
//     return timeFormat.format(dateTime);
//   } else{
//     return DateFormat.MMMd().format(dateTime);
//   }
// }

String formatDateTime(DateTime dateTime,bool time) {
  final now = DateTime.now();
  final difference = now.difference(dateTime).inDays;

  if (difference == 0 && dateTime.day==now.day) {
    return DateFormat.Hm().format(dateTime); // hour and minute
  } else if (difference <= 7) {
    return (time)?DateFormat.EEEE().format(dateTime).substring(0,3)+" - "+DateFormat.Hm().format(dateTime):
    DateFormat.EEEE().format(dateTime).substring(0,3); // day name
  } else if (difference > 7 && dateTime.year==now.year) {
    return (time)?DateFormat.MMMd().format(dateTime)+" - "+DateFormat.Hm().format(dateTime):
    DateFormat.MMMd().format(dateTime); // day name
  }
  else {
    return (time)?"${dateTime.year}/${dateTime.month}/${dateTime.day} - "+DateFormat.Hm().format(dateTime):
    "${dateTime.year}/${dateTime.month}/${dateTime.day}"; // month and day
  }
}
