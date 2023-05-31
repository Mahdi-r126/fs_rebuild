import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freesms/data/models/audit_ads_model.dart';
import 'package:freesms/data/models/contacts_model.dart';
import '../../../../domain/usecases/contacts_read/read_contacts.dart';
import '../../../shared/entities/failure.dart';
import 'read_contacts_state.dart';

class ReadContactsBloc extends Cubit<ReadContactsState> {
  final ReadContacts readContacts;

  ReadContactsBloc({required this.readContacts}) : super(ReadContactsInitial());

  Future<void> getContacts(int offset, String contactName) async {
    emit(ReadContactsLoading());
    try {
      ContactsModel contacts = await readContacts(offset, contactName);
      emit(ReadContactsSuccess(contacts));
    } catch (e) {
      Failure failure = e as Failure;
      emit(ReadContactsFailure(failure.message));
    }
  }

  // void resetState() {
  //   emit(AuditAdsInitial());
  // }
}
