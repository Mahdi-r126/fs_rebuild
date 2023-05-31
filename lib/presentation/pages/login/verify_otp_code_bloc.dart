import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login/save_tokens.dart';
import '../../../domain/usecases/login/verify_otp_code.dart';
import '../../../models/tokens.dart';
import '../../shared/entities/failure.dart';
import 'verify_otp_code_state.dart';

class VerifyOtpCodeBloc extends Cubit<VerifyOtpCodeState> {
  final VerifyOtpCode verOtpCode;
  final SaveTokens saveTokens;

  VerifyOtpCodeBloc({required this.verOtpCode, required this.saveTokens})
      : super(VerifyOtpCodeInitial());

  Future<void> verifyOtpCode(String phoneNumber, int otpCode) async {
    emit(VerifyOtpCodeLoading());
    try {
      Tokens tokens = await verOtpCode(phoneNumber, otpCode);
      saveTokens(tokens);
      emit(VerifyOtpCodeSuccess(isFirstLogin: tokens.isFirstLogin));
    } catch (e) {
      Failure failure = e as Failure;
      emit(VerifyOtpCodeFailure(failure.message));
    }
  }

  void resetState() {
    emit(VerifyOtpCodeInitial());
  }
}
