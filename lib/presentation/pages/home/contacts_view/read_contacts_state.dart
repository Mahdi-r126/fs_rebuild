import 'package:equatable/equatable.dart';
import 'package:freesms/data/models/contacts_model.dart';

abstract class ReadContactsState extends Equatable {
  const ReadContactsState();

  @override
  List<Object> get props => [];
}

class ReadContactsInitial extends ReadContactsState {}

class ReadContactsLoading extends ReadContactsState {}

class ReadContactsSuccess extends ReadContactsState {
final ContactsModel contacts;
  const ReadContactsSuccess(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ReadContactsFailure extends ReadContactsState {
  final String error;

  const ReadContactsFailure(this.error);

  @override
  List<Object> get props => [error];
}
