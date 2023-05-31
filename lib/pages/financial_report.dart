// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../apis/apis.dart';
// import '../models/users.dart';
//
// class FinancialReport extends StatefulWidget {
//   const FinancialReport({Key? key}) : super(key: key);
//
//   @override
//   State<FinancialReport> createState() => _FinancialReportState();
// }
//
// class _FinancialReportState extends State<FinancialReport> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       // appBar: NeumorphicAppBar(
//       //   title: Text(
//       //     AppLocalizations.of(context).financialReport,
//       //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       //   ),
//       //   centerTitle: true,
//       //   buttonStyle: const NeumorphicStyle(
//       //     shape: NeumorphicShape.convex,
//       //   ),
//       // ),
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           AppLocalizations.of(context).help,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height - 144,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//               child: FutureBuilder<int>(
//             future: getWalletsInfo(),
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
//                   int? wallets = snapshot.data;
//                   return Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: SizedBox(
//                         height: 200,
//                         width: 200,
//                         child: Neumorphic(
//                           padding: const EdgeInsets.all(8),
//                           style: NeumorphicStyle(
//                               boxShape: NeumorphicBoxShape.roundRect(
//                                   const BorderRadius.all(Radius.circular(8)))),
//                           child: Column(
//                             children: [Text(AppLocalizations.of(context).totalWallets, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 28,),
//                             Text('$wallets \n${AppLocalizations.of(context).toman}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
//                             ]
//                           ),
//                         ),
//                       ));
//                 }
//               }
//             },
//           )),
//         ),
//       ),
//     );
//   }
//
//   Future<int> getWalletsInfo() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getUsersCount();
//     if (response[0] != null) {
//       Users users = response[0];
//       // return users.totalItems;
//      int? i = users.users.map((user) => user.wallet).fold(0, (prev, amount) => prev! + amount!);
//       return i ?? 0;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//       ));
//       return 0;
//     }
//   }
// }
