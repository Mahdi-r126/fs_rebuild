// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/helpers/sharedprefs.dart';
// import 'package:freesms/presentation/pages/sponsor_ads/sponsors_ads_page.dart';
// import 'package:freesms/widgets/share_to_friends.dart';
// import 'package:provider/provider.dart';
// import '../Costanat.dart';
// import '../helpers/constants.dart';
// import '../home_view/home_screen.dart';
// import '../home_view/wallet_view/wallet_screen.dart';
// import '../models/contact_entity.dart';
// import '../helpers/helpers.dart';
// import '../pages/about_us.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../pages/help.dart';
// import '../pages/setting.dart';
// import '../pages/wallet_page.dart';
// import '../send_sms_view/compose_message_screen.dart';
// import '../user/providers/userProvider.dart';
//
// late List<ContactEntity> _contacts = [];
// bool isSearch = false;
// TextEditingController _controller = TextEditingController();
// // bool adsFetched = false;
//
// class ContactList extends StatefulWidget {
//   const ContactList({Key? key}) : super(key: key);
//
//   @override
//   State<ContactList> createState() => ContactListState();
// }
//
// class ContactListState extends State<ContactList> {
//   late int _pageNumber;
//   final int _numberOfContactsPerRequest = 10;
//   late bool _isLastPage;
//   late bool _loading;
//   late bool _error;
//   final int _nextPageTrigger = 0;
//
//   bool _showSearch = false;
//
//   bool isIconVisible = false;
//   bool hidePassword = true;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _contacts = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     readContacts(true);
//     FlutterContacts.addListener(() { print("contacts Change");});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//
//         drawer: Drawer(child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFFDDE6E8),
//               ), child: null,
//             ),
//             ListTile(
//               title: Text(AppLocalizations.of(context).shareToFriends, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                        ShareToFriends()),
//                 );
//               },
//             ),
//            /* ListTile(
//               title: Text(AppLocalizations.of(context).wallet, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomeScreen(2)));
//
//                 /* Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                        WalletScreen()   /* WalletPage()*/),
//                 );*/
//               },
//             ),*/
//             ListTile(
//               title: Text(AppLocalizations.of(context).setting, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                       const Setting()),
//                 );
//                 // Update the state of the app.
//                 // ...
//               },
//             ),
//             ListTile(
//               title: Text(AppLocalizations.of(context).help, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                       const Help(),
//                     ));
//               },
//             ),
//             ListTile(
//               title: Text(AppLocalizations.of(context).aboutUs, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//               onTap: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                       const AboutUs(),
//                     ));
//               },
//             ),
//             ListTile(
//               title: Text(AppLocalizations.of(context).sponsors, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
//                       builder: (context) =>
//                       const SponsorsAdsPage()),
//                 );
//               },
//             ),
//             (SharedPrefs.getAdmin())?
//             ListTile(
//               title: Text(
//                 AppLocalizations.of(context).adminPanel,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ):const ListTile(),
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
//         ),),
//
//         appBar: AppBar(
//           // backgroundColor: Costanat.bgHomeColor,
//
//           /*leading: IconButton(
//             icon: Icon(Icons.menu,color: Costanat.appBarTextColor,
//               size: 26.0,),
//             onPressed: () {
//             },
//           ),*/
//           title: Text(AppLocalizations.of(context).contacts, style: TextStyle(color: Costanat.appBarTextColor,
//               fontSize: 20,fontWeight: FontWeight.w700),
//           ),
//
//           actions: <Widget>[
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {
//
//                     if(_showSearch)
//                       {
//                         setState(() {
//                           _showSearch = false;
//                         });
//                       }
//                     else
//                       {
//                         setState(() {
//                           _showSearch = true;
//                         });
//                       }
//
//                   },
//                   child: Icon(
//                     Icons.search,
//                     size: 26.0,
//                     color:Costanat.appBarTextColor,
//                   ),
//                 )
//             ),
//           ],
//         ),
//
//         body: SizedBox(child: buildContactsView())
//     );
//   }
//
//   Widget buildContactsView() {
//     if (_contacts.isEmpty) {
//       if (_loading) {
//         return const Center(
//             child: Padding(
//           padding: EdgeInsets.all(8),
//           child: CircularProgressIndicator(),
//         ));
//       } else if (_error) {
//         return Center(child: errorDialog(size: 20));
//       }
//     }
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: Column(
//         children: [
//
//           Visibility(
//             visible: _showSearch,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0,right: 20.0,
//                   top: 16.0,bottom: 16.0),
//               child: TextField(
//                 textAlignVertical: TextAlignVertical.center,
//                 style: const TextStyle(fontSize: 16,color: Colors.black45 ),
//                 controller: _controller,
//               //  keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.search,
//                 maxLength: 40,
//                 onChanged: (value) {
//                   searchContacts(_controller.text);
//                 },
//                 decoration: InputDecoration(
//                   counterText: "",
//                   filled: true, //<-- SEE HERE
//                   fillColor: Colors.white,
//                   suffixIcon: GestureDetector(
//                   child: const Icon(Icons.close_rounded ,color: Colors.black87,),
//                     onTap: () {
//                       _controller.text="";
//                       searchContacts(_controller.text);
//                     },
//                   ),
//
//                   hintText: AppLocalizations.of(context).search,
//
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                     borderSide: BorderSide(
//                         width: 1, color: Color(0xFF303237)),  //<-- SEE HERE
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                     borderSide: BorderSide(
//                         width: 1, color: Color(0xFF303237)), //<-- SEE HERE
//                   ),
//
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                     borderSide: BorderSide(
//                       width: 1,
//                       color: Color(0xFF303237),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//
//                 ),
//
//               ),
//             ),
//           ),
//
//           Visibility(
//             visible: false,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Neumorphic(
//                 style: NeumorphicStyle(
//                   depth: -4,
//                   boxShape:
//                       NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
//                 ),
//                 child: TextField(
//                   textAlignVertical: TextAlignVertical.center,
//                   controller: _controller,
//                   textInputAction: TextInputAction.search,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.all(10.0),
//                     suffixIcon: GestureDetector(
//                       child: const Icon(Icons.search),
//                       onTap: () {
//                         searchContacts(_controller.text);
//                       },
//                     ),
//                     hintText: AppLocalizations.of(context).search,
//                   ),
//                   onEditingComplete: () {
//                     searchContacts(_controller.text);
//                   },
//                 ),
//               ),
//             ),
//           ),
//
//           Visibility(
//             visible: false,
//             child: Center(
//               child: SizedBox(
//                 width: 100,
//                 height: 50,
//                 child: NeumorphicButton(
//                   onPressed: () async {
//                     setState(() {
//                       _loading = true;
//                     });
//                     int res = await saveToDb();
//                     if (res > 0) {
//                       _pageNumber = 0;
//                       readContacts(true);
//                       setState(() {
//                         _loading = false;
//                       });
//                     } else {
//                       setState(() {
//                         _loading = false;
//                       });
//                     }
//                   },
//                   style: NeumorphicStyle(
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           const BorderRadius.all(Radius.circular(8)))),
//                   child: Center(
//                     child: Text(
//                       AppLocalizations.of(context).update,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           Expanded(
//             child: _contacts.isNotEmpty
//                 ? ListView.builder(
//                     itemCount:
//                         _contacts.length + (_isLastPage || isSearch ? 0 : 1),
//                     itemBuilder: (context, index) {
//                       if (index == _contacts.length - _nextPageTrigger) {
//                         if (!isSearch) {
//                           readContacts(false);
//                         }
//                       }
//                       if (index == _contacts.length && !isSearch) {
//                         if (_error) {
//                           return Center(child: errorDialog(size: 15));
//                         } else {
//                           return const Center(
//                               child: Padding(
//                             padding: EdgeInsets.all(8),
//                             child: CircularProgressIndicator(),
//                           ));
//                         }
//                       }
//                       return Padding(
//                           padding: const EdgeInsets.only(left: 2, right: 2, top:0.5, bottom: 0.5),
//                           child: _contacts.isNotEmpty
//                               ? createContactsRow(context, _contacts, index)
//                               : const SizedBox());
//                     })
//                 : Center(
//                     child: SizedBox(
//                       width: 90,
//                       height: 90,
//                       child: NeumorphicButton(
//                         onPressed: () async {
//                           setState(() {
//                             _loading = true;
//                           });
//                           int res = await saveToDb();
//                           if (res > 0) {
//                             _pageNumber = 0;
//                             readContacts(true);
//                           } else {
//                             setState(() {
//                               _loading = false;
//                             });
//                           }
//                         },
//                         style: const NeumorphicStyle(
//                             boxShape: NeumorphicBoxShape.circle()),
//                         child: const Center(
//                           child: Text(
//                             'Reload',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget errorDialog({required double size}) {
//     return SizedBox(
//       height: 180,
//       width: 200,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'An error occurred when fetching the posts.',
//             style: TextStyle(
//                 fontSize: size,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           NeumorphicButton(
//               onPressed: () {
//                 setState(() {
//                   _loading = true;
//                   _error = false;
//                   readContacts(true);
//                 });
//               },
//               child: const Text(
//                 "Retry",
//                 style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
//               )),
//         ],
//       ),
//     );
//   }
//
//   Widget createContactsRow222444(
//       BuildContext context, List<ContactEntity>? contacts, int index) {
//     ContactEntity contact = contacts![index];
//     return NeumorphicButton(
//       onPressed: () async {
//         if (Constants.adGroup!.adsList.isEmpty) {
//           bool isFetched = await getGroupAds();
//           if (isFetched) {
//
//            // ComposeMessageScreen
//            // ComposeMessage
//            //  Navigator.push(
//            //    context,
//            //    MaterialPageRoute(
//            //        builder: (context) => ComposeMessageScreen(contact: contact)),
//            //  );
//           }
//         } else {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //       builder: (context) => ComposeMessageScreen(contact: contact)),
//           // );
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(3.0),
//         height: 40,
//         width: double.infinity,
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(25.0),
//               child: contact.photo != null
//                   ? Image.memory(
//                       contact.photo!,
//                       width: 30,
//                       height: 30,
//                     )
//                   : ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minWidth: 46,
//                   minHeight: 46,
//                   maxWidth: 64,
//                   maxHeight: 64,
//                 ),
//                 child: Image.asset("assets/images/img_avatar_contact.png"
//                     , fit: BoxFit.cover),
//               )
//
//               /*const Icon(
//                       Icons.account_circle_outlined,
//                       size: 30,
//                     ),*/
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Text(contact.displayName!, style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color:  Color(0xFF0C0D0F),),)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget createContactsRow(
//       BuildContext context, List<ContactEntity>? contacts, int index) {
//     ContactEntity contact = contacts![index];
//     return GestureDetector(
//       onTap: () async {
//         if (Constants.adGroup!.adsList.isEmpty) {
//           bool isFetched = await getGroupAds();
//           if (isFetched) {
//             // ComposeMessageScreen
//             // ComposeMessage
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //       builder: (context) => ComposeMessageScreen(contact: contact)),
//             // );
//           }
//         } else {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //       builder: (context) => ComposeMessageScreen(contact: contact)),
//           // );
//         }
//       },
//
//       child: Container(
//         padding: const EdgeInsets.only(left: 8,right: 8,top: 7,bottom: 7),
//         //height: 40,
//         color: Colors.white,
//         width: double.infinity,
//         child: Row(
//           children: [
//             ClipRRect(
//                 borderRadius: BorderRadius.circular(25.0),
//                 child: contact.photo != null
//                     ? Image.memory(
//                   contact.photo!,
//                   width: 35,
//                   height: 35,
//                 )
//                    /* : ConstrainedBox(
//                   constraints: BoxConstraints(
//                    /* minWidth: 46,
//                     minHeight: 46,
//                     maxWidth: 64,
//                     maxHeight: 64,*/
//                     minWidth: 43,
//                     minHeight: 43,
//                     maxWidth: 43,
//                     maxHeight: 43,
//                   ),
//                   child: Image.asset("assets/images/img_avatar_contact.png"
//                       , fit: BoxFit.cover),
//                 )*/
//               : const Icon(
//                       Icons.account_circle_outlined,
//                       size: 40,
//                     ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Text(contact.displayName!, style: const TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//               color:  Color(0xFF0C0D0F),),)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> readContacts(bool doClear) async {
//     List<ContactEntity> contacts = await getAllbyPagination(_pageNumber);
//     setState(() {
//       _isLastPage = contacts.length < _numberOfContactsPerRequest;
//       _loading = false;
//       _pageNumber = _pageNumber + 1;
//       if (doClear) {
//         _contacts.clear();
//       }
//       _contacts.addAll(contacts);
//     });
//   }
//
//   Future<void> searchContacts(String searchTerm) async {
//     isSearch = true;
//     List<ContactEntity> contacts = await queryContacts(searchTerm);
//     setState(() {
//       if(contacts.isNotEmpty) {
//         _contacts.clear();
//         _contacts.addAll(contacts);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('There is no contact with this information', textAlign: TextAlign.center),
//         ));
//       }
//     });
//   }
//
//   Future<bool> getGroupAds() async {
//    /* Apis api = Apis();
//     List<dynamic> response = await api.getGroupAds();
//     if (response[0] != null) {
//       Constants.adGroup = response[0];
//       return true;
//     } else {
//       AdsList adsList = AdsList.fromJson(Constants.defaultAds);
//       Constants.adGroup = adsList;
//       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       //   content: Text('Fetching ads failed', textAlign: TextAlign.center),
//       // ));
//       return true;
//     }*/
//     return true;
//   }
// }
//
//
