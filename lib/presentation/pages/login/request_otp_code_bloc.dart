import 'package:bloc/bloc.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../domain/usecases/login/request_otp_code.dart';
import '../../../domain/usecases/login/send_sms.dart';
import 'request_otp_code_state.dart';

class RequestOtpCodeBloc extends Cubit<RequestOtpCodeState> {
  final RequestOtpCode reqOtpCode;
  final SendSms sendSms;

  RequestOtpCodeBloc({required this.reqOtpCode, required this.sendSms})
      : super(RequestOtpCodeInitial());

  Future<void> requestOtpCode(String phoneNumber,
      {String? refferalCode}) async {
    emit(RequestOtpCodeLoading());
    try {
      int otpCode = await reqOtpCode(phoneNumber, refferalCode: refferalCode);
      // get app signature, add it to sms to auto fill works properly
      String appSignature = await SmsAutoFill().getAppSignature;
      // customize message to send with otp code
      String otpMessage =
          'Welcome to SMS, Checking mobile number: $otpCode \n$appSignature';
      bool result = await sendSms(otpMessage, [phoneNumber]);
      if (result) {
        emit(RequestOtpCodeSuccess(result));
      } else {
        emit(const RequestOtpCodeFailure('Some thing went wrong'));
      }
    } catch (e) {
      Failure failure = e as Failure;
      emit(RequestOtpCodeFailure(failure.message));
    }
  }
}
