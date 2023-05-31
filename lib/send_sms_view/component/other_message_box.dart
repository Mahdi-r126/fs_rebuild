import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/constants.dart';
import '../../helpers/helpers.dart';
import 'message_type_detector.dart';

class OtherMessageBox extends StatelessWidget {
  const OtherMessageBox({Key? key, required this.message}) : super(key: key);

  final SmsMessage message;
  bool? isFishing() {
    for (String str in Constants.fishingContent) {
      if (message.body!.contains(str)) {
        return true;
      }
    }
    return null;
  }

  int getOtpAmount(){
    RegExp amountRegex_1 = RegExp(r'مبلغ:([\d,]+)');
    RegExp amountRegex_2 = RegExp(r'مبلغ:\s*([\d,]+)(?=\s*ريال)');
    RegExp amountRegex_3 = RegExp(r'مبلغ\s*([\d,]+)');

    
    RegExp passwordRegex = RegExp(r'رمز');
    bool hasPassword = passwordRegex.hasMatch(message.body!);
    if(hasPassword){
      if(amountRegex_1.firstMatch(message.body!)!=null){
        RegExpMatch? match = amountRegex_1.firstMatch(message.body!);
        String amountString = match!.group(1)!;
        int amount = int.tryParse(amountString.replaceAll(',', '')) ?? 0;
        getOtpColor(amount);
        return amount;
      }
      else if(amountRegex_2.firstMatch(message.body!)!=null){
        RegExpMatch? match = amountRegex_2.firstMatch(message.body!);
        String amountString = match!.group(1)!;
        int amount = int.tryParse(amountString.replaceAll(',', '')) ?? 0;
        getOtpColor(amount);
        return amount;
      }
      else if(amountRegex_3.firstMatch(message.body!)!=null){
        RegExpMatch? match = amountRegex_3.firstMatch(message.body!);
        String amountString = match!.group(1)!;
        int amount = int.tryParse(amountString.replaceAll(',', '')) ?? 0;
        getOtpColor(amount);
        return amount;
      }
    }
    else{
      return 0;
    }
    return 0;
  }

  Color getOtpColor(int amount){
    if(amount==0){
      return Colors.white;
    }
    if(amount>1 && amount<1000000){
      return Colors.green;
    }
    if(amount>=1000000 && amount<99999999){
      return Colors.yellow;
    }
    else{
      return Colors.red.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          elevation: 5,
          color: (isFishing() != null && isFishing()!)
              ? Colors.red.shade900
              : getOtpColor(getOtpAmount()),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MessageBox(
              message: message.body!,
              color: ((isFishing() != null && isFishing()!) || getOtpColor(getOtpAmount())==Colors.red.shade900)?Colors.white:Colors.black,
              onLinkTap: (value) async {

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

            // ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(formatDateTime(message.date!, true)/*+"|||"+getOtpAmount().toString()*/,
              style: TextStyle(color: Colors.blue.shade900, fontSize: 15)),
        ),
      ],
    );
  }
}
