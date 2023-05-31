import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/repositories/login/send_sms_repository.dart';

class SendSmsRepositoryImpl implements SendSmsRepository {
  @override
  Future<bool> sendSms(String message, List<String> recipients) async {
    if (await permissionCheckAndRequest()) {
    await sendSMS(message: message, recipients: recipients, sendDirect: true)
        .catchError((onError) {
    return Future.value(onError.toString());
    });
    return Future.value(true);
    } else {
    return Future.value(false);
    }
  }
}

// help method
Future<bool> permissionCheckAndRequest() async {
  if (await Permission.sms.status.isDenied) {
    Map<Permission, PermissionStatus> statuses =
    await [Permission.sms].request();
    return Future.value(statuses[Permission.sms] == PermissionStatus.granted);
  } else {
    return Future.value(true);
  }
}