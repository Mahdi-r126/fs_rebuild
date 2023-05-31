import 'package:equatable/equatable.dart';

abstract class RequestOtpCodeState extends Equatable {
  const RequestOtpCodeState();

  @override
  List<Object> get props => [];
}

class RequestOtpCodeInitial extends RequestOtpCodeState {}

class RequestOtpCodeLoading extends RequestOtpCodeState {}

class RequestOtpCodeSuccess extends RequestOtpCodeState {
  final bool result;

  const RequestOtpCodeSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class RequestOtpCodeFailure extends RequestOtpCodeState {
  final String error;

  const RequestOtpCodeFailure(this.error);

  @override
  List<Object> get props => [error];
}
