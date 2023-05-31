import 'package:freesms/data/models/contacts_model.dart';

import '../../../domain/repositories/contacts_read/read_contacts_repository.dart';
import '../../datasources/local/contacts_read/read_contacts_local_data_source.dart';

class ReadContactsRepositoryImpl implements ReadContactsRepository {

  final ReadContactsLocalDataSource readContactsLocalDataSource;

  ReadContactsRepositoryImpl({required this.readContactsLocalDataSource});

  @override
  Future<ContactsModel> readContacts(int offset, String contactsName) async {
    ContactsModel contacts = await readContactsLocalDataSource.readContacts(offset, contactsName);
    return contacts;
  }
  
}