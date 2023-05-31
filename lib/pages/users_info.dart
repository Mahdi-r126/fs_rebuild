// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../apis/apis.dart';
// import '../models/users.dart';
//
// class UsersInfo extends StatefulWidget {
//   const UsersInfo({Key? key}) : super(key: key);
//
//   @override
//   State<UsersInfo> createState() => _UsersInfoState();
// }
//
// class _UsersInfoState extends State<UsersInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       // appBar: NeumorphicAppBar(
//       //   title: Text(
//       //     AppLocalizations.of(context).help,
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
//             future: getUsersCount(),
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
//                   int? usersCount = snapshot.data;
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
//                             children: [Text(AppLocalizations.of(context).totalUsers, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 10,),
//                             Text(usersCount.toString(), style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),),
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
//   Future<int> getUsersCount() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getUsersCount();
//     if (response[0] != null) {
//       Users users = response[0];
//       return users.totalItems;
//       // return users.users.length;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//       ));
//       return 0;
//     }
//   }
// }
