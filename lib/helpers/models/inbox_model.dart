// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../contactHelper.dart';

class InboxModel {
  int? id;
  int? threadId;
  String? address;
  String? body;
  bool? read;
  DateTime? date;
  DateTime? dateSent;
  bool? isRead;
  InboxModel();

  List<SmsMessage> messages = [];

  InboxModel.fromSmsMessages(SmsMessage message)
      : id = message.id,
        threadId = message.threadId,
        address = message.address,
        body = message.body,
        read = message.read,
        date = message.date,
        dateSent = message.dateSent,
        isRead = message.isRead;

  String? contactName() {
    return ContactHelper.getContactName(address!);
  }
}
