import '../../repositories/login/send_sms_repository.dart';

class SendSms {
  final SendSmsRepository sendSmsRepository;

  SendSms({required this.sendSmsRepository});

  Future<bool> call(String message, List<String> recipients) async {
    return await sendSmsRepository.sendSms(message, recipients);
  }

}