// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/models/ads_list.dart';
// import 'package:freesms/models/organization_ads.dart';
// import '../apis/apis.dart';
// import '../models/ad.dart';
// import '../models/wallet.dart';
//
// // List<String>
//
// List<String> confirmedAds = [];
//
// class MediaHolder extends StatefulWidget {
//   final String accountName;
//
//   const MediaHolder(this.accountName, {Key? key}) : super(key: key);
//
//   @override
//   State<MediaHolder> createState() => _MediaHolderState();
// }
//
// class _MediaHolderState extends State<MediaHolder> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: const Color(0xFFDDE6E8),
//             centerTitle: true,
//             title: Text(
//               'Media Holder: ${widget.accountName}',
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             bottom: const TabBar(tabs: [
//               Tab(
//                 child: Text(
//                   'Solid',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Tab(
//                 child: Text(
//                   'Waiting list',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Tab(
//                 child: Text(
//                   'Confirmed',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               )
//             ]),
//           ),
//           body: FutureBuilder<OrganizationAds?>(
//             future: getOrganizationAds(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.indigo,
//                   ),
//                   widthFactor: 15,
//                   heightFactor: 15,
//                 );
//               } else {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   OrganizationAds? organizationAds = snapshot.data;
//                   return Builder(builder: (context) {
//                     final index = DefaultTabController.of(context)?.index;
//                     return organizationAds != null ? TabBarView(
//                       children: [adsListView(organizationAds.solid, true), adsListView(organizationAds.waiting, false), adsListView(organizationAds.confirmed, true)],
//                     ) : const Center(child: Text('Server error!', style: TextStyle(fontSize: 19),));
//                   });
//                 }
//               }
//             },
//           ),
//         floatingActionButton:    NeumorphicFloatingActionButton(
//           style: const NeumorphicStyle(
//               boxShape: NeumorphicBoxShape.circle(),
//               color: Colors.blueGrey),
//           onPressed: () {
//             confirmAds();
//           },
//           child: const Icon(
//             Icons.send_rounded,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget adsListView(List<Ad> adsList, bool isConfirmedTab) {
//     return  SizedBox(
//       child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: adsList.length,
//           itemBuilder: (context, index) {
//             return Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child:
//                 adsList.isNotEmpty
//                     ? createAdsRow(context, adsList, index, isConfirmedTab)
//                     : const SizedBox(child: Center(child: Text('Fetching data failed')),));
//           }),
//     );
//   }
//
//   Widget createAdsRow(BuildContext context, List<Ad>? ads, int index, bool isConfirmedTab) {
//     Ad a = ads![index];
//     return NeumorphicButton(
//       onPressed: () {
//       },
//       child: Container(
//         padding: const EdgeInsets.all(3.0),
//         width: double.infinity,
//         child: Column(
//           children: [
//             const Text('Org/Company: '),
//             const Text('Ads:'),
//             Text(a.text!, textDirection: TextDirection.rtl,),
//             NeumorphicCheckbox(
//               value: (a.solid! || confirmedAds.contains(a.adId!)) ? true : false,
//               onChanged: (value) {
//                 if(isConfirmedTab) {
//                   return;
//                 }
//                 else {
//                   setState(() {
//                     if(value) {
//                       if (!confirmedAds.contains(a.adId)) {
//                         confirmedAds.add(a.adId!);
//                       }
//                     } else {
//                       confirmedAds.remove(a.adId!);
//                     }
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Future<OrganizationAds?> getOrganizationAds() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getOrganizationAds();
//     if (response[0] != null) {
//       OrganizationAds organizationAds = response[0];
//       return organizationAds;
//     } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//         ));
//         return null;
//     }
//   }
//
//   Future<void> confirmAds() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.updateConfirmList(confirmedAds);
//     if (response[0] != null) {
//       setState(() {
//
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1], textAlign: TextAlign.center),
//       ));
//     }
//   }
// }
