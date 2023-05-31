// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:freesms/main.dart';
// import 'package:freesms/pages/financial_report.dart';
// import 'package:freesms/pages/users_info.dart';
// import '../presentation/pages/audit_ads/audit_ads_page.dart';
//
// class AdminPanel extends StatefulWidget {
//   const AdminPanel({Key? key}) : super(key: key);
//
//   @override
//   State<AdminPanel> createState() => _AdminPanelState();
// }
//
// class _AdminPanelState extends State<AdminPanel> {
//
//   bool _loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             AppLocalizations.of(context).adminPanel,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: _loading
//             ?
//         const Center(child: CircularProgressIndicator())
//             :
//         SizedBox(
//           height: MediaQuery.of(context).size.height - 144,
//           child: ListView(
//               children: [
//             SizedBox(
//               height: (MediaQuery.of(context).size.height - 144) / 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: NeumorphicButton(
//                     onPressed: () async {
//                       setState(() {
//                         _loading = !_loading;
//                       });
//                       // AuditAds? auditAds = await getSponsorAdsForAudition();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AuditAdsPage()),
//                         );
//                     },
//                     child: Center(
//                         child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           const Icon(Icons.fact_check_outlined, size: 50, ),
//                           Text(AppLocalizations.of(context).auditAds, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
//                         ],))),
//               ),
//             ),
//                 SizedBox(
//                   height: (MediaQuery.of(context).size.height - 144) / 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: NeumorphicButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                 const UsersInfo()),
//                           );
//                         },
//                         child: Center(
//                             child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 const Icon(Icons.supervised_user_circle_outlined, size: 50, ),
//                                 Text(AppLocalizations.of(context).users, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
//                               ],))),
//                   ),
//                 ),
//                 SizedBox(
//                   height: (MediaQuery.of(context).size.height - 144) / 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: NeumorphicButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                 const FinancialReport()),
//                           );
//                         },
//                         child: Center(
//                             child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 const Icon(Icons.money, size: 50, ),
//                                 Text(AppLocalizations.of(context).financialReport, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
//                               ],))),
//                   ),
//                 ),
//           ]),
//         ));
//   }
//
//   changeLocal(Locale newLocale) {
//     MyApp.setLocale(context, newLocale);
//   }
//
//   // Future<AuditAds?> getSponsorAdsForAudition() async {
//   //   Apis api = Apis();
//   //   List<dynamic> response = await api.getSponsorAdsForAudition();
//   //   if (response[0] != null) {
//   //     AuditAds auditAds = response[0];
//   //     setState(() {
//   //       _loading = !_loading;
//   //     });
//   //     return auditAds;
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//   //     ));
//   //     setState(() {
//   //       _loading = !_loading;
//   //     });
//   //     return null;
//   //   }
//   // }
//
// }
