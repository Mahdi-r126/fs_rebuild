import 'package:equatable/equatable.dart';

abstract class VerifyOtpCodeState extends Equatable {
  const VerifyOtpCodeState();

  @override
  List<Object> get props => [];
}

class VerifyOtpCodeInitial extends VerifyOtpCodeState {}

class VerifyOtpCodeLoading extends VerifyOtpCodeState {}

class VerifyOtpCodeSuccess extends VerifyOtpCodeState {
  final bool isFirstLogin;

  const VerifyOtpCodeSuccess({this.isFirstLogin = true});

  @override
  List<Object> get props => [isFirstLogin];
}

class VerifyOtpCodeFailure extends VerifyOtpCodeState {
  final String error;

  const VerifyOtpCodeFailure(this.error);

  @override
  List<Object> get props => [error];
}
