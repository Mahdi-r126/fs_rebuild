import 'dart:typed_data';

import '../../domain/entities/contact.dart';
import '../../domain/entities/contacts.dart';

class ContactModel extends Contact{

  ContactModel({required String name, required String phoneNumber, Uint8List? photo}) : super(name, phoneNumber, photo);

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var phoneNumber = json['phoneNumber'];
    var photo = json['photo'];
    return ContactModel(name: name, phoneNumber: phoneNumber, photo: photo);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'name': name,
      'phoneNumber': phoneNumber,
      'photo': photo,
    });
  }
}