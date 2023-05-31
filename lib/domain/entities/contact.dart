import 'dart:typed_data';

class Contact {
  final String name;
  final String phoneNumber;
  final Uint8List? photo;

  Contact(this.name, this.phoneNumber, this.photo);
}