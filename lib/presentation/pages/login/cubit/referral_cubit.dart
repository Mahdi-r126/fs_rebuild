import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freesms/apis/apis.dart';

part 'referral_state.dart';

class ReferralCubit extends Cubit<ReferralState> {
  ReferralCubit({
    required this.api,
  }) : super(const ReferralState());

  final Apis api;

  Future<void> check(String code) async {
    emit(state.copyWith(checkingStatus: ReferralCheckingStatus.inProgress));

    try {
      final isValid = await api.checkReferralCode(code: code);
      if (isValid) {
        emit(state.copyWith(checkingStatus: ReferralCheckingStatus.success));
      } else {
        emit(state.copyWith(checkingStatus: ReferralCheckingStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(checkingStatus: ReferralCheckingStatus.failure));
    }
  }

  Future<void> send(String code) async {
    emit(state.copyWith(sendingStatus: ReferralSendingStatus.inProgress));

    try {
      final result = await api.checkReferralCode(code: code);
      if (result) {
        emit(state.copyWith(sendingStatus: ReferralSendingStatus.success));
      } else {
        emit(state.copyWith(sendingStatus: ReferralSendingStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(sendingStatus: ReferralSendingStatus.failure));
    }
  }

  void resetChecking(){
    emit(state.copyWith(checkingStatus: ReferralCheckingStatus.initial));
  }

}
