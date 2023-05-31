// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:freesms/models/sponsor_ad.dart';
// import 'package:freesms/models/audit_ads.dart';
// import '../apis/apis.dart';
//
// class AuditAdsPage extends StatefulWidget {
//   final AuditAds auditAds;
//
//   const AuditAdsPage(this.auditAds, {Key? key}) : super(key: key);
//
//   @override
//   State<AuditAdsPage> createState() => _AuditAdsPageState();
// }
//
// class _AuditAdsPageState extends State<AuditAdsPage> {
//
//   bool _isSearch = false;
//   AuditAds _auditAds = AuditAds(adsList: []);
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _auditAds = widget.auditAds;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xFFDDE6E8),
//           centerTitle: true,
//           title: Text(
//             AppLocalizations.of(context).auditAds,
//             style: const TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           bottom: const TabBar(tabs: [
//             Tab(
//               child: Text(
//                 'Waiting list',
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'Confirmed',
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'Pause',
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//             )
//           ]),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: (MediaQuery.of(context).size.height - 144) * 0.1,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
//                   child: Neumorphic(
//                     style: NeumorphicStyle(
//                       depth: -4,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           BorderRadius.circular(60)),
//                     ),
//                     child: TextField(
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: _controller,
//                       textInputAction: TextInputAction.search,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.only(
//                             top: 10.0, right: 30, left: 30, bottom: 10.0),
//                         suffixIcon: _isSearch
//                             ?
//                         const Center(
//                                 child: CircularProgressIndicator(
//                                   color: Colors.indigo,
//                                 ),
//                                 widthFactor: 15,
//                                 heightFactor: 15,
//                               )
//                             :
//                         GestureDetector(
//                                 child: const Icon(Icons.search),
//                                 onTap: () {
//                                   setState(() {
//                                     if (_controller.text.isEmpty) {
//                                       _auditAds = widget.auditAds;
//                                       _isSearch = false;
//                                     } else {
//                                       _isSearch = true;
//                                     }
//                                   });
//                                   AuditAds aa = AuditAds(
//                                       adsList: widget.auditAds.adsList
//                                           .where((ad) => ad.text
//                                           .contains(_controller.text))
//                                           .toList());
//
//                                   _auditAds = aa;
//
//                                   setState(() {
//                                     _isSearch = false;
//                                   });
//                                 },
//                               ),
//                         hintText: AppLocalizations.of(context).search,
//                       ),
//                       onEditingComplete: () {
//                         setState(() {
//                           if (_controller.text.isEmpty) {
//                             _auditAds = widget.auditAds;
//                             _isSearch = false;
//                           } else {
//                             _isSearch = true;
//                           }
//                         });
//                         AuditAds aa = AuditAds(
//                             adsList: widget.auditAds.adsList
//                                 .where((ad) => ad.text
//                                 .contains(_controller.text))
//                                 .toList());
//
//                         _auditAds = aa;
//
//                         setState(() {
//                           _isSearch = false;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   height: (MediaQuery.of(context).size.height - 144) * 0.9,
//                   child: TabBarView(
//                     children: [
//                       adsListView(_auditAds.adsList
//                           .where((element) => element.status == 'WAITING')
//                           .toList()),
//                       adsListView(_auditAds.adsList
//                           .where((element) => element.status == 'CONFIRMED')
//                           .toList()),
//                       adsListView(_auditAds.adsList
//                           .where((element) => element.status == 'PAUSE')
//                           .toList())
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget adsListView(List<SponsorAd>? adsList) {
//     return SizedBox(
//       child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: adsList!.length,
//           itemBuilder: (context, index) {
//             return Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: adsList.isNotEmpty
//                     ? createAdsRow(context, adsList, index)
//                     : const SizedBox(
//                         child: Center(child: Text('Fetching data failed')),
//                       ));
//           }),
//     );
//   }
//
//   Widget createAdsRow(BuildContext context, List<SponsorAd>? ads, int index) {
//     SponsorAd a = ads![index];
//     return Neumorphic(
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(8),
//       style: NeumorphicStyle(
//           shape: NeumorphicShape.flat,
//           boxShape: NeumorphicBoxShape.roundRect(
//               const BorderRadius.all(Radius.circular(10)))),
//       child: Container(
//         padding: const EdgeInsets.all(3.0),
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).mainText,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.text,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).additionalText,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.additionalText ?? '',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).fee,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.fee}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).senderFee,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.senderFee}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).receiverFee,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.receiverFee}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).maximumViewPerSender,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.maximumViewPerSender}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).maximumViewPerReceiver,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.maximumViewPerReceiver}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).orderCount,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${a.orderCount}',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).senderMobileTypes,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.senderMobileTypes.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).receiverMobileTypes,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.receiverMobileTypes.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).senderOperators,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.senderOperators.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).receiverOperators,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.receiverOperators.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).senderMobileNumbers,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.senderMobileNumbers.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               AppLocalizations.of(context).receiverMobileNumbers,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               a.receiverMobileNumbers.join(", "),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             // SizedBox(
//             //   width: double.infinity,
//             //   child: Center(
//             //     child: Image.memory(
//             //       convertBase64Image(a.image ?? ''),
//             //       height: 144,
//             //       width: 256,
//             //       alignment: Alignment.center,
//             //       errorBuilder: (context, error, stackTrace) => const Text(''),
//             //       gaplessPlayback: true,
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(
//               height: 8,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: NeumorphicCheckbox(
//                 value: (a.status == 'CONFIRMED') ? true : false,
//                 onChanged: (value) {
//                   if (a.status == 'WAITING') {
//                     auditTheAds(a.adId, 'CONFIRMED');
//                   } else if (a.status == 'CONFIRMED') {
//                     auditTheAds(a.adId, 'PAUSE');
//                   } else {
//                     auditTheAds(a.adId, 'CONFIRMED');
//                   }
//                   setState(() {});
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> auditTheAds(String? adId, String status) async {
//     Apis api = Apis();
//     List<dynamic> response = await api.auditAds(adId, status);
//     if (response[0] != null) {
//       AuditAds? auditAds = await getSponsorAdsForAudition();
//       setState(() {
//         _auditAds = auditAds ?? AuditAds(adsList: []);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1], textAlign: TextAlign.center),
//       ));
//     }
//   }
//
//   Uint8List convertBase64Image(String base64String) {
//     return const Base64Decoder().convert(base64String);
//   }
//
//   Future<AuditAds?> getSponsorAdsForAudition() async {
//     Apis api = Apis();
//     // List<dynamic> response = await api.getSponsorAdsForAudition();
//     List<dynamic> response = [];
//
//     if (response[0] != null) {
//       AuditAds auditAds = response[0];
//       // setState(() {
//       //   lo = !_loading;
//       // });
//       return auditAds;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//       ));
//       // setState(() {
//       //   _loading = !_loading;
//       // });
//       return null;
//     }
//   }
//
// }
