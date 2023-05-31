import '../../../data/models/contacts_model.dart';
import '../../repositories/contacts_read/read_contacts_repository.dart';

class ReadContacts {
final ReadContactsRepository readContactsRepository;

ReadContacts({required this.readContactsRepository});

Future<ContactsModel> call(int offset, String contactsName) async {
  return await readContactsRepository.readContacts(offset, contactsName);
}

}