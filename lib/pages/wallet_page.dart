// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/pages/cash_out_page.dart';
// import '../apis/apis.dart';
// import '../models/wallet.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class WalletPage extends StatefulWidget {
//   const WalletPage({Key? key}) : super(key: key);
//
//   @override
//   State<WalletPage> createState() => _WalletPageState();
// }
//
// class _WalletPageState extends State<WalletPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Color(0xFF0C0D0F),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Color(0xFF0C0D0F),
//               size: 20.0,),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Text( AppLocalizations.of(context).wallet,
//             style: const TextStyle(color: Color(0xFF0C0D0F),
//                 fontSize: 20,fontWeight: FontWeight.w700),
//           ),
//
//         ),
//         body: FutureBuilder<List<dynamic>>(
//           future: getWalletData(),
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
//                 Wallet wallet = snapshot.data![0];
//                 return SizedBox(height: MediaQuery.of(context).size.height,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(children: [
//                       Expanded(
//                         child: Neumorphic(
//                             style: const NeumorphicStyle(
//                               shape: NeumorphicShape.concave,
//                               boxShape: NeumorphicBoxShape.circle(),
//                               lightSource: LightSource.topLeft,
//                             ),
//                             child: Center(
//                               child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: <Widget>[
//                                     const SizedBox(
//                                         child: Icon(
//                                       Icons.sms_rounded,
//                                       size: 60.0,
//                                     )),
//                                     Text('${wallet.totalMessages}',
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30)),
//                                     Text(AppLocalizations.of(context).sentMessages,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15)),
//                                   ]),
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Expanded(
//                         child: Neumorphic(
//                             style: const NeumorphicStyle(
//                               shape: NeumorphicShape.concave,
//                               boxShape: NeumorphicBoxShape.circle(),
//                               lightSource: LightSource.topLeft,
//                             ),
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       const SizedBox(
//                                           child: Icon(
//                                         Icons.account_balance_wallet,
//                                         size: 60.0,
//                                       )),
//                                       Text('${wallet.wallet} ${AppLocalizations.of(context).toman}',
//                                           style:const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20)),
//                                       Text(AppLocalizations.of(context).yourContribution,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15)),
//                                     ]),
//                               ),
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       NeumorphicButton(
//                           padding: const EdgeInsets.only(top: 16, bottom: 16),
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       CashOutPage(wallet.wallet)),
//                             );
//                           },
//                           style: NeumorphicStyle(
//                               color: Colors.blueAccent,
//                               boxShape: NeumorphicBoxShape.roundRect(
//                                   const BorderRadius.all(Radius.circular(20)))),
//                           child: SizedBox(
//                             width: 150,
//                             child: Text(
//                               AppLocalizations.of(context).cashOut,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ))
//                     ]),
//                   ),
//                 );
//               }
//             }
//           },
//         ));
//   }
//
//   Future<List<dynamic>> getWalletData() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getWalletData();
//     if (response[0] != null) {
//
//       for(var item in [response[0]])
//       {
//         var tt = item as Wallet;
//       }
//
//       return [response[0]];
//     } else {
//       throw response[1];
//       // return [null, response[1]];
//     }
//   }
// }
