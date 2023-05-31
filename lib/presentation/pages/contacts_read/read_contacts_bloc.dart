import 'package:bloc/bloc.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';
import '../../../../domain/usecases/contacts_read/read_contacts.dart';
import 'read_contacts_state.dart';

class ReadContactsBloc extends Cubit<ReadContactsState> {
  final ReadContacts redContacts;

  ReadContactsBloc({required this.redContacts})
      : super(ReadContactsInitial());

  Future<void> readContacts() async {
    emit(ReadContactsLoading());
    try {
      // int contactsNumber = await redContacts();
      // if (contactsNumber > 0) {
      //   emit(ReadContactsSuccess(contactsNumber));
      // } else {
      //   emit(const ReadContactsFailure('Some thing went wrong, do you have any contacts!'));
      // }
    } catch (e) {
      Failure failure = e as Failure;
      emit(ReadContactsFailure(failure.message));
    }
  }
}
