import 'package:equatable/equatable.dart';

abstract class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  List<Object> get props => [];
}

class SplashPageInitial extends SplashPageState {}

class SplashPageLoading extends SplashPageState {}

class SplashPageSuccess extends SplashPageState {
  final String result;

  const SplashPageSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SplashPageFailure extends SplashPageState {
  final String error;

  const SplashPageFailure(this.error);

  @override
  List<Object> get props => [error];
}
