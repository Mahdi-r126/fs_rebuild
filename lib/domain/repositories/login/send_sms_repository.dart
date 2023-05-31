abstract class SendSmsRepository {
  Future<bool> sendSms(String message, List<String> recipients);
}