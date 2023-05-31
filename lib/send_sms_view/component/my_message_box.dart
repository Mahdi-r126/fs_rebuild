import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:freesms/helpers/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

import 'message_type_detector.dart';

class MyMessageBox extends StatelessWidget {
  const MyMessageBox({Key? key, required this.message}) : super(key: key);

  final SmsMessage message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          elevation: 5,
          color: Colors.blue.shade700,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MessageBox(
              message: message.body!,
              color: Colors.white,
              onLinkTap: (value) async {
                print(Uri.parse(value));

                if (await canLaunchUrl(Uri.parse(value))) {
                  await launchUrl(Uri.parse(value),
                      mode: LaunchMode.externalApplication);
                }
              },
              onNumberTap: (value) async {
                final uri = Uri(scheme: 'tel', path: value);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              onUssdTap: (value) async {
                final uri = Uri(scheme: 'tel', path: value);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(formatDateTime(message.date!, true),
              style: TextStyle(color: Colors.blue.shade900, fontSize: 15)),
        ),
      ],
    );
  }
}
