import 'package:equatable/equatable.dart';

abstract class ReadContactsState extends Equatable {
  const ReadContactsState();

  @override
  List<Object> get props => [];
}

class ReadContactsInitial extends ReadContactsState {}

class ReadContactsLoading extends ReadContactsState {}

class ReadContactsSuccess extends ReadContactsState {
  final int result;

  const ReadContactsSuccess(this.result);

  @override
  List<Object> get props => [result];
}

// TODO: add failure catch to helper methods if needed
class ReadContactsFailure extends ReadContactsState {
  final String error;

  const ReadContactsFailure(this.error);

  @override
  List<Object> get props => [error];
}
