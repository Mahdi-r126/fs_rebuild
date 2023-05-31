// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import '../helpers/helpers.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../models/contact_entity.dart';
//
// late List<ContactEntity> _contacts = [];
// bool isSearch = false;
// List<SmsMessage> contacts = [];
//
// class Recent extends StatefulWidget{
//   const Recent({Key? key}) : super(key: key);
//
//   @override
//   State<Recent> createState() => _RecentState();
// }
//
// class _RecentState extends State<Recent> {
//   late int _pageNumber;
//   final int _numberOfContactsPerRequest = 10;
//   late bool _isLastPage;
//   late bool _loading;
//   late bool _error;
//   final int _nextPageTrigger = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _contacts = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     readContacts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder<List<SmsMessage>?>(
//           future: readSms(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.indigo,
//                 ),
//                 widthFactor: 15,
//                 heightFactor: 15,
//               );
//             } else {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 contacts = snapshot.data as List<SmsMessage>;
//                 return Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: SizedBox(
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) =>
//                             createSmsRow(context, snapshot, index)),
//                   ),
//                 );
//               }
//             }
//           }),
//     );
//
//   }
//
//   Future<void> readContacts() async {
//     List<ContactEntity> contacts = await getAllbyPagination(_pageNumber);
//     setState(() {
//       _isLastPage = contacts.length < _numberOfContactsPerRequest;
//       _loading = false;
//       _pageNumber = _pageNumber + 1;
//       _contacts!.addAll(contacts);
//     });
//   }
// }
//
// Future<List<SmsMessage>?> readSms() async {
//   bool permissionStatus = await permissionCheckAndRequest();
//   if(permissionStatus) {
//     SmsQuery query = SmsQuery();
//     List<SmsMessage> messages = await query.getAllSms;
//     return messages;
//   }
// }
//
// Widget createSmsRow(BuildContext context, AsyncSnapshot<List<SmsMessage>?> snapshot, int index) {
//   SmsMessage smsMessage = snapshot.data![index];
//   return Padding(
//     padding: const EdgeInsets.only(top: 20.0, right: 4.0, left: 4.0),
//     child: Neumorphic(
//       style: NeumorphicStyle(depth: 4, boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.circular(20))),),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width * .9,
//               padding: const EdgeInsets.all(4),
//               child:  Column(
//                 children: [
//                   Text(smsMessage.body.toString(), textDirection: TextDirection.rtl, textAlign: TextAlign.right,),
//                   Align(  alignment: Alignment.bottomLeft,
//                       child: Text(smsMessage.sender.toString().replaceAll('+98', '0'), textAlign: TextAlign.left, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 10, color: Colors.blueAccent),)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// Future<bool> permissionCheckAndRequest() async {
//   if (await Permission.sms.status.isDenied) {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.sms
//     ].request();
//     return Future.value(statuses[Permission.sms] == PermissionStatus.granted);
//   } else {
//     return Future.value(true);
//   }
// }