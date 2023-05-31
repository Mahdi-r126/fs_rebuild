// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/domain/entities/contact.dart';
// import '../home_view/chats_veiw/screens/messages/components/modal_compose_message.dart';
// import '../models/categories.dart';
// import '../models/contact_entity.dart';
// import '../models/themes.dart';
// import '../send_sms_view/compose_message_screen.dart';
// import './compose_message.dart';
// import '../apis/apis.dart';
//
// class AdsTheme extends StatefulWidget {
//   final Contact? contact;
//   final String? phoneNumber;
//
//  // final String contactNumber;
//  // final String contactdisplayName;
//
//   const AdsTheme({this.contact,this.phoneNumber, Key? key}) : super(key: key);
//   /*this.contact*/
//   @override
//   State<AdsTheme> createState() => _AdsThemeState();
// }
//
// class _AdsThemeState extends State<AdsTheme> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>(widget.contact != null)?ComposeMessageScreen(
//                     phoneNumber: widget.phoneNumber!,
//                // contactNumber: widget.contactNumber ,
//                 //contactdisplayName: widget.contactdisplayName,
//                   ):ComposeMessageScreen(phoneNumber: widget.phoneNumber!,)),
//         );
//         return Future.value(false);
//       },
//       child: FutureBuilder<Categories?>(
//         future: getCategories(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.indigo,
//               ),
//               widthFactor: 15,
//               heightFactor: 15,
//             );
//           } else {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               Categories? categories = snapshot.data;
//               return DefaultTabController(
//                 length: categories!.categoryList.length,
//                 child: Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   appBar: AppBar(
//                     automaticallyImplyLeading: false,
//                     backgroundColor: const Color(0xFFDDE6E8),
//                     centerTitle: true,
//                     title: const Text(
//                       'Ads Theme',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     bottom: TabBar(
//                         tabs: categories.categoryList.map((category) {
//                       return Tab(
//                         child: Text(
//                           category.name,
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 12),
//                         ),
//                         icon: Image.network(
//                           category.icon,
//                           height: 30,
//                           width: 30,
//                           alignment: Alignment.center,
//                         ),
//                       );
//                     }).toList()),
//                   ),
//                   body: Builder(
//                     builder: (context) {
//                       final index = DefaultTabController.of(context)?.index;
//                       return TabBarView(
//                         children: categories.categoryList.map((category) {
//                           return createThemesRow(categories.categoryList[index!].categoryId);
//                         }).toList(),
//                       );
//                     }
//                   ),
//                 ),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
//
//   Widget createThemesRow(String? categoryId) {
//       return FutureBuilder<Themes?>(
//         future: getThemes(categoryId!),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.indigo,
//               ),
//               widthFactor: 15,
//               heightFactor: 15,
//             );
//           } else {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               Themes? themes = snapshot.data;
//               return Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: GridView.count(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                     children: themes!.themeList.map((theme) {
//                       return NeumorphicButton(
//                         onPressed: () {
//                           selectAdsTheme(categoryId, theme.themeId);
//                         },
//                         child: Center(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Image.network(
//                                     theme.icon,
//                                     height: 50,
//                                     width: 50,
//                                     alignment: Alignment.center,
//                                   ),
//                                 ),
//                                 Text(theme.name,
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15)),
//                               ]),
//                         ),
//                       );
//                     }).toList()),
//               );
//             }
//           }
//         });
//   }
//
//   Future<Categories?> getCategories() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getCategories();
//     if(response[0] != null) {
//       return response[0];
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//       ));
//       return null;
//     }
//   }
//
//   Future<Themes?> getThemes(String categoryId) async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getThemes(categoryId);
//     if(response[0] != null) {
//       return response[0];
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//       ));
//       return null;
//     }
//   }
//
//   Future<void> selectAdsTheme(categoryId, themeId) async {
//     try {
//       Apis api = Apis();
//       api.selectAdsTheme(categoryId, themeId);
//       goToComposeMessage();
//     } on Exception catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//           content: Text(
//               e.toString()
//           )));
//     }
//   }
//
//   void goToComposeMessage() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => (widget.contact != null)?ComposeMessageScreen(
//             phoneNumber: widget.phoneNumber!,
//             // contactNumber: widget.contactNumber ,
//             //contactdisplayName: widget.contactdisplayName,
//           ):ComposeMessageScreen(phoneNumber: widget.phoneNumber!,)),
//     );
//   }
// }
