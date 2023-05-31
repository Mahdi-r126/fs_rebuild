import 'dart:math';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/home_view/widget/drawer.dart';
import 'package:freesms/presentation/pages/home/contacts_view/read_contacts_bloc.dart';
import 'package:freesms/presentation/pages/home/contacts_view/read_contacts_state.dart';
import '../../../../Costanat.dart';
// import '../../../../domain/entities/contact.dart';
import '../../../../helpers/constants.dart';
import '../../../../helpers/string_helper.dart';
import '../../../../home_view/chats_veiw/screens/messages/message_screen.dart';
import '../../../../pages/about_us.dart';
import '../../../../pages/help.dart';
import '../../../../pages/setting.dart';
import '../../../../pages/wallet_page.dart';
import '../../../../send_sms_view/compose_message_screen.dart';
import '../../../../widgets/share_to_friends.dart';
import '../../../shared/utils/injection_container.dart';
import '../../sponsor_ads/sponsors_ads_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadContactsPage extends StatefulWidget {
  bool? removeDrawer;
  ReadContactsPage({Key? key,this.removeDrawer}) : super(key: key);

  @override
  State<ReadContactsPage> createState() => _ReadContactsPageState();
}

class _ReadContactsPageState extends State<ReadContactsPage> {
  List<Contact> _contacts = [];
  // int offs = 0;
  bool _showSearch = false;
  // bool _isLoading = false;
  // final _scrollController = ScrollController();
  late BuildContext _context;
  // ReadContactsBloc readContactsBloc = sl<ReadContactsBloc>();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    _contacts = ContactHelper.getAll();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  // void _scrollListener() {
  //   if (_scrollController.offset >=
  //           _scrollController.position.maxScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     _loadMoreData();
  //   }
  // }

  // void _loadMoreData() async {
  //   if (!_isLoading) {
  //     setState(() {
  //       _isLoading = true;
  //       offs = offs + 20;
  //     });
  //     _context.read<ReadContactsBloc>().getContacts(offs, "");
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    // if(offs == 0) {
    //   readContactsBloc..getContacts(offs, "");
    // }
    return Scaffold(
      drawer: (widget.removeDrawer==false)?const MainDrawer():null,
      appBar: AppBar(
        title: Text(
          "Contact",
          style: TextStyle(
              color: Costanat.appBarTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (_showSearch) {
                    setState(() {
                      _showSearch = false;
                    });
                  } else {
                    setState(() {
                      _showSearch = true;
                    });
                  }
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                  color: Costanat.appBarTextColor,
                ),
              )),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 5.0, bottom: 5.0),
          child: Column(
            children: [
              Builder(builder: (context) {
                return Visibility(
                  visible: _showSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 16.0, bottom: 16.0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black45),
                      textInputAction: TextInputAction.search,
                      maxLength: 40,
                      controller: textEditingController,
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          // _contacts = [];
                          _contacts = await ContactHelper.queryContacts(value);
                          setState(() {
                            // offs = 0;
                          });
                          // _context
                          //     .read<ReadContactsBloc>()
                          //     .getContacts(offs, value);
                        } else {
                          _contacts = ContactHelper.getAll();
                          setState(() {
                            // offs = 0;
                            // _contacts = [];
                          });
                          // _context
                          //     .read<ReadContactsBloc>()
                          //     .getContacts(offs, "");
                        }
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        //<-- SEE HERE
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.black87,
                          ),
                          onTap: () {
                            _contacts = ContactHelper.getAll();
                            setState(() {
                              textEditingController.text = "";
                              // offs = 0;
                              // _contacts = [];
                            });
                            // _context
                            //     .read<ReadContactsBloc>()
                            //     .getContacts(offs, "");
                          },
                        ),

                        hintText: AppLocalizations.of(context).search,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF303237)), //<-- SEE HERE
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF303237)), //<-- SEE HERE
                        ),

                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF303237),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Expanded(
                child: ListView.builder(
                          key: const PageStorageKey<String>('page'),
                          itemCount: _contacts.length,
                          itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                onTap: () async {
                                  if(_contacts[index].phones != null) {
                                    if(_contacts[index].phones!.isNotEmpty) {
                                      if (Constants.adGroup!.adsList.isEmpty) {
                                        bool isFetched = await getGroupAds();
                                        if (isFetched) {
                                          // ComposeMessageScreen
                                          // ComposeMessage
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ComposeMessageScreen(phoneNumber:ContactHelper.clearNumber(_contacts[index].phones![0].value!),contactName: _contacts[index].displayName,)),
                                          );
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComposeMessageScreen(phoneNumber: ContactHelper.clearNumber( _contacts[index].phones![0].value!),contactName: _contacts[index].displayName,)),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text("فاقد شماره تلفن", textAlign: TextAlign.center),
                                      ));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("فاقد شماره تلفن", textAlign: TextAlign.center),
                                    ));
                                  }
                                },
                                leading: SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: CircleAvatar(
                                    child: Text(
                                      _contacts[index].displayName != null ? _contacts[index].displayName![0] : " ? ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: stringToColor(_contacts[index].displayName!),
                                  ),
                                ),
                                title: const Text("",
                                    style: TextStyle(
                                        color: Color(0xFF0C0D0F),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "iransansweb")),
                                subtitle: Text(_contacts[index].displayName ?? " ",
                                    style: const TextStyle(
                                        color: Color(0xFF7E8494),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "iransansweb")),
                              );
                            })
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:freesms/helpers/contactHelper.dart';
// import 'package:freesms/home_view/widget/drawer.dart';
// import 'package:freesms/presentation/pages/home/contacts_view/read_contacts_bloc.dart';
// import 'package:freesms/presentation/pages/home/contacts_view/read_contacts_state.dart';
// import '../../../../Costanat.dart';
// import '../../../../domain/entities/contact.dart';
// import '../../../../helpers/constants.dart';
// import '../../../../home_view/chats_veiw/screens/messages/message_screen.dart';
// import '../../../../pages/about_us.dart';
// import '../../../../pages/help.dart';
// import '../../../../pages/setting.dart';
// import '../../../../pages/wallet_page.dart';
// import '../../../../send_sms_view/compose_message_screen.dart';
// import '../../../../widgets/share_to_friends.dart';
// import '../../../shared/utils/injection_container.dart';
// import '../../sponsor_ads/sponsors_ads_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ReadContactsPage extends StatefulWidget {
//   bool? removeDrawer;
//   ReadContactsPage({Key? key,this.removeDrawer}) : super(key: key);
//
//   @override
//   State<ReadContactsPage> createState() => _ReadContactsPageState();
// }
//
// class _ReadContactsPageState extends State<ReadContactsPage> {
//   List<Contact> _contacts = [];
//   // int offs = 0;
//   bool _showSearch = false;
//   // bool _isLoading = false;
//   // final _scrollController = ScrollController();
//   late BuildContext _context;
//   // ReadContactsBloc readContactsBloc = sl<ReadContactsBloc>();
//   TextEditingController textEditingController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // _scrollController.addListener(_scrollListener);
//     _contacts = ContactHelper.getAll();
//   }
//
//   @override
//   void dispose() {
//     // _scrollController.dispose();
//     super.dispose();
//   }
//
//   // void _scrollListener() {
//   //   if (_scrollController.offset >=
//   //           _scrollController.position.maxScrollExtent &&
//   //       !_scrollController.position.outOfRange) {
//   //     _loadMoreData();
//   //   }
//   // }
//
//   // void _loadMoreData() async {
//   //   if (!_isLoading) {
//   //     setState(() {
//   //       _isLoading = true;
//   //       offs = offs + 20;
//   //     });
//   //     _context.read<ReadContactsBloc>().getContacts(offs, "");
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // if(offs == 0) {
//     //   readContactsBloc..getContacts(offs, "");
//     // }
//     return BlocProvider(
//       create: (BuildContext context) => readContactsBloc..getContacts(offs, ""),
//       child: Scaffold(
//         drawer: (widget.removeDrawer==false)?const MainDrawer():null,
//         appBar: AppBar(
//           title: Text(
//             "Contact",
//             style: TextStyle(
//                 color: Costanat.appBarTextColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700),
//           ),
//           actions: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_showSearch) {
//                       setState(() {
//                         _showSearch = false;
//                       });
//                     } else {
//                       setState(() {
//                         _showSearch = true;
//                       });
//                     }
//                   },
//                   child: Icon(
//                     Icons.search,
//                     size: 26.0,
//                     color: Costanat.appBarTextColor,
//                   ),
//                 )),
//           ],
//         ),
//         body: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 left: 10, right: 10, top: 5.0, bottom: 5.0),
//             child: Column(
//               children: [
//                 Builder(builder: (context) {
//                   return Visibility(
//                     visible: _showSearch,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20.0, right: 20.0, top: 16.0, bottom: 16.0),
//                       child: TextField(
//                         textAlignVertical: TextAlignVertical.center,
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.black45),
//                         textInputAction: TextInputAction.search,
//                         maxLength: 40,
//                         controller: textEditingController,
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             setState(() {
//                               offs = 0;
//                               _contacts = [];
//                             });
//                             _context
//                                 .read<ReadContactsBloc>()
//                                 .getContacts(offs, value);
//                           } else {
//                             setState(() {
//                               offs = 0;
//                               _contacts = [];
//                             });
//                             _context
//                                 .read<ReadContactsBloc>()
//                                 .getContacts(offs, "");
//                           }
//                         },
//                         decoration: InputDecoration(
//                           counterText: "",
//                           filled: true,
//                           //<-- SEE HERE
//                           fillColor: Colors.white,
//                           suffixIcon: GestureDetector(
//                             child: const Icon(
//                               Icons.close_rounded,
//                               color: Colors.black87,
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 textEditingController.text = "";
//                                 offs = 0;
//                                 _contacts = [];
//                               });
//                               _context
//                                   .read<ReadContactsBloc>()
//                                   .getContacts(offs, "");
//                             },
//                           ),
//
//                           hintText: AppLocalizations.of(context).search,
//                           enabledBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12.0),
//                             ),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color(0xFF303237)), //<-- SEE HERE
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12.0),
//                             ),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color(0xFF303237)), //<-- SEE HERE
//                           ),
//
//                           border: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12.0),
//                             ),
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: Color(0xFF303237),
//                               style: BorderStyle.solid,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//                 Expanded(
//                   child: Builder(
//                     builder: (context) {
//                       _context = context;
//                       final getContactsState =
//                           context.watch<ReadContactsBloc>().state;
//
//                       if (getContactsState is ReadContactsLoading) {
//                         print("object");
//                         return const Center(
//                           child: SizedBox(height: 100, width: 100,child: CircularProgressIndicator(color: Colors.green,)),
//                         );
//                       } else if (getContactsState is ReadContactsFailure) {
//                         return Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Text(
//                               getContactsState.error,
//                               style: const TextStyle(
//                                   color: Color(0xFF0C0D0F),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                         );
//                       } else if (getContactsState is ReadContactsSuccess) {
//                         if (_contacts.length == offs) {
//                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                             setState(() {
//                               _isLoading = false;
//                               _contacts
//                                   .addAll(getContactsState.contacts.contacts);
//                             });
//                           });
//                         }
//                         return ListView.builder(
//                             key: const PageStorageKey<String>('page'),
//                             controller: _scrollController,
//                             itemCount: _contacts.length + 1,
//                             itemBuilder: (context, index) {
//                               Color randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
//                               if (index == _contacts.length) {
//                                 return Center(
//                                   child: _isLoading
//                                       ? const CircularProgressIndicator()
//                                       : const SizedBox(),
//                                 );
//                               } else {
//                                 return ListTile(
//                                   dense: true,
//                                   onTap: () async {
//                                     if (Constants.adGroup!.adsList.isEmpty) {
//                                       bool isFetched = await getGroupAds();
//                                       if (isFetched) {
//                                         // ComposeMessageScreen
//                                         // ComposeMessage
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ComposeMessageScreen(phoneNumber:ContactHelper.clearNumber(_contacts[index].phoneNumber))),
//                                         );
//                                       }
//                                     } else {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ComposeMessageScreen(phoneNumber: ContactHelper.clearNumber(_contacts[index].phoneNumber))),
//                                       );
//                                     }
//                                   },
//                                   leading: SizedBox(
//                                     height: 64,
//                                     width: 64,
//                                     child: CircleAvatar(
//                                       child: Text(
//                                         _contacts[index].name[0],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       backgroundColor: randomColor,
//                                     ),
//                                   ),
//                                   title: const Text("",
//                                       style: TextStyle(
//                                           color: Color(0xFF0C0D0F),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w800,
//                                           fontFamily: "iransansweb")),
//                                   subtitle: Text(_contacts[index].name ?? " ",
//                                       style: const TextStyle(
//                                           color: Color(0xFF7E8494),
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "iransansweb")),
//                                 );
//                               }
//                             });
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
Future<bool> getGroupAds() async {
  /* Apis api = Apis();
    List<dynamic> response = await api.getGroupAds();
    if (response[0] != null) {
      Constants.adGroup = response[0];
      return true;
    } else {
      AdsList adsList = AdsList.fromJson(Constants.defaultAds);
      Constants.adGroup = adsList;
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Fetching ads failed', textAlign: TextAlign.center),
      // ));
      return true;
    }*/
  return true;
}

