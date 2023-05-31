// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:freesms/helpers/constants.dart';
// import 'package:freesms/pages/setting.dart';
// import 'package:freesms/user/providers/userProvider.dart';
// import 'package:freesms/widgets/share_to_friends.dart';
// import 'package:provider/provider.dart';
// import '../apis/apis.dart';
// import '../helpers/sharedprefs.dart';
// import '../models/admin_login.dart';
// import '../presentation/pages/sponsor_ads/sponsors_ads_page.dart';
// import '../widgets/contact_list.dart';
// import 'admin_panel.dart';
// import 'help.dart';
// import '../widgets/main_container.dart';
// import './wallet_page.dart';
// import 'about_us.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../models/ads_list.dart';
//
// TextEditingController _userNameController = TextEditingController();
// TextEditingController _passwordController = TextEditingController();
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   bool _loginLoading = false;
//
//   @override
//   void initState() {
//     getGroupAds();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Constants.adGroup = await getGroupAds();
//     return Scaffold(
//       endDrawer: Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFFDDE6E8),
//               ),
//               child: null,
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).shareToFriends,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ShareToFriends()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).wallet,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const WalletPage()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).setting,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Setting()),
//                 );
//                 // Update the state of the app.
//                 // ...
//               },
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).help,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const Help(),
//                     ));
//               },
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).aboutUs,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AboutUs(),
//                     ));
//               },
//             ),
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).sponsors,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 // showDialog(context: context,
//                 //     builder: (ctx) => AlertDialog(
//                 //       title: const Text('Call us', textAlign: TextAlign.center),
//                 //       content: const Text('Call our agent office in tehran:\n4WG (Char-Nasl-Amvaj) Co.\n0098 21 888 46342', textAlign: TextAlign.center),
//                 //       actions: <Widget>[
//                 //         TextButton(
//                 //           onPressed: () {
//                 //             final Uri launchUri = Uri(
//                 //               scheme: 'tel',
//                 //               path: '0098 21 888 46342',
//                 //             );
//                 //             UrlLauncher.launchUrl(launchUri);
//                 //           },
//                 //           child: Container(
//                 //             width: double.infinity,
//                 //             decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(4))),
//                 //             padding: const EdgeInsets.all(14),
//                 //             child: const Text("Call", style: TextStyle(color: Colors.white, fontSize: 18,), textAlign: TextAlign.center,),
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ));
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const SponsorsAdsPage()),
//                 );
//               },
//             ),
//
//             // ListTile(
//             //   title: Text(AppLocalizations.of(context).adminPanel, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//             //   onTap: () {
//             //     showDialog(
//             //         context: context,
//             //         builder: (ctx) => StatefulBuilder(
//             //           builder: (context, setState) => AlertDialog(
//             //             title: Text(AppLocalizations.of(context).login, textAlign: TextAlign.center),
//             //             content: const Text('Please login into your account',
//             //                 textAlign: TextAlign.center),
//             //             actions: <Widget>[
//             //               Neumorphic(
//             //                 style: NeumorphicStyle(
//             //                     depth: -5,
//             //                     boxShape: NeumorphicBoxShape.roundRect(
//             //                         const BorderRadius.all(
//             //                             Radius.circular(20)))),
//             //                 child: TextField(
//             //                   onChanged: (phoneNumber) => setState(() {}),
//             //                   controller: _userNameController,
//             //                   decoration: const InputDecoration(
//             //                     hintText: 'userName',
//             //                     border: InputBorder.none,
//             //                     contentPadding: EdgeInsets.only(
//             //                         right: 4.0,
//             //                         top: 20.0,
//             //                         bottom: 20.0,
//             //                         left: 15),
//             //                     alignLabelWithHint: true,),
//             //                 ),
//             //               ),
//             //               const SizedBox(height: 10),
//             //               Neumorphic(
//             //                 style: NeumorphicStyle(
//             //                     depth: -5,
//             //                     boxShape: NeumorphicBoxShape.roundRect(
//             //                         const BorderRadius.all(
//             //                             Radius.circular(20)))),
//             //                 child: TextField(
//             //                   onChanged: (phoneNumber) => setState(() {}),
//             //                   controller: _passwordController,
//             //                   decoration: const InputDecoration(
//             //                     hintText: 'password',
//             //                     border: InputBorder.none,
//             //                     contentPadding: EdgeInsets.only(
//             //                         right: 4.0,
//             //                         top: 20.0,
//             //                         bottom: 20.0,
//             //                         left: 15),
//             //                     alignLabelWithHint: true,),
//             //                 ),
//             //               ),
//             //               const SizedBox(height: 10),
//             //               Center(
//             //                 child: SizedBox(
//             //                   width: 90,
//             //                   child: NeumorphicButton(
//             //                       onPressed: () {
//             //                         setState(() {
//             //                           _loginLoading = !_loginLoading;
//             //                         });
//             //                         loginAdmin();
//             //                       },
//             //                       style: NeumorphicStyle(
//             //                           color: Colors.blueAccent,
//             //                           boxShape: NeumorphicBoxShape.roundRect(
//             //                               const BorderRadius.all(Radius.circular(20)))),
//             //                       child: SizedBox(
//             //                         width: double.infinity,
//             //                         child: _loginLoading ? const Center(
//             //                             child: SizedBox(
//             //                                 height: 22,
//             //                                 width: 22,
//             //                                 child: CircularProgressIndicator(
//             //                                   color: Colors.white,
//             //                                 )))
//             //                             : Text(
//             //                           AppLocalizations.of(context).login,
//             //                           textAlign: TextAlign.center,
//             //                           style: const TextStyle(
//             //                               fontSize: 20,
//             //                               fontWeight: FontWeight.bold,
//             //                               color: Colors.white),
//             //                         ),
//             //                       )),
//             //                 ),
//             //               )
//             //             ],
//             //           ),
//             //         ));
//             //     // Navigator.push(
//             //     //   context,
//             //     //   MaterialPageRoute(
//             //     //       builder: (context) =>
//             //     //       const AdminPanel()),
//             //     // );
//             //     // Update the state of the app.
//             //     // ...
//             //   },
//             // ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context).home,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: const MainContainer(),
//     );
//   }
//
//   // Future<void> loginAdmin() async {
//   //   Apis api = Apis();
//   //   List<dynamic> response = await api.adminLogin(_userNameController.text, _passwordController.text);
//   //
//   //   if (response[0] != null) {
//   //     SharedPrefs.setAdminAccessToken((response[0] as AdminLogin).accessToken);
//   //     SharedPrefs.setAdminRefreshToken((response[0] as AdminLogin).refreshToken);
//   //     setState(() {
//   //       _loginLoading = !_loginLoading;
//   //     });
//   //     Navigator.of(context, rootNavigator: true).pop();
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) =>
//   //           const AdminPanel()),
//   //     );
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //       content: Text('Network error, can`t connect to server', textAlign: TextAlign.center),
//   //     ));
//   //     setState(() {
//   //       _loginLoading = !_loginLoading;
//   //     });
//   //   }
//   // }
// }
//
// Future<void> getGroupAds() async {
//   Apis api = Apis();
//   List<dynamic> response = await api.getGroupAds();
//   if (response[0] != null) {
//     Constants.adGroup = response[0];
//   } else {
//     AdsList adsList = AdsList.fromJson(Constants.defaultAds);
//     Constants.adGroup = adsList;
//   }
// }
