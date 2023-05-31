import '../../domain/entities/contacts.dart';
import 'contact_model.dart';

class ContactsModel extends Contacts{

  ContactsModel({required List<ContactModel> contacts}) : super(contacts);

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    var list = json['contacts'] as List;
    List<ContactModel> contactList = list.map((i) => ContactModel.fromJson(i)).toList();
    return ContactsModel(contacts: contactList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'contacts': contacts,
    });
  }
}