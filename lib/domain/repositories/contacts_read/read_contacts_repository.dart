import 'package:freesms/data/models/contacts_model.dart';

abstract class ReadContactsRepository {
  Future<ContactsModel> readContacts(int offset, String contactsName);
}