// import 'package:flutter/material.dart';
// import 'contact_list.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// bool isContacts = true;
//
// class MainContainer extends StatefulWidget {
//   const MainContainer({Key? key}) : super(key: key);
//
//   @override
//   State<MainContainer> createState() => _MainContainerState();
// }
//
// class _MainContainerState extends State<MainContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return
//         // Column(
//         // children: [
//         //   SizedBox(
//         //     width: double.infinity,
//         //     height: 50,
//         //     child: Row(
//         //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //       children: [
//         //         NeumorphicButton(
//         //             onPressed: () {
//         //               setState(() {
//         //                 isContacts = true;
//         //               });
//         //             },
//         //             child: const Text(
//         //               'Contacts',
//         //               style: TextStyle(
//         //                   fontSize: 20, fontWeight: FontWeight.bold),
//         //             ),
//         //         ),
//         //         NeumorphicButton(
//         //           onPressed: () {
//         //             setState(() {
//         //               isContacts = false;
//         //             });
//         //           },
//         //           child: const Text(
//         //             ' Recent ',
//         //             style: TextStyle(
//         //                 fontSize: 20, fontWeight: FontWeight.bold),
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         //   ////in ya oon,
//         //   const SizedBox(height: 15,),
//         //   isContacts ? const
//         const SizedBox(child: ContactList());
//     // : const Recent()],
//     // );
//   }
// }
