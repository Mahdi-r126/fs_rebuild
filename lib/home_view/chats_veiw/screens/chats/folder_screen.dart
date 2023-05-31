import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freesms/helpers/helpers.dart';
import 'package:freesms/helpers/models/inbox_model.dart';
import 'package:freesms/send_sms_view/compose_message_screen.dart';
import 'package:toast/toast.dart';

import '../../../../apis/apis.dart';
import '../../../../helpers/smsHelper.dart';
import '../../../../helpers/string_helper.dart';

class FolderScreen extends StatefulWidget {
  Map<String, InboxModel> messages;
  FolderScreen({Key? key, required this.messages}) : super(key: key);
  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  late Map<String, InboxModel> lastMessages;
  late Offset tapPosition;

/*
  Future<Map<String, SmsMessage>> getAllSms() async {
     messages = await SmsQuery().querySms(
       kinds: [SmsQueryKind.sent,SmsQueryKind.inbox,SmsQueryKind.draft],//Sepehr
       address: null,
       count: 600,
       sort: true,
    );
     SharedPrefs.setAllMessage(await SmsQuery().querySms(
       kinds: [SmsQueryKind.sent,SmsQueryKind.inbox],
       count: 300,
     ),);
    for (SmsMessage message in messages) {
      String phoneNumber = message.address!;
      String myPhoneNumber=SharedPrefs.getPhoneNumber();

      if (!lastMessages.containsKey(phoneNumber) ||
          message.dateSent!.isAfter(lastMessages[phoneNumber]!.dateSent!)) {
        lastMessages[phoneNumber] = message;
        // lastBody[phoneNumber]=message;
      }
      // else{
      //   lastMessages[myPhoneNumber] = message;
      //   lastBody[myPhoneNumber]=message;
      // }
      allMessages.add(lastMessages);
    }
    SharedPrefs.setLastMessages(lastMessages);
    // Future.delayed(Duration(seconds: 30),() {
    //   SharedPrefs.setLastMessages(lastMessages);
    // },);
    return lastMessages;
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastMessages = widget.messages;
    // initSmsStream();
    SmsHelper.onListUpdated(updateMyInterface);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SmsHelper.removeOnListUpdated(updateMyInterface);
  }

  updateMyInterface() {
    setState(() {
      lastMessages = {};
      lastMessages = {...SmsHelper.messages};
    });
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    tapPosition = referenceBox.globalToLocal(details.globalPosition);
  }

  // Future<void> initSmsStream() async {
  //   telephony.listenIncomingSms(
  //     onNewMessage: (T.SmsMessage message) {
  //       print(message.address); //+977981******67, sender nubmer
  //       print(message.body); //sms text
  //       print(message.date); //1659690242000, timestamp
  //       setState(() {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (BuildContext context) => HomeScreen()));
  //       });
  //     },
  //     listenInBackground: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: lastMessages.length,
          itemBuilder: (context, index) {
            String phoneNumber = lastMessages.entries.toList()[index].key;
            InboxModel message = lastMessages[phoneNumber]!;

            return InkWell(
              onTap: () async {
                final res = await Navigator.push<Map<String, InboxModel>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComposeMessageScreen(
                          phoneNumber: phoneNumber,
                          contactName: message.contactName()!),
                    ));
                // updateMyInterface();
                if (res == null) {
                  return;
                }
                updateMyInterface();
                // setState(() {
                //   lastMessages = {...res, ...lastMessages};
                //   print('object');
                // });
              },
              onTapDown: (details) {
                _getTapPosition(details);
              },
              onLongPress: () {
                final RenderBox overlay = Overlay.of(context)
                    .context
                    .findRenderObject() as RenderBox;
                final menuItems = ['report spam'];
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      tapPosition.dx, tapPosition.dy + 80, 0, 0),
                  items: menuItems.map((String menuTitle) {
                    return PopupMenuItem<String>(
                      value: menuTitle,
                      child: Text(menuTitle),
                    );
                  }).toList(),
                ).then((value) async {
                  print(message.address);
                  Apis apis = Apis();
                  String response = await apis.reportSpamNumber(phoneNumber);
                  Toast.show(response,
                      backgroundColor: Colors.black87,
                      duration: 2,
                      textStyle: const TextStyle(color: Colors.white));
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: stringToColor(message.contactName()!),
                        child: Text(message.contactName()!.substring(0, 2),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message.contactName()!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(message.body!,
                            textDirection: getTextDirection(message.body!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: (message.isRead! == false)
                                    ? FontWeight.w900
                                    : FontWeight.normal)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(formatDateTime(message.date!, false),
                          style:
                              const TextStyle(fontSize: 16, color: Colors.black45)),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        )),
      ],
    );
  }
}
