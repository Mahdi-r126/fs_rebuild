// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:freesms/helpers/helpers.dart';
// import '../helpers/sharedprefs.dart';
// import 'package:freesms/pages/main_page.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<int>(
//         future: saveToDb(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const NeumorphicProgressIndeterminate(
//                     height: 20,
//                     style: ProgressStyle(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(4),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   NeumorphicText(
//                     'Reading contacts, please wait ...',
//                     style: const NeumorphicStyle(
//                       color: Colors.black,
//                     ),
//                     textStyle: NeumorphicTextStyle(
//                       fontSize: 20,
//                     ),
//                   )
//                 ],
//               ),
//               widthFactor: 15,
//               heightFactor: 15,
//             );
//           } else {
//             if (snapshot.hasError) {
//               return Center(
//                   child: NeumorphicText(
//                 'Error: ${snapshot.error}',
//                 style: const NeumorphicStyle(
//                   color: Colors.red,
//                 ),
//                 textStyle: NeumorphicTextStyle(
//                   fontSize: 12,
//                 ),
//               ));
//             } else {
//               // TODO: move to read contacts
//               SharedPrefs.setFirstDBInjection(false);
//               SchedulerBinding.instance.addPostFrameCallback((_) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MainPage()),
//                 );
//               });
//               return const SizedBox();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
