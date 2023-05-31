
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:freesms/home_view/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../chat_constants.dart';

class MessagesScreen extends StatefulWidget {
  late String phoneNumber;

  MessagesScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController userTextController = TextEditingController();

    Future<bool> _handleBackButton() {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const HomeScreen()), (Route<dynamic> route) => false);
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder<List<SmsMessage>>(
                  stream: SmsQuery().getAllSms.asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            )),
                      );
                    }
                    // if (snapshot.hasData) {
                    List<SmsMessage> messages = snapshot.data!;
                    // Filter messages based on phone number
                    List<SmsMessage> senderMessages = messages
                        .where((msg) =>
                    msg.address == widget.phoneNumber &&
                        msg.kind == SmsMessageKind.sent)
                        .toList();
                    List<SmsMessage> receiverMessages = messages
                        .where((msg) =>
                    msg.address == widget.phoneNumber &&
                        msg.kind == SmsMessageKind.received)
                        .toList();

                    // Sort messages by date
                    senderMessages.sort((a, b) => b.date!.compareTo(a.date!));
                    receiverMessages.sort((a, b) => b.date!.compareTo(a.date!));

                    // Combine messages into a single list
                    List<SmsMessage> allMessages = [];
                    int senderIndex = 0, receiverIndex = 0;
                    while (senderIndex < senderMessages.length &&
                        receiverIndex < receiverMessages.length) {
                      if (senderMessages[senderIndex]
                          .date!
                          .isAfter(receiverMessages[receiverIndex].date!)) {
                        allMessages.add(senderMessages[senderIndex]);
                        senderIndex++;
                      } else {
                        allMessages.add(receiverMessages[receiverIndex]);
                        receiverIndex++;
                      }
                    }
                    while (senderIndex < senderMessages.length) {
                      allMessages.add(senderMessages[senderIndex]);
                      senderIndex++;
                    }
                    while (receiverIndex < receiverMessages.length) {
                      allMessages.add(receiverMessages[receiverIndex]);
                      receiverIndex++;
                    }

                    // Build list of messages
                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: allMessages.length,
                        itemBuilder: (context, index) {
                          SmsMessage message = allMessages[index];
                          String? sender = message.kind == SmsMessageKind.sent
                              ? 'Me'
                              : message.address;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: (message.kind == SmsMessageKind.sent)
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(sender!),
                                const SizedBox(
                                  height: 3,
                                ),
                                Material(
                                    borderRadius: (message.kind == SmsMessageKind.sent)
                                        ? const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    )
                                        : const BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                    elevation: 5,
                                    color: (message.kind == SmsMessageKind.sent)
                                        ? Colors.green
                                        : Colors.blue.shade900,
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          message.body!,
                                          style: TextStyle(
                                              color:
                                              (message.kind == SmsMessageKind.sent)
                                                  ? Colors.white
                                                  : Colors.white,
                                              fontFamily: "vazir",
                                              fontSize: 15),
                                        ))),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                //sendMessage widget
                Visibility(
                  visible: true,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 0),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1, right: 1),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                // focusNode: _focusNode,

                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black45),
                                controller: userTextController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                //expands: true,
                                // maxLength: 11,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFBDC0CE), width: 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                                  contentPadding: const EdgeInsets.all(10.0),
                                  hintText: AppLocalizations.of(context).message,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 1),
                            child: SizedBox(
                                width: 56,
                                height: 48,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF2C66FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15), // <-- Radius
                                    ), // HexColor("#F46D9D")
                                  ),
                                  onPressed: () {

                                  },
                                  child: const Icon(
                                    Icons.send,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/chat_images/user_2.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.phoneNumber,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
      actions: const [],
    );
  }
}
