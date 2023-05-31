import 'package:dartz/dartz.dart';
import 'package:freesms/data/models/contacts_model.dart';
import '../../../../presentation/shared/entities/failure.dart';
import '../../../../presentation/shared/utils/read_contacts.dart';


class ReadContactsLocalDataSourceImpl implements ReadContactsLocalDataSource {

  ReadContactsLocalDataSourceImpl();

  @override
  Future<ContactsModel> readContacts(int offset, String contactsName) async {
    Either<Failure, ContactsModel> response = await getContacts(offset, contactsName);
    return response.fold((failure) => throw Failure(failure.message), (res) => res);
  }
}

abstract class ReadContactsLocalDataSource {
   Future<ContactsModel> readContacts(int offset, String contactsName);
}