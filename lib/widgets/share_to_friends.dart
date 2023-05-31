
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:freesms/helpers/constants.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import '../Costanat.dart';
import '../apis/apis.dart';
// import '../domain/entities/contact.dart';
import 'package:contacts_service/contacts_service.dart';
import '../helpers/string_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../presentation/shared/utils/send_sms_repository_impl.dart';


class ShareToFriends extends StatefulWidget {
  const ShareToFriends({Key? key}) : super(key: key);

  @override
  State<ShareToFriends> createState() => ShareToFriendsState();
}

class ShareToFriendsState extends State<ShareToFriends> {
  List<String> friendsPhones = [];

  List<Contact> _contacts = [];
  // int offs = 0;
  bool _showSearch = false;
  // bool _isLoading = false;
  // final _scrollController = ScrollController();
  late BuildContext _context;
  late bool _loading = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contacts = ContactHelper.getAll();
    // _scrollController.addListener(_scrollListener);
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

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
  //
  //     _context.read<ReadContactsBloc>().getContacts(offs, "");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // ReadContactsBloc readContactsBloc = sl<ReadContactsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).inviteFriends,
          style: TextStyle(
              color: Costanat.appBarTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10),
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
              Builder(
                builder: (context) {
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
                              _contacts = await ContactHelper.queryContacts(value);
                              setState(() {
                                // offs = 0;
                                // _contacts = [];
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
                      ));
                },
              ),
              Expanded(
                child: ListView.builder(
                          key: const PageStorageKey<String>('page'),
                          itemCount: _contacts.length,
                          itemBuilder: (context, index) {
                              return createContactsRow(context, _contacts[index], index);
                          })
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        backgroundColor: friendsPhones.isEmpty ? const Color(0xFFC5D4FF) : const Color(0xFF2C66FF),
        child: _loading ? const Padding(
          padding: EdgeInsets.all(18.0),
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
        ) : const Icon(Icons.send, color: Colors.white,),
        onPressed: () async {
          if(friendsPhones.isEmpty) {
            // if phone list is empty
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context).pleaseSelectContacts,
                  textAlign: TextAlign.center),
            ));
            return;
          }
          // start loading
          setState(() {
            _loading = !_loading;
          });
          // check phone list is not empty
            // message to be sent
            var message = Constants.defaultAds['ads'][0]['text'];
            // send message and get result
            var sendResult = await _sendSMS(message, friendsPhones);
            // send success
            if (sendResult) {
              // list of .... responses
              List<String> responses = [];

              for (int i = 0; i < friendsPhones.length; i++) {
                // update wallet for each sms message
                List<dynamic> res = await updateWalletForShare(
                    SharedPrefs.getPhoneNumber(),
                    friendsPhones[i],
                    Constants.SHARE_TO_FRIEND);
                // continue or catch error response
                if (res[0]) {
                  // continue
                  responses.add(res[1]);
                } else {
                  setState(() {
                    _loading = !_loading;
                  });
                  // catch
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(res[1], textAlign: TextAlign.center),
                  ));
                }
              }
              // if update wallet for all is ok
              if (responses.length == friendsPhones.length) {
                setState(() {
                  _loading = false;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(AppLocalizations.of(context).congratulations,
                                textAlign: TextAlign.center),
                            content: Text(
                                '${responses.length * 200} ${AppLocalizations.of(context).tomanAddToWallet}',
                                textAlign: TextAlign.center),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4))),
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    AppLocalizations.of(context).ok,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ));
                });
              } else {
                // if update wallet for all is failed
                setState(() {
                  _loading = false;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(AppLocalizations.of(context).info,
                                textAlign: TextAlign.center),
                            content: Text(AppLocalizations.of(context).successfullyShared,
                                textAlign: TextAlign.center),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4))),
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    AppLocalizations.of(context).ok,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ));
                });
              }
            } else {
              // send fail
              setState(() {
                _loading = !_loading;
              });
            }
        },
      ),
    );
  }

  Widget createContactsRow(BuildContext context, Contact contact, int index) {

    bool check() {
      if(contact.phones != null) {
        if(contact.phones!.isNotEmpty) {
          return friendsPhones.contains(contact.phones![0].value!);
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    print(friendsPhones.contains(contact.phones!.isNotEmpty ? contact.phones![0].value! : "0") ? true : false);
    print(friendsPhones);
    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 80,
      width: double.infinity,
      child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  contact.displayName != null ? contact.displayName![0] : " ? ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: stringToColor(contact.displayName!),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  contact.displayName != null ? contact.displayName! : " ",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              SizedBox(
                child: Checkbox(
                  value: check(),
                  onChanged: (value) {
                    if (value!) {
                     if(contact.phones != null) {
                       if(contact.phones!.isNotEmpty) {
                         friendsPhones.add(contact.phones![0].value!);
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
                    } else {
                      if(contact.phones != null) {
                        if(contact.phones!.isNotEmpty) {
                          friendsPhones.remove(contact.phones![0].value!);
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
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
    );
  }

  Future<bool> _sendSMS(String message, List<String> recipients) async {
    if (await permissionCheckAndRequest()) {
      await sendSMS(message: message, recipients: recipients, sendDirect: true)
          .catchError((onError) {
        return Future.value(onError.toString());
      });
      SharedPrefs.setAllMessage(await SmsQuery().querySms(
        kinds: [SmsQueryKind.sent,SmsQueryKind.inbox],
        count: 300,
      ),);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<List<dynamic>> updateWalletForShare(String sender, String receiver, String purpose) async {
    Apis api = Apis();
    List<dynamic> response =
        await api.updateWallet(sender, receiver, purpose, "");

    if (response[0] != null) {
      return [true, response[0]];
    } else {
      return [false, response[1]];
    }
  }
}
