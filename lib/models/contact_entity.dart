import 'dart:typed_data';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ContactEntity {
  @Id()
  int id = 0;
  @Index()
  String? uid;
  String? displayName;
  Uint8List? thumbnail;
  Uint8List? photo;
  Uint8List? photoOrThumbnail;
  bool? isStarred;
  Name? name;
  String? phones;
  String? emails;
  String? addresses;
  String? organizations;
  String? websites;
  String? socialMedias;
  String? events;
  String? notes;
  String? accounts;
  String? groups;
  bool? thumbnailFetched;
  bool? photoFetched;
  bool? isUnified;
  bool? propertiesFetched;

  ContactEntity();

  ContactEntity.name(
      {
        required this.uid,
        required this.displayName,
        required this.thumbnail,
        required this.photo,
        required this.photoOrThumbnail,
        required this.isStarred,
        required this.name,
        required this.phones,
        required this.emails,
        required this.addresses,
        required this.organizations,
        required this.websites,
        required this.socialMedias,
        required this.events,
        required this.notes,
        required this.accounts,
        required this.groups,
        required this.thumbnailFetched,
        required this.photoFetched,
        required this.isUnified,
        required this.propertiesFetched});
}
