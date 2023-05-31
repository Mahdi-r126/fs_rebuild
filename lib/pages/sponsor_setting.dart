// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// //import 'package:jalali_calendar/jalali_calendar.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:file_picker/file_picker.dart';
// import '../helpers/constants.dart';
// import 'package:excel/excel.dart';
//
// class SponsorSetting extends StatefulWidget {
//
//   const SponsorSetting(
//
//       {Key? key})
//       : super(key: key);
//
//   @override
//   State<SponsorSetting> createState() => _SponsorSettingState();
// }
//
// class _SponsorSettingState extends State<SponsorSetting> {
//   static const int TARGET_PHONE_NUMBER_CAN_SENT = 3;
//   static const int TARGET_PHONE_NUMBER_CAN_NOT_SENT = 4;
//   static const int TARGET_PHONE_NUMBER_CAN_RECEIVE = 5;
//   static const int TARGET_PHONE_NUMBER_CAN_NOT_RECEIVE = 6;
//   int _senderRepeatTime = Constants.sponsorAdsSetting['maximumViewPerSender'];
//   int _receiverRepeatTime = Constants.sponsorAdsSetting['maximumViewPerReceiver'];
//   Object _targetPhoneNumberCanSentGroupValue = Constants.sponsorAdsSetting['targetPhoneNumberCanSent'] ? 3 : 4;
//   Object _targetPhoneNumberCanReceiveGroupValue = Constants.sponsorAdsSetting['targetPhoneNumberCanReceive'] ? 5 : 6;
//   final TextEditingController _targetPhoneNumbersTextController = TextEditingController();
//   var _payForTargetPhoneNumberAsSenderAdSlider = Constants.sponsorAdsSetting['senderFee'];
//   var _payForTargetPhoneNumberAsReceiverAdSlider = Constants.sponsorAdsSetting['receiverFee'];
//   bool _hamrahAvalCheckSender = Constants.sponsorAdsSetting['senderOperatorTypes'].contains('Hamrah aval');
//   bool _irancellCheckSender = Constants.sponsorAdsSetting['senderOperatorTypes'].contains('Irancell');
//   bool _rightelCheckSender = Constants.sponsorAdsSetting['senderOperatorTypes'].contains('Rightel');
//   bool _hamrahAvalCheckReceiver = Constants.sponsorAdsSetting['receiverOperatorTypes'].contains('Hamrah aval');
//   bool _irancellCheckReceiver = Constants.sponsorAdsSetting['receiverOperatorTypes'].contains('Irancell');
//   bool _rightelCheckReceiver = Constants.sponsorAdsSetting['receiverOperatorTypes'].contains('Rightel');
//   bool _0912CheckSender = Constants.sponsorAdsSetting['senderMobileNumbers'].contains('0912');
//   bool _0915CheckSender = Constants.sponsorAdsSetting['senderMobileNumbers'].contains('0915');
//   bool _0935CheckSender = Constants.sponsorAdsSetting['senderMobileNumbers'].contains('0935');
//   bool _0912CheckReceiver = Constants.sponsorAdsSetting['receiverMobileNumbers'].contains('0912');
//   bool _0915CheckReceiver = Constants.sponsorAdsSetting['receiverMobileNumbers'].contains('0915');
//   bool _0935CheckReceiver = Constants.sponsorAdsSetting['receiverMobileNumbers'].contains('0935');
//   bool _samsungCheckSender = Constants.sponsorAdsSetting['senderMobileTypes'].contains('Samsung');
//   bool _sonyCheckSender = Constants.sponsorAdsSetting['senderMobileTypes'].contains('Sony');
//   bool _xiaomiCheckSender = Constants.sponsorAdsSetting['senderMobileTypes'].contains('Xiaomi');
//   bool _iPhoneCheckSender = Constants.sponsorAdsSetting['senderMobileTypes'].contains('iPhone');
//   bool _huaweiCheckSender = Constants.sponsorAdsSetting['senderMobileTypes'].contains('Huawei');
//   bool _samsungCheckReceiver = Constants.sponsorAdsSetting['receiverMobileTypes'].contains('Samsung');
//   bool _sonyCheckReceiver = Constants.sponsorAdsSetting['receiverMobileTypes'].contains('Sony');
//   bool _xiaomiCheckReceiver = Constants.sponsorAdsSetting['receiverMobileTypes'].contains('Xiaomi');
//   bool _iPhoneCheckReceiver = Constants.sponsorAdsSetting['receiverMobileTypes'].contains('iPhone');
//   bool _huaweiCheckReceiver = Constants.sponsorAdsSetting['receiverMobileTypes'].contains('Huawei');
//
//   var from = Constants.sponsorAdsSetting['isoFrom'];
//   var to = Constants.sponsorAdsSetting['isoTo'];
//
//   @override
//   Widget build(BuildContext context) {
//     _targetPhoneNumbersTextController.text = Constants.sponsorAdsSetting['targetPhoneNumbers'].join(", ");
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             AppLocalizations
//                 .of(context)
//                 .sponsorAdvanceSetting,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Center(
//                   child: Neumorphic(
//                       padding: const EdgeInsets.all(8),
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).maximumViewPerSender,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           NumberPicker(
//                             value: _senderRepeatTime,
//                             minValue: 1,
//                             maxValue: 100,
//                             itemHeight: 50,
//                             axis: Axis.horizontal,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 border:
//                                 Border.all(width: 1, color: Colors.grey),
//                                 borderRadius:
//                                 const BorderRadius.all(Radius.circular(8))),
//                             selectedTextStyle: const TextStyle(
//                                 fontSize: 25, color: Colors.blueAccent),
//                             onChanged: (value) =>
//                                 setState(() {
//                                   _senderRepeatTime = value;
//                                   Constants.sponsorAdsSetting['maximumViewPerSender'] = value;
//                                 }),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                            Text(
//                              AppLocalizations.of(context).maximumViewPerReceiver,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           NumberPicker(
//                             value: _receiverRepeatTime,
//                             minValue: 1,
//                             maxValue: 100,
//                             itemHeight: 50,
//                             axis: Axis.horizontal,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 border:
//                                 Border.all(width: 1, color: Colors.grey),
//                                 borderRadius:
//                                 const BorderRadius.all(Radius.circular(8))),
//                             selectedTextStyle: const TextStyle(
//                                 fontSize: 25, color: Colors.blueAccent),
//                             onChanged: (value) =>
//                                 setState(() {
//                                   _receiverRepeatTime = value;
//                                   Constants.sponsorAdsSetting['maximumViewPerReceiver'] = value;
//                                 }),
//                           ),
//                           // const Text(
//                           //   'from?',
//                           //   style: TextStyle(
//                           //       fontWeight: FontWeight.bold, fontSize: 15),
//                           // ),
//                           // const SizedBox(
//                           //   height: 20,
//                           // ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.center,
//                           //   children: <Widget>[
//                           //     NeumorphicRadio(
//                           //       child: const SizedBox(
//                           //         height: 50,
//                           //         width: 120,
//                           //         child: Center(
//                           //           child: Text("Same Sender",
//                           //               style: TextStyle(
//                           //                   fontWeight: FontWeight.bold)),
//                           //         ),
//                           //       ),
//                           //       value: SAME_SENDER,
//                           //       groupValue: _sameSenderGroupValue,
//                           //       onChanged: (value) {
//                           //         setState(() {
//                           //           _sameSenderGroupValue = value!;
//                           //         });
//                           //       },
//                           //     ),
//                           //     const SizedBox(
//                           //       width: 20,
//                           //     ),
//                           //     NeumorphicRadio(
//                           //       child: const SizedBox(
//                           //         height: 50,
//                           //         width: 120,
//                           //         child: Center(
//                           //           child: Text("Different Sender",
//                           //               style: TextStyle(
//                           //                   fontWeight: FontWeight.bold)),
//                           //         ),
//                           //       ),
//                           //       value: DIFFRENT_SENDER,
//                           //       groupValue: _sameSenderGroupValue,
//                           //       onChanged: (value) {
//                           //         setState(() {
//                           //           _sameSenderGroupValue = value!;
//                           //         });
//                           //       },
//                           //     ),
//                           //   ],
//                           // )
//                         ],
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                     child: Neumorphic(
//                         padding: const EdgeInsets.all(8),
//                         style: NeumorphicStyle(
//                             boxShape: NeumorphicBoxShape.roundRect(
//                                 const BorderRadius.all(Radius.circular(8)))),
//                         child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: 60,
//                                   child: TextButton(
//                                     child: const Text('Excel',
//                                         style: TextStyle(
//                                             fontSize: 15),
//                                         textAlign: TextAlign.center),
//                                     style: TextButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: Colors.green,
//                                         padding: const EdgeInsets.only(
//                                             right: 5, left: 5),
//                                         alignment: Alignment.center,
//                                         fixedSize: const Size.fromWidth(
//                                             150),
//                                         shadowColor: Colors.grey,
//                                         elevation: 2),
//                                     onPressed: () async {
//                                       File? file = await _pickExcelFile();
//                                       if(file != null) {
//                                         List<String>? phoneNumbers = readExcelFile(file);
//                                         if(phoneNumbers != null) {
//                                           try {
//                                             Constants.sponsorAdsSetting['targetPhoneNumbers'] =
//                                                 phoneNumbers;
//                                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                                 content: Text('Saved successfully')
//                                             ));
//                                           } catch (e) {
//                                             Constants.sponsorAdsSetting['targetPhoneNumbers'] = [];
//                                           }
//                                         } else {
//                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                               content: Text('Excel data is invalid')
//                                           ));
//                                         }
//                                       } else {
//                                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                             content: Text('File not selected')
//                                         ));
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Text(
//                                   AppLocalizations
//                                       .of(context)
//                                       .targetListNumbers,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   width: 60,
//                                   child: TextButton(
//                                     child: const Text('Save',
//                                         style: TextStyle(
//                                             fontSize: 15),
//                                         textAlign: TextAlign.center),
//                                     style: TextButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: Colors.blue,
//                                         padding: const EdgeInsets.only(
//                                             right: 5, left: 5),
//                                         alignment: Alignment.center,
//                                         fixedSize: const Size.fromWidth(
//                                             150),
//                                         shadowColor: Colors.grey,
//                                         elevation: 2),
//                                     onPressed: () {
//                                       if (_targetPhoneNumbersTextController
//                                           .text.isNotEmpty) {
//                                         try {
//                                           Constants.sponsorAdsSetting['targetPhoneNumbers'] =
//                                               _targetPhoneNumbersTextController
//                                                   .text
//                                                   .split(',');
//                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                             content: Text('Saved successfully')
//                                           ));
//                                         } catch (e) {
//                                           Constants.sponsorAdsSetting['targetPhoneNumbers'] = [];
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             const Text(
//                               'Tip: paste comma separated numbers (eg: 0915*******, 0901*******)',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 10),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Neumorphic(
//                               style: NeumorphicStyle(
//                                   depth: -5,
//                                   boxShape: NeumorphicBoxShape.roundRect(
//                                       const BorderRadius.all(
//                                           Radius.circular(20)))),
//                               child: TextFormField(
//                                 controller: _targetPhoneNumbersTextController,
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.only(
//                                       right: 10.0,
//                                       top: 20.0,
//                                       bottom: 20.0,
//                                       left: 10.0),
//                                   alignLabelWithHint: true,
//                                   hintText: 'Paste list here ...',
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Row(
//                                   children: [
//                                     NeumorphicRadio(
//                                       child: SizedBox(
//                                         height: 50,
//                                         width: 50,
//                                         child: Center(
//                                           child:
//                                           _targetPhoneNumberCanSentGroupValue ==
//                                               TARGET_PHONE_NUMBER_CAN_SENT
//                                               ? const Icon(Icons.check)
//                                               : null,
//                                         ),
//                                       ),
//                                       value: TARGET_PHONE_NUMBER_CAN_SENT,
//                                       groupValue:
//                                       _targetPhoneNumberCanSentGroupValue,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _targetPhoneNumberCanSentGroupValue =
//                                           value!;
//                                           Constants.sponsorAdsSetting['targetPhoneNumberCanSent'] =
//                                           true;
//                                         });
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     const Text("These numbers can only send this Ad", style: TextStyle(fontSize: 13)),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(children: [
//                                   NeumorphicRadio(
//                                     child: SizedBox(
//                                       height: 50,
//                                       width: 50,
//                                       child: Center(
//                                         child: _targetPhoneNumberCanSentGroupValue ==
//                                             TARGET_PHONE_NUMBER_CAN_NOT_SENT
//                                             ? const Icon(Icons.check)
//                                             : null,
//                                       ),
//                                     ),
//                                     value: TARGET_PHONE_NUMBER_CAN_NOT_SENT,
//                                     groupValue:
//                                     _targetPhoneNumberCanSentGroupValue,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _targetPhoneNumberCanSentGroupValue =
//                                         value!;
//                                         Constants.sponsorAdsSetting['targetPhoneNumberCanSent'] = false;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   const Text(
//                                       "These numbers can NOT send this Ad", style: TextStyle(fontSize: 13)),
//                                 ]),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text(
//                               "The fee for these numbers only are",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                                 '${(Constants.sponsorAdsSetting['senderFee'])}  ${AppLocalizations
//                                     .of(context)
//                                     .toman}',
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold)),
//                             Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: NeumorphicSlider(
//                                 height: 20,
//                                 value: double.parse((Constants.sponsorAdsSetting['senderFee'] / 100).toString()),
//                                 style: const SliderStyle(depth: 4),
//                                 min: 1,
//                                 max: 10,
//                                 sliderHeight: 10,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     Constants.sponsorAdsSetting['senderFee'] =
//                                         (value.toInt()) * 100;
//                                     _payForTargetPhoneNumberAsSenderAdSlider =
//                                         (value.toInt()) * 100;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Row(
//                                   children: [
//                                     NeumorphicRadio(
//                                       child: SizedBox(
//                                         height: 50,
//                                         width: 50,
//                                         child: Center(
//                                           child: _targetPhoneNumberCanReceiveGroupValue ==
//                                               TARGET_PHONE_NUMBER_CAN_RECEIVE
//                                               ? const Icon(Icons.check)
//                                               : null,
//                                         ),
//                                       ),
//                                       value: TARGET_PHONE_NUMBER_CAN_RECEIVE,
//                                       groupValue:
//                                       _targetPhoneNumberCanReceiveGroupValue,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _targetPhoneNumberCanReceiveGroupValue =
//                                           value!;
//                                           Constants.sponsorAdsSetting['targetPhoneNumberCanReceive'] =
//                                           true;
//                                         });
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     const Text(
//                                         "These numbers can only receive this Ad", style: TextStyle(fontSize: 13)),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(children: [
//                                   NeumorphicRadio(
//                                     child: SizedBox(
//                                       height: 50,
//                                       width: 50,
//                                       child: Center(
//                                         child: _targetPhoneNumberCanReceiveGroupValue ==
//                                             TARGET_PHONE_NUMBER_CAN_NOT_RECEIVE
//                                             ? const Icon(Icons.check)
//                                             : null,
//                                       ),
//                                     ),
//                                     value: TARGET_PHONE_NUMBER_CAN_NOT_RECEIVE,
//                                     groupValue:
//                                     _targetPhoneNumberCanReceiveGroupValue,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _targetPhoneNumberCanReceiveGroupValue =
//                                         value!;
//                                         Constants.sponsorAdsSetting['targetPhoneNumberCanReceive'] =
//                                         false;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   const Text(
//                                       "These numbers can NOT receive this Ad", style: TextStyle(fontSize: 13)),
//                                 ]),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text(
//                               "The fee for these numbers only are",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                                 '${(Constants.sponsorAdsSetting['receiverFee'])}  ${AppLocalizations
//                                     .of(context)
//                                     .toman}',
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold)),
//                             Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: NeumorphicSlider(
//                                 height: 20,
//                                 value: double.parse((Constants.sponsorAdsSetting['receiverFee'] / 100).toString()),
//                                 style: const SliderStyle(depth: 4),
//                                 min: 1,
//                                 max: 10,
//                                 sliderHeight: 10,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     Constants.sponsorAdsSetting['receiverFee'] =
//                                         (value.toInt()) * 100;
//                                     _payForTargetPhoneNumberAsReceiverAdSlider =
//                                         (value.toInt()) * 100;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ))),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                     child: Neumorphic(
//                       padding: const EdgeInsets.all(8),
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'Mobile number',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these operators can send this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _hamrahAvalCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .contains('Hamrah aval')) {
//                                           Constants.sponsorAdsSetting['senderOperatorTypes'].add(
//                                               'Hamrah aval');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .remove('Hamrah aval');
//                                       }
//                                       setState(() {
//                                         _hamrahAvalCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Hamrah aval')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _irancellCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .contains('Irancell')) {
//                                           Constants.sponsorAdsSetting['senderOperatorTypes'].add(
//                                               'Irancell');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .remove('Irancell');
//                                       }
//                                       setState(() {
//                                         _irancellCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Irancell')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _rightelCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .contains('Rightel')) {
//                                           Constants.sponsorAdsSetting['senderOperatorTypes'].add(
//                                               'Rightel');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderOperatorTypes']
//                                             .remove('Rightel');
//                                       }
//                                       setState(() {
//                                         _rightelCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Rightel')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these operators can receive this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _hamrahAvalCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .contains('Hamrah aval')) {
//                                           Constants.sponsorAdsSetting['receiverOperatorTypes'].add(
//                                               'Hamrah aval');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .remove('Hamrah aval');
//                                       }
//                                       setState(() {
//                                         _hamrahAvalCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Hamrah aval')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _irancellCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .contains('Irancell')) {
//                                           Constants.sponsorAdsSetting['receiverOperatorTypes'].add(
//                                               'Irancell');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .remove('Irancell');
//                                       }
//                                       setState(() {
//                                         _irancellCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Irancell')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _rightelCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .contains('Rightel')) {
//                                           Constants.sponsorAdsSetting['receiverOperatorTypes'].add(
//                                               'Rightel');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverOperatorTypes']
//                                             .remove('Rightel');
//                                       }
//                                       setState(() {
//                                         _rightelCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Rightel')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these type of numbers can send this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0912CheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .contains('0912')) {
//                                           Constants.sponsorAdsSetting['senderMobileNumbers'].add(
//                                               '0912');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .remove('0912');
//                                       }
//                                       setState(() {
//                                         _0912CheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0912')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0915CheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .contains('0915')) {
//                                           Constants.sponsorAdsSetting['senderMobileNumbers'].add(
//                                               '0915');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .remove('0915');
//                                       }
//                                       setState(() {
//                                         _0915CheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0915')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0935CheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .contains('0935')) {
//                                           Constants.sponsorAdsSetting['senderMobileNumbers'].add(
//                                               '0935');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileNumbers']
//                                             .remove('0935');
//                                       }
//                                       setState(() {
//                                         _0935CheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0935')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these type of numbers can receive this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0912CheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .contains('0912')) {
//                                           Constants.sponsorAdsSetting['receiverMobileNumbers'].add(
//                                               '0912');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .remove('0912');
//                                       }
//                                       setState(() {
//                                         _0912CheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0912')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0915CheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .contains('0915')) {
//                                           Constants.sponsorAdsSetting['receiverMobileNumbers'].add(
//                                               '0915');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .remove('0915');
//                                       }
//                                       setState(() {
//                                         _0915CheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0915')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _0935CheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .contains('0935')) {
//                                           Constants.sponsorAdsSetting['receiverMobileNumbers'].add(
//                                               '0935');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileNumbers']
//                                             .remove('0935');
//                                       }
//                                       setState(() {
//                                         _0935CheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('0935')
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                     child: Neumorphic(
//                       padding: const EdgeInsets.all(8),
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'Mobile type',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these type of device mobile can send this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _samsungCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .contains('Samsung')) {
//                                           Constants.sponsorAdsSetting['senderMobileTypes'].add(
//                                               'Samsung');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .remove('Samsung');
//                                       }
//                                       setState(() {
//                                         _samsungCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Samsung')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _sonyCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .contains('Sony')) {
//                                           Constants.sponsorAdsSetting['senderMobileTypes'].add(
//                                               'Sony');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileTypes'].remove(
//                                             'Sony');
//                                       }
//                                       setState(() {
//                                         _sonyCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Sony')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _xiaomiCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .contains('Xiaomi')) {
//                                           Constants.sponsorAdsSetting['senderMobileTypes'].add(
//                                               'Xiaomi');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileTypes'].remove(
//                                             'Xiaomi');
//                                       }
//                                       setState(() {
//                                         _xiaomiCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Xiaomi')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _iPhoneCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .contains('iPhone')) {
//                                           Constants.sponsorAdsSetting['senderMobileTypes'].add(
//                                               'iPhone');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileTypes'].remove(
//                                             'iPhone');
//                                       }
//                                       setState(() {
//                                         _iPhoneCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('iPhone')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _huaweiCheckSender,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['senderMobileTypes']
//                                             .contains('Huawei')) {
//                                           Constants.sponsorAdsSetting['senderMobileTypes'].add(
//                                               'Huawei');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['senderMobileTypes'].remove(
//                                             'Huawei');
//                                       }
//                                       setState(() {
//                                         _huaweiCheckSender = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Huawei')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Only these type of numbers can receive this Ad",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _samsungCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileTypes']
//                                             .contains('Samsung')) {
//                                           Constants.sponsorAdsSetting['receiverMobileTypes'].add(
//                                               'Samsung');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileTypes'].remove(
//                                             'Samsung');
//                                       }
//                                       setState(() {
//                                         _samsungCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Samsung')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _sonyCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileTypes']
//                                             .contains('Sony')) {
//                                           Constants.sponsorAdsSetting['receiverMobileTypes'].add(
//                                               'Sony');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileTypes'].remove(
//                                             'Sony');
//                                       }
//                                       setState(() {
//                                         _sonyCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Sony')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _xiaomiCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileTypes']
//                                             .contains('Xiaomi')) {
//                                           Constants.sponsorAdsSetting['receiverMobileTypes'].add(
//                                               'Xiaomi');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileTypes'].remove(
//                                             'Xiaomi');
//                                       }
//                                       setState(() {
//                                         _xiaomiCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Xiaomi')
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _iPhoneCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileTypes']
//                                             .contains('iPhone')) {
//                                           Constants.sponsorAdsSetting['receiverMobileTypes'].add(
//                                               'iPhone');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileTypes'].remove(
//                                             'iPhone');
//                                       }
//                                       setState(() {
//                                         _iPhoneCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('iPhone')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   NeumorphicCheckbox(
//                                     margin: const EdgeInsets.all(5),
//                                     value: _huaweiCheckReceiver,
//                                     onChanged: (value) {
//                                       if (value) {
//                                         if (!Constants.sponsorAdsSetting['receiverMobileTypes']
//                                             .contains('Huawei')) {
//                                           Constants.sponsorAdsSetting['receiverMobileTypes'].add(
//                                               'Huawei');
//                                         }
//                                       } else {
//                                         Constants.sponsorAdsSetting['receiverMobileTypes'].remove(
//                                             'Huawei');
//                                       }
//                                       setState(() {
//                                         _huaweiCheckReceiver = value;
//                                       });
//                                     },
//                                   ),
//                                   const Text('Huawei')
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                     child: Neumorphic(
//                       padding: const EdgeInsets.all(8),
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'Publish date',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             "Select start and end date for publishing ads",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           SizedBox(
//                               height: 120,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       TextButton(
//                                         child: Text(_isoToPersianDate(Constants.sponsorAdsSetting['isoFrom'], "from") ?? '',
//                                             style: const TextStyle(
//                                                 fontSize: 20),
//                                             textAlign: TextAlign.center),
//                                         style: TextButton.styleFrom(
//                                             foregroundColor: Colors.white,
//                                             backgroundColor: Colors.blue,
//                                             padding: const EdgeInsets.only(
//                                                 right: 5, left: 5),
//                                             alignment: Alignment.center,
//                                             fixedSize: const Size.fromWidth(
//                                                 150),
//                                             shadowColor: Colors.grey,
//                                             elevation: 2),
//                                         onPressed: () {
//                                           showDatePicker('from');
//                                         },
//                                       ),
//                                       TextButton(
//                                         child: Text(_isoToPersianDate(Constants.sponsorAdsSetting['isoTo'], "to") ?? '',
//                                             style: const TextStyle(
//                                                 fontSize: 20),
//                                             textAlign: TextAlign.center),
//                                         style: TextButton.styleFrom(
//                                             foregroundColor: Colors.white,
//                                             backgroundColor: Colors.blue,
//                                             padding: const EdgeInsets.only(
//                                                 right: 5, left: 5),
//                                             alignment: Alignment.center,
//                                             fixedSize: const Size.fromWidth(
//                                                 150),
//                                             shadowColor: Colors.grey,
//                                             elevation: 2),
//                                         onPressed: () {
//                                           showDatePicker('to');
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 5),
//                                   NeumorphicButton(
//                                       padding: const EdgeInsets.only(top: 16, bottom: 16),
//                                       onPressed: () {
//                                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                             content: Text('Setting saved successfully')
//                                         ));
//                                       },
//                                       style: NeumorphicStyle(
//                                           color: Colors.blueAccent,
//                                           boxShape: NeumorphicBoxShape.roundRect(
//                                               const BorderRadius.all(Radius.circular(20)))),
//                                       child: SizedBox(
//                                         width: 150,
//                                         child: Text(
//                                           AppLocalizations.of(context).save,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white),
//                                         ),
//                                       ))
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )),
//               ]),
//             ),
//           ),
//         ));
//   }
//
//   void showDatePicker(String what) {
//     var _format = 'yyyy-mm-dd';
//    /* DatePicker.showDatePicker(context,
//         minYear: 1300,
//         maxYear: 1450,
//         confirm: const Text(
//           'Confirm',
//           style: TextStyle(color: Colors.green),
//         ),
//         cancel: const Text(
//           'Cancel',
//           style: TextStyle(color: Colors.red),
//         ),
//         dateFormat: _format,
//         onConfirm: (year, month, day) {
//           _changeDatetime(what, year!, month!, day!);
//         });*/
//   }
//
//   String? _isoToPersianDate(String? date, String what) {
//    /* PersianDate persianDate = PersianDate();
//     if (date != 'from' && date != 'to') {
//       var pFromDate = persianDate.gregorianToJalali(int.parse(date!.substring(0, 4)), int.parse(date.substring(5, 7)), int.parse(date.substring(8, 10)));
//       return "${pFromDate[0]}/${pFromDate[1]}/${pFromDate[2]}";
//     } else {
//       return what;
//     }*/
//   }
//
//   void _changeDatetime(String what, int year, int month, int day) {
//
//     print("sssss-   $year-$month-$day");
//
//   /*  PersianDate persianDate = PersianDate();
//
//     setState(() {
//       if (what == "from") {
//         from = '$year/$month/$day';
//         var gFromDate = persianDate.jalaliToGregorian(year, month, day);
//
//         print("gFromDate-   $gFromDate");
//
//         Constants.sponsorAdsSetting['isoFrom'] = DateTime.utc(gFromDate[0], gFromDate[1], gFromDate[2])
//             .toLocal()
//             .toString();
//
//         print("gFromDate-   ${Constants.sponsorAdsSetting['isoFrom']}");
//
//       } else {
//         to = '$year/$month/$day';
//         var gToDate = persianDate.jalaliToGregorian(year, month, day);
//         Constants.sponsorAdsSetting['isoTo'] = DateTime.utc(gToDate[0], gToDate[1], gToDate[2])
//             .toLocal()
//             .toString();
//       }
//     });*/
//   }
//
//   Future<File?> _pickExcelFile() async {
//     FilePickerResult? result =
//     await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx'], dialogTitle: 'Select excel file please');
//     if (result != null) {
//       return File(result.files.single.path!);
//     } else {
//       return null;
//     }
//   }
//
//   List<String>? readExcelFile(File file) {
//     var bytes = File(file.path).readAsBytesSync();
//     var excel = Excel.decodeBytes(bytes);
//
//     List<String> phoneNumbers = [];
//
//     for (var table in excel.tables.keys) {
//       if(excel.tables[table] != null) {
//         for (var row in excel.tables[table]!.rows) {
//           if(row[0] != null) {
//             phoneNumbers.add(row[0]!.value.toString());
//           } else {
//             return null;
//           }
//         }
//       } else {
//         return null;
//       }
//     }
//     return phoneNumbers;
//   }
// }
//
