// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/helpers/constants.dart';
// import 'package:freesms/helpers/sharedprefs.dart';
// import 'package:freesms/pages/main_page.dart';
// import 'package:linkfy_text/linkfy_text.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../models/ad.dart';
// import '../models/contact_entity.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import '../apis/apis.dart';
// import '../models/phone_list.dart';
// import 'ads_theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
//
// // کنترلر پیامک نوشته شده توسط کاربر
// TextEditingController userTextController = TextEditingController();
//
// // کنترلر آگهی تبلیغاتی
// TextEditingController adsTextController = TextEditingController();
//
// //کنترلر آگهی تبلیغاتی اضافه
// TextEditingController adsAdditionalTextController = TextEditingController();
//
// class ComposeMessage extends StatefulWidget {
//   // اطلاعات مخاطب (کتابخانه ای که استفاده کردم چنین آبجکتی را از اطلاعات کاربر بر میگرداند.
//   final ContactEntity contact;
//
//   const ComposeMessage({required this.contact, Key? key}) : super(key: key);
//
//   @override
//   State<ComposeMessage> createState() => _ComposeMessageState();
// }
//
// class _ComposeMessageState extends State<ComposeMessage> {
//
//   bool _isLoading = false;
//
//   // غیر فعال کردن دکمه ارسال برای زمانی که اپلیکیشن در حال ارسال پیام است تا از ارسال چندباره جلوگیری شود
//   bool _disableSend = false;
//
//   // آی دی آگهی تبلیغاتی
//   String _adId = '';
//
//   // آی دی آگهی ارسال شده. نکته: چون به محض ارسال آگهی، آگهی تغییر میکرد و آی دی آگهی جدید به جای آی دی آگهی واقعا ارسال شده قرار می گرفت. آی دی آگهی که در واقعیت ارسال شده را در این متغیر ذخیره کردم
//   String _sendAdId = '';
//
//   // آی دی آگهی تبلیغاتی
//   int _adFee = 0;
//
//   // قیمت تبلیغ ارسال شده (همان توضیح بالا مدنظر قرار گیرد)
//   int _sendAdFee = 0;
//
//   // استرینگ بیس 64 عکس تبلیغ
//   String _imageBase64String = Constants.adImage;
//
//   // شماره تلفن مخاطب (شماره تلفن به صورت آرایه برمیگردد)
//   List<String> phoneList = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // گرفتن تبلیغات به صورت رندم که از این به بعد دیگه نیاز نیست رندم بگیریم و کلا 50 تا تبلیغ رو باید در اسلایدر نشان بدهید
//     Ad? ad = getRandomAd();
//
//     setState(() {
//       _isLoading = false;
//       _adId = ad!.adId!;
//       phoneList = PhoneList.fromJson(json.decode(widget.contact.phones!))
//           .phoneList
//           .map((phone) => phone.number)
//           .toList();
//       // اگر شماره تلفن جزو برخی شماره تلفن ها باشد تبلیغ با قیمت 40 در نظر گرفته می شود.
//       _adFee = Constants.teens.contains(phoneList.first.substring(0, 4))
//           ? 40
//           : ad.targetPhoneNumbers.contains(phoneList.first)
//               ? ad.senderFee
//               : ad.fee;
//       // _imageBase64String = ad.image.isNotEmpty ? ad.image : Constants.adImage;
//       // adsTextController.text = ad.text ?? '';
//       // adsAdditionalTextController.text = ad.additionalText ?? '';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const MainPage()));
//             },
//           ),
//           title: Text(
//             widget.contact.displayName!,
//           ),
//         ),
//         body: Builder(builder: (context) {
//           //TODO name of this page and maybe other pages comes from server
//           if (Constants.pageName == 'composeMessage') {
//             Constants.pageName = "";
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               showDialog(
//                   context: context,
//                   builder: (ctx) => AlertDialog(
//                         title:
//                             const Text('Call us', textAlign: TextAlign.center),
//                         content: const Text(
//                             'Call our agent office in tehran:\n4WG (Char-Nasl-Amvaj) Co.\n0098 21 888 46342',
//                             textAlign: TextAlign.center),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context, rootNavigator: true).pop();
//                               // final Uri launchUri = Uri(
//                               //   scheme: 'tel',
//                               //   path: '0098 21 888 46342',
//                               // );
//                               // UrlLauncher.launchUrl(launchUri);
//                             },
//                             child: Container(
//                               width: double.infinity,
//                               decoration: const BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4))),
//                               padding: const EdgeInsets.all(14),
//                               child: const Text(
//                                 "Ok",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ));
//             });
//           }
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Container(
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/chat_bg.png'))),
//                 height: MediaQuery.of(context).size.height - 97,
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding:
//                           EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
//                     ),
//                     GestureDetector(
//                       onHorizontalDragEnd: (details) async {
//                         setState(() {
//                           _isLoading = true;
//                         });
//                         Ad? ad = getRandomAd();
//                         setState(() {
//                           _isLoading = false;
//                           _adId = ad!.adId!;
//                           _adFee = Constants.teens
//                                   .contains(phoneList.first.substring(0, 4))
//                               ? 40
//                               : ad.targetPhoneNumbers.contains(phoneList.first)
//                                   ? ad.senderFee
//                                   : ad.fee;
//                           adsTextController.text = ad.text!;
//                           adsAdditionalTextController.text =
//                               ad.additionalText ?? '';
//                           // _imageBase64String = ad.image.isNotEmpty
//                           //     ? ad.image
//                           //     : Constants.adImage;
//                         });
//                         // adsTextController.text = await getAdsMessage();
//                         // setState(() {});
//                       },
//                       child: Container(
//                         decoration: const BoxDecoration(
//                             color: Color(0xFFE5E7EF),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                         width: 266,
//                         height: 365,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Stack(children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: Image.network(
//                                     "https://sms-static.storage.iran.liara.space/ads/6432bd965e377e30d38f293f.jpg",
//                                     height: 150,
//                                     width: 250,
//                                     alignment: Alignment.center,
//                                     fit: BoxFit.cover,
//                                     gaplessPlayback: true,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                     width: 250,
//                                     height: 40,
//                                 child: Container(
//                                   decoration: const BoxDecoration( color: Color(0x990C0D0F), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
//                                 ),),
//                                 Positioned(
//                                     bottom: 10,
//                                     left: 15,
//                                     child: Text(AppLocalizations.of(context).fee,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                           color: Colors.white),
//                                     )),
//                                 Positioned(
//                                     bottom: 10,
//                                     left: 55,
//                                     child: Text('$_adFee ${AppLocalizations.of(context).toman}',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                           color: Colors.white),
//                                     )),
//                               ]),
//                               const SizedBox(height: 10),
//                               Center(
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 250,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(right: 10.0, left: 10.0),
//                                         child: LinkifyText(
//                                           adsTextController.text.replaceAll('\\n', '\n'),
//                                           textAlign: TextAlign.end,
//                                           textStyle: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 18),
//                                           linkStyle: const TextStyle(
//                                               color: Colors.blue,
//                                               fontWeight: FontWeight.normal,
//                                               fontSize: 15),
//                                           onTap: (link) {
//                                             if (link.type == LinkType.url) {
//                                               _launchURL(link.value);
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Container(
//                       height: 48,
//                       width: 160,
//                       margin: const EdgeInsets.all(25),
//                       child: OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(width: 1.0, color: Colors.blue),
//                         ),
//                         child: const Text("Change Theme", style: TextStyle(fontSize: 16.0, color: Colors.blue,),),
//                         onPressed: () {
//                           // Navigator.pushReplacement(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => AdsTheme(
//                           //         contact: widget.contact,
//                           //       )),
//                           // );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Flexible(
//                       fit: FlexFit.loose,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 100,
//                               width: 260,
//                               child: TextField(
//                                 textAlignVertical: TextAlignVertical.center,
//                                 maxLines: null,
//                                 controller: userTextController,
//                                 decoration: InputDecoration(
//                                   border: const OutlineInputBorder(borderSide: BorderSide(
//                                       color: Color(0xFFBDC0CE),
//                                       width: 1),
//                                     borderRadius: BorderRadius.all(Radius.circular(12))
//                                   ),
//                                   contentPadding: const EdgeInsets.all(10.0),
//                                   hintText:
//                                       AppLocalizations.of(context).message,
//                                 ),
//                               ),
//                             ),
//                             ElevatedButton(
//                               style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) {
//                                 if (states.contains(MaterialState.pressed)) {
//                                   return const Color(0xB8C5D4FF);
//                                 }
//                                 return const Color(0xD6C5D4FF);
//                               })),
//                               onPressed: _disableSend
//                                   ? null
//                                   : () async {
//                                       //TODO اگه فرستاده بشه دیگه وجود نداره. چه نیازی هست که توی بلک لیست بره ؟
//                                       // Constants.adGroup?.adsList.where((ad) => ad.adId == _adId).first.blackList!.contains(_adId)
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                               content: Text(
//                                         'Please wait, message is sending',
//                                         textAlign: TextAlign.center,
//                                       )));
//                                       setState(() {
//                                         _disableSend = true;
//                                       });
//                                       // sending message
//                                       var phoneList = PhoneList.fromJson(json
//                                               .decode(widget.contact.phones!))
//                                           .phoneList
//                                           .map((phone) => phone.number)
//                                           .toList();
//                                       phoneList =
//                                           phoneList.getRange(0, 1).toList();
//                                       var message = userTextController
//                                                   .text.length <
//                                               70
//                                           ? '${userTextController.text} \n . \n ___تبلیغات___ \n . \n ${adsTextController.text} \n ${adsAdditionalTextController.text}'
//                                           : '${userTextController.text} \n . \n ___تبلیغات___ \n . \n ${adsTextController.text}';
//                                       _sendAdId = _adId;
//                                       _sendAdFee = _adFee;
//                                       var sendResult =
//                                           await _sendSMS(message, phoneList);
//                                       if (sendResult) {
//                                         String? res = await updateWallet(
//                                             SharedPrefs.getPhoneNumber(),
//                                             phoneList.first,
//                                             Constants.SEND_MESSAGE,
//                                             _sendAdId);
//
//                                         WidgetsBinding.instance
//                                             .addPostFrameCallback((_) {
//                                           showDialog(
//                                               context: context,
//                                               builder: (ctx) => AlertDialog(
//                                                     title: Text(
//                                                         AppLocalizations.of(
//                                                                 context)
//                                                             .congratulations,
//                                                         textAlign:
//                                                             TextAlign.center),
//                                                     content: Text(
//                                                         '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
//                                                         textAlign:
//                                                             TextAlign.center),
//                                                     actions: <Widget>[
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context,
//                                                                   rootNavigator:
//                                                                       true)
//                                                               .pop();
//                                                         },
//                                                         child: Container(
//                                                           width:
//                                                               double.infinity,
//                                                           decoration: const BoxDecoration(
//                                                               color:
//                                                                   Colors.green,
//                                                               borderRadius: BorderRadius
//                                                                   .all(Radius
//                                                                       .circular(
//                                                                           4))),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(14),
//                                                           child: Text(
//                                                             AppLocalizations.of(
//                                                                     context)
//                                                                 .ok,
//                                                             style:
//                                                                 const TextStyle(
//                                                               color:
//                                                                   Colors.white,
//                                                               fontSize: 18,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ));
//                                         });
//
//                                         Constants.adGroup!.adsList.removeWhere(
//                                             (item) => item.adId == _adId);
//                                         Ad? ad = getRandomAd();
//                                         if (ad != null) {
//                                           setState(() {
//                                             _isLoading = false;
//                                             _disableSend = false;
//                                             _adId = ad.adId!;
//                                             _adFee = Constants.teens.contains(
//                                                     phoneList.first
//                                                         .substring(0, 4))
//                                                 ? 40
//                                                 : ad.targetPhoneNumbers
//                                                         .contains(
//                                                             phoneList.first)
//                                                     ? ad.senderFee
//                                                     : ad.fee;
//                                             userTextController.text = '';
//                                             adsTextController.text = ad.text!;
//                                             adsAdditionalTextController.text =
//                                                 ad.additionalText ?? '';
//                                           });
//                                         } else {
//                                           setState(() {
//                                             _isLoading = true;
//                                             _disableSend = true;
//                                           });
//                                           if (await getGroupAds()) {
//                                             Ad? ad = getRandomAd();
//                                             if (ad != null) {
//                                               setState(() {
//                                                 _isLoading = false;
//                                                 _disableSend = false;
//                                                 _adId = ad.adId!;
//                                                 _adFee = Constants.teens
//                                                         .contains(phoneList
//                                                             .first
//                                                             .substring(0, 4))
//                                                     ? 40
//                                                     : ad.targetPhoneNumbers
//                                                             .contains(
//                                                                 phoneList.first)
//                                                         ? ad.senderFee
//                                                         : ad.fee;
//                                                 userTextController.text = '';
//                                                 adsTextController.text =
//                                                     ad.text!;
//                                                 adsAdditionalTextController
//                                                         .text =
//                                                     ad.additionalText ?? '';
//                                               });
//                                             }
//                                           }
//                                         }
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                           content: Text(
//                                             'Failed',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ));
//                                         setState(() {
//                                           _disableSend = false;
//                                         });
//                                       }
//                                     },
//                               child: const Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }));
//   }
// }
//
// Uint8List convertBase64Image(String base64String) {
//   return const Base64Decoder().convert(base64String);
// }
//
// Future<bool> _sendSMS(String message, List<String> recipients) async {
//   if (await permissionCheckAndRequest()) {
//     await sendSMS(message: message, recipients: recipients, sendDirect: true)
//         .catchError((onError) {
//       return Future.value(onError.toString());
//     });
//     return Future.value(true);
//   } else {
//     return Future.value(false);
//   }
// }
//
// Future<bool> permissionCheckAndRequest() async {
//   if (await Permission.sms.status.isDenied) {
//     Map<Permission, PermissionStatus> statuses =
//         await [Permission.sms].request();
//     return Future.value(statuses[Permission.sms] == PermissionStatus.granted);
//   } else {
//     return Future.value(true);
//   }
// }
//
// Ad? getRandomAd() {
//   if (Constants.adGroup!.adsList.isNotEmpty) {
//     Random r = Random();
//     int index = r.nextInt(Constants.adGroup!.adsList.length - 1);
//     return Constants.adGroup!.adsList[index];
//   } else {
//     return null;
//   }
// }
//
// Future<String?> updateWallet(
//     String sender, String receiver, String purpose, String adId) async {
//   Apis api = Apis();
//   List<dynamic> response =
//       await api.updateWallet(sender, receiver, purpose, adId);
//
//   if (response[0] != null) {
//     String? message = response[0];
//     return message;
//   } else {
//     return response[1];
//   }
// }
//
// Future<String?> updateWalletForShare(
//     String sender, String receiver, String purpose, String adId) async {
//   Apis api = Apis();
//   List<dynamic> response =
//       await api.updateWallet(sender, receiver, purpose, adId);
//
//   if (response[0] != null) {
//     String? message = response[0];
//     return message;
//   } else {
//     return null;
//   }
// }
//
// _launchURL(String? url) async {
//   if (url != null) {
//     final Uri urlLaunchUri = Uri(
//       scheme: url.startsWith('https')
//           ? 'https'
//           : url.startsWith('http')
//               ? 'http'
//               : 'https',
//       path: url.startsWith('https')
//           ? url.replaceAll('https:', '')
//           : url.startsWith('http')
//               ? url.replaceAll('http:', '')
//               : url,
//     );
//
//     if (await canLaunchUrl(urlLaunchUri)) {
//       await launchUrl(urlLaunchUri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
//
// String? encodeQueryParameters(Map<String, String> params) {
//   return params.entries
//       .map((MapEntry<String, String> e) =>
//           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//       .join('&');
// }
//
// Future<bool> getGroupAds
//     () async {
//   Apis api = Apis();
//   List<dynamic> response = await api.getGroupAds();
//   if (response[0] != null) {
//     Constants.adGroup = response[0];
//     return true;
//   } else {
//     return false;
//   }
// }
//
//
