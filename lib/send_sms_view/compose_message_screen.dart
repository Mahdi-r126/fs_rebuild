import 'dart:async';
import 'dart:ui';

//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/helpers/models/inbox_model.dart';
import 'package:freesms/helpers/smsHelper.dart';
import 'package:freesms/send_sms_view/pinProvider.dart';
import 'package:contacts_service/contacts_service.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:linkfy_text/linkfy_text.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Costanat.dart';
import '../apis/apis.dart';
import '../helpers/constants.dart';
import '../helpers/path_provider.dart';
import '../helpers/sharedprefs.dart';
import '../models/ad.dart';

//import '../utils/app_resource.dart';
//import '../utils/image_decode.dart';
//import '../utils/internet_connection_check.dart';
//import 'models/advertise.dart';
//import 'models/model_auto.dart';
//import 'repository/server_repository.dart';
//import 'package:internet_connection_checker/internet_connection_checker.dart';
//import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'component/my_message_box.dart';
import 'component/other_message_box.dart';

class ComposeMessageScreen extends StatefulWidget {
  late String? phoneNumber;
  String? contactName;
  final  Map<String,InboxModel>? inbox;

  ComposeMessageScreen({
  this.inbox,this.contactName,this.phoneNumber, Key? key})
      : super(key: key);

  @override
  State<ComposeMessageScreen> createState() => _ComposeMessageScreenState();
}

class _ComposeMessageScreenState extends State<ComposeMessageScreen>
    with SingleTickerProviderStateMixin {
 late final String? phoneNumber;
 late final String? contactName;


  final _formKey = GlobalKey<FormState>();

  // کنترلر پیامک نوشته شده توسط کاربر
  TextEditingController userTextController = TextEditingController();

// کنترلر آگهی تبلیغاتی
  TextEditingController adsTextController = TextEditingController();

//کنترلر آگهی تبلیغاتی اضافه
  TextEditingController adsAdditionalTextController = TextEditingController();

  // غیر فعال کردن دکمه ارسال برای زمانی که اپلیکیشن در حال ارسال پیام است تا از ارسال چندباره جلوگیری شود
  bool _disableSend = false;

  // آی دی آگهی تبلیغاتی
  String _adId = '';

  // آی دی آگهی ارسال شده. نکته: چون به محض ارسال آگهی، آگهی تغییر میکرد و آی دی آگهی جدید به جای آی دی آگهی واقعا ارسال شده قرار می گرفت. آی دی آگهی که در واقعیت ارسال شده را در این متغیر ذخیره کردم
  final String _sendAdId = '';

  // آی دی آگهی تبلیغاتی
  int _adFee = 0;

  // قیمت تبلیغ ارسال شده (همان توضیح بالا مدنظر قرار گیرد)
  final int _sendAdFee = 0;

  double screenWidth = 0;
  double screenHeight = 0;
  bool? _withAds = true;
  bool isConnect = true;
  var _connectivityStatus = 'Connected to WiFi';
  final Connectivity _connectivity = Connectivity();
  // bool _isPinned = false;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Ad _ad;
  List<Contact> contacts = ContactHelper.getAll();
  late final adsList;
  late final FocusNode focusNode;
  late final CarouselController carouselController;
  int _currentPage = 0;

  late List<SmsMessage> _messages;
  final RegExp phoneRegex = RegExp(
    r'^(?!021)\+?[1-9]\d{1,14}$',
  );

  @override
  void initState() {
    super.initState();
    phoneNumber=widget.inbox==null?widget.phoneNumber: widget.inbox!.keys.first;
    contactName= widget.inbox==null?widget.contactName:widget.inbox![phoneNumber]!.contactName()!;

    _checkInternetConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    adsList = getGroupAds();
    focusNode = FocusNode();
    carouselController = CarouselController();
    _messages = SmsHelper.specialInbox(phoneNumber!)??[];
  }

  bool checkIdNumber(String str) {
    return RegExp(r'[a-zA-Z]').hasMatch(str);
  }

  Future<void> _checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnect = true;
      });
    } else {
      setState(() {
        isConnect = false;
      });
    }
  }

  // void onFocus() {
  //   setState(() {
  //   });
  // }

  Future<void> _recheckInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnect = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
    });
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _connectivityStatus = 'Connected to WiFi';
          break;
        case ConnectivityResult.mobile:
          _connectivityStatus = 'Connected to mobile network';
          break;
        case ConnectivityResult.none:
          _connectivityStatus = 'No internet connection';
          break;
        default:
          _connectivityStatus = 'Unknown';
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    userTextController.dispose();
    focusNode.dispose();
    // _focusNode!.dispose();
  }

  // void _togglePin(Ad ad) {
  //   setState(() {
  //     _ad=ad;
  //     _isPinned = !_isPinned;
  //   });
  //   if (_isPinned) {
  //     _animationController.forward();
  //   } else {
  //     _animationController.reverse();
  //   }
  // }
  final pinProvider = PinProvider();

  @override
  Widget build(BuildContext context) {
    Uint8List _bytes;

    Future<bool> _handleBackButton() {
      Navigator.pop(context);
      return Future(() => false);
    }

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: ChangeNotifierProvider(
        create: (context) => pinProvider,
        child: Builder(builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            // resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              title: InkWell(
                onTap: () {
                  (ContactHelper.getContactId(phoneNumber!) != null)
                      ? launch(
                          "content://com.android.contacts/contacts/${ContactHelper.getContactId(phoneNumber!)}")
                      : launch("tel://$phoneNumber");
                  print(ContactHelper.getContactId(phoneNumber!));
                },
                child: Text(
                  (contactName != null)
                      ? contactName!
                      : phoneNumber!,
                  //  widget.contactdisplayName,
                ),
              ),
            ),

            body: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<PinProvider>(
                      builder: (context, pinProvider, child) {
                        if (pinProvider.pinned) {
                          print(pinProvider.pinned);
                        }
                        return Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/chat_bg.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            MessageContent(),
                            (!pinProvider.pinned &&
                                    SharedPrefs.getReward() == true && ContactHelper.isInContact(widget.phoneNumber!)
                                && phoneRegex.hasMatch(widget.phoneNumber!))
                                ? AdsContent(pinProvider)
                                : const SizedBox.shrink(),
                            (pinProvider.pinned &&
                                    SharedPrefs.getReward() == true && ContactHelper.isInContact(widget.phoneNumber!) &&
                        phoneRegex.hasMatch(widget.phoneNumber!))
                                ? PinBox(pinProvider)
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    ),
                  ),
                  MessageForm(pinProvider),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  ///PinBox
  Widget PinBox(PinProvider pinProvider) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (pinProvider.ad != null && pinProvider.ad!.image != "")
                ? CachedNetworkImage(
                    imageUrl: pinProvider.ad!.image,
                    height: 50,
                    width: 80,
                    fit: BoxFit.fill,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              pinProvider.ad?.text! ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    focusNode.unfocus();
                    pinProvider.setPinned(!pinProvider.pinned, pinProvider.ad);
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.black,
                    size: 30,
                  )),
            )
          ],
        ));
  }

  ///MessagesContent
  Widget MessageContent() {
    return (_messages.isNotEmpty)
        ? ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              SmsMessage message = _messages[index];
              // message.read=true;
              message.onStateChanged;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: message.kind == SmsMessageKind.sent
                    ? MyMessageBox(
                        message: message,
                      )
                    : OtherMessageBox(message: message),
              );
            },
          )
        : Container(
            child: Center(
            child: Text(AppLocalizations.of(context).noResultFound,
                style: const TextStyle(color: Colors.black)),
          ));
  }

  ///Ads box
  Widget AdsContent(PinProvider provider) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: (isConnect)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: (isConnect &&
                          _connectivityStatus == 'Connected to WiFi' ||
                      isConnect &&
                          _connectivityStatus == 'Connected to mobile network'),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 15, right: 15),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _withAds,
                              onChanged: (bool? value) {
                                setState(() {
                                  _withAds = value;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context).withAdvertising,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "iransansweb"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // (isConnect && _connectivityStatus == 'Connected to WiFi' ||
                //         isConnect &&
                //             _connectivityStatus == 'Connected to mobile network')
                //     ?

                SingleChildScrollView(
                  child: FutureBuilder(
                    //method to be waiting for in the future
                    future: adsList,
                    // _serverRepository.getAdvertise(phoneNumber: widget.contact),
                    builder: (context, snapshot) {
                      //if done show data,
                      if (snapshot.connectionState == ConnectionState.done) {

                        if (snapshot.data == null) {
                          return const Center(
                            child: Text(
                              "تبلیغی برای نمایش وجود ندارد",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF3f51b5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "iransansweb"),
                            ),
                          );
                        }

                        var list = snapshot.data as List<Ad>;

                        // if(Provider.of<PinProvider>(context,listen: false).ad==null){
                        //   Provider.of<PinProvider>(context,listen: false).setAd(list[0]);
                        // }


                        _adId = list[0].adId!;

                        _adFee = Constants.teens
                                .contains(phoneNumber!.substring(0, 4))
                            ? 40
                            : list[0]
                                    .targetPhoneNumbers
                                    .contains(phoneNumber!)
                                ? list[0].senderFee
                                : list[0].fee;

                        adsTextController.text = list[0].text ?? '';
                        adsAdditionalTextController.text =
                            list[0].additionalText ?? '';

                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: list.length,
                            options: CarouselOptions(
                              initialPage: _currentPage,
                              enlargeCenterPage: true,
                              height: MediaQuery.of(context).size.height * 0.4,

                              aspectRatio: 16 / 9,
                              enlargeFactor: 0.2,

                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {
                                pinProvider.setAdd(list[index]);

                                setState(() {
                                  _currentPage = index;
                                });

                                _adId = list[index].adId!;

                                _adFee = Constants.teens.contains(
                                        phoneNumber!.substring(0, 4))
                                    ? 40
                                    : list[index].targetPhoneNumbers.contains(
                                              phoneNumber!,
                                            )
                                        ? list[index].senderFee
                                        : list[index].fee;

                                adsTextController.text = list[index].text!;
                                adsAdditionalTextController.text =
                                    list[index].additionalText ?? '';
                              },
                              // autoPlay: true,
                              //  autoPlayInterval: Duration(seconds:3),
                              reverse: true,
                            ),
                            itemBuilder: (context, i, id) {
                              //for onTap to redirect to another screen
                              return Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: GestureDetector(
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.red,
                                    // margin: EdgeInsets.only(top: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        //  color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFE5E7EF),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 130,
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              //  color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            width: double.infinity,
                                            child: Stack(
                                              children: [
                                                Visibility(
                                                  visible: true,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      //  _imageBase64String = ad.image.isNotEmpty ? ad.image : Constants.adImage;
                                                      /// child: Image.memory(Base64Decoder().convert(list[i].image),
                                                      child: (list[i].image !=
                                                              "")
                                                          ? CachedNetworkImage(
                                                              imageUrl:
                                                                  list[i].image,
                                                              fit: BoxFit.fill,
                                                              width: double
                                                                  .infinity,
                                                            )
                                                          : Center(
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    "https://sms-static.storage.iran.liara.space/ads/6432bd965e377e30d38f293f.jpg",
                                                                height: 150,
                                                                width: 250,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black38,
                                                    ),
                                                    child: Center(
                                                      child: IconButton(
                                                        icon: const Icon(
                                                          Icons
                                                              .fullscreen_exit_outlined,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          final pinProvider =
                                                              Provider.of<
                                                                      PinProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          pinProvider.setPinned(
                                                              !pinProvider
                                                                  .pinned,
                                                              list[i]);
                                                        },
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: true,
                                                  child: Positioned(
                                                    bottom: -30, // -30
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width: 60, //60
                                                      height: 60, // 60
                                                      decoration: BoxDecoration(
                                                        //  shape: BoxShape.circle,
                                                        color: Colors.black87
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                      ),

                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Text(
                                                          " قیمت: " +
                                                              list[i]
                                                                  .fee
                                                                  .toString(), //list[i].fee.toString(),
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(list[i].status!,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      //fontFamily: AppTheme.fontYekanNumRegular,
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            visible: false,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              //  height: 140,
                                              //   color: Colors.green,
                                              child: LinkifyText(
                                                list[i]
                                                    .text!
                                                    .replaceAll('\\n', '\n'),
                                                textAlign: TextAlign.end,
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                                linkStyle: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15),
                                                onTap: (link) {
                                                  if (link.type ==
                                                      LinkType.url) {
                                                    _launchURL(link.value);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _adId = list[i].adId!;
                                    _adFee = Constants.teens.contains(
                                            phoneNumber!.substring(0, 4))
                                        ? 40
                                        : list[i]
                                                .targetPhoneNumbers
                                                .contains(phoneNumber!)
                                            ? list[i].senderFee
                                            : list[i].fee;

                                    adsTextController.text = list[i].text!;
                                    adsAdditionalTextController.text =
                                        list[i].additionalText ?? '';

                                    print("_adId  " + _adId);
                                    print("_sendAdId  " + _sendAdId);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // return widget informing of error
                        return const Text(
                          " خطا در برقراری ارتباط با سرور ",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF3f51b5),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "iransansweb"),
                        );
                      } else {
                        //if the process is not finished then show the indicator process
                        final cachedData = HiveCacheStore(AppPathProvider.path);

                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: CircularProgressIndicator(
                                color: Color(0xFF3f51b5),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // : Container(
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Text(
                //               "اینترنت شما قطع می باشد \nاما به راحتی میتوانید پیامک های خودتان را ارسال کنید",
                //               textAlign: TextAlign.center),
                //           const SizedBox(height: 10),
                //           MaterialButton(
                //             onPressed: () {
                //               _recheckInternetConnectivity();
                //             },
                //             shape: const RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(10))),
                //             color: Colors.blue.shade900,
                //             child: const Text(
                //               "دوباره سعی کنید",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   child: Visibility(
                //     visible: (isConnect &&
                //             _connectivityStatus == 'Connected to WiFi' ||
                //         isConnect &&
                //             _connectivityStatus ==
                //                 'Connected to mobile network'),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //           top: 10,
                //           bottom: 10,
                //           right: MediaQuery.of(context).size.width * 0.25,
                //           left: MediaQuery.of(context).size.width * 0.25),
                //       child: OutlinedButton(
                //         onPressed: () {
                //           Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => AdsTheme(
                //                       phoneNumber: phoneNumber!,
                //                       // contactdisplayName: widget.contactdisplayName,
                //                       //  contactNumber: widget.contactNumber,
                //                     )),
                //           );
                //         },
                //         child: Text(
                //           AppLocalizations.of(context).changeCategory,
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontStyle: FontStyle.italic,
                //               color: Colors.blue.shade800,
                //               fontWeight: FontWeight.w700),
                //         ),
                //         style: OutlinedButton.styleFrom(
                //           side: BorderSide(
                //               width: 1.0, color: Colors.blue.shade800),
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 16, horizontal: 13),
                //           shape: const RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///user message form
  Widget MessageForm(PinProvider provider) {
    return (!checkIdNumber(phoneNumber!))
        ? Visibility(
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, bottom: 5, top: 5),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                  selectionColor: Colors.blue,
                                  cursorColor: Colors.red.shade900,
                                )),
                                child: TextFormField(
                                  cursorColor: Costanat.selectedIconColor,
                                  textAlign: TextAlign.right,
                                  focusNode: focusNode,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                  controller: userTextController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onTap: () {
                                    final isOpen = pinProvider.pinned;
                                    if (!isOpen) {
                                      pinProvider.closePin();
                                    }
                                  },
                                  //expands: true,
                                  // maxLength: 11,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black12, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    contentPadding: const EdgeInsets.all(10.0),
                                    hintText:
                                        AppLocalizations.of(context).message,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 1),
                            child: SizedBox(
                                width: 56,
                                height: 48,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF2C66FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15), // <-- Radius
                                    ), // HexColor("#F46D9D")
                                  ),
                                  onPressed: _disableSend
                                      ? null
                                      : () async {
                                          String message =
                                              userTextController.text;
                                          if (userTextController
                                              .text.isNotEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                              'Please wait, message is sending',
                                              textAlign: TextAlign.center,
                                            )));
                                            if (SharedPrefs.getReward() ==
                                                    true &&
                                                _withAds == true && pinProvider.ad!=null) {
                                              message = userTextController
                                                          .text.length <
                                                      70
                                                  ? '${userTextController.text} \n \n \n . \n ⬇️ تبلیغ از http://smsonlines.ir ⬇️ \n \n . \n ${pinProvider.ad?.text ?? ''} \n ${pinProvider.ad?.additionalText ?? ''}'
                                                  : '${userTextController.text} \n \n \n . \n ⬇️ تبلیغ از http://smsonlines.ir ⬇️ \n \n . \n ${pinProvider.ad?.text ?? ''}';
                                            }

                                            final sendResult = await _sendSMS(
                                                message, [phoneNumber!]);

                                            if (sendResult) {
                                              userTextController.clear();
                                              final smsMessage =
                                                  SmsMessage.fromJson({
                                                'address': phoneNumber!,
                                                'kind': SmsMessageKind.sent,
                                                'date': DateTime.now()
                                                    .millisecondsSinceEpoch,
                                                'date_sent': DateTime.now()
                                                    .millisecondsSinceEpoch,
                                                'read': 1,
                                                'body': message,
                                              });
                                              SmsHelper.addToMessages(phoneNumber!, smsMessage);
                                              await SmsHelper.updateInbox();


                                              setState(() {
                                                _messages = [
                                                  smsMessage,
                                                  ..._messages,
                                                ];
                                              });
                                              if (SharedPrefs.getReward() ==
                                                      true &&
                                                  _withAds == true) {
                                                if (pinProvider.ad != null) {
                                                  await updateWallet(
                                                      SharedPrefs
                                                          .getPhoneNumber(),
                                                      phoneNumber!,
                                                      Constants.SEND_MESSAGE,
                                                      pinProvider.ad!.adId!);
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      AppLocalizations.of(
                                                                              context)
                                                                          .congratulations,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                  content: Text(
                                                                      '${pinProvider.ad!.fee} ${AppLocalizations.of(context).tomanAddToWallet}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context,
                                                                                rootNavigator: true)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                Colors.green,
                                                                            borderRadius: BorderRadius.all(Radius.circular(4))),
                                                                        padding:
                                                                            const EdgeInsets.all(14),
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)
                                                                              .ok,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ));
                                                  });
                                                }
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                  'Failed',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ));
                                              setState(() {
                                                _disableSend = false;
                                              });
                                            }
                                            //
                                            // if (SharedPrefs.getReward() ==
                                            //         false &&
                                            //     _withAds == false) {
                                            //   if (sendResult) {
                                            //     userTextController.text = "";
                                            //   } else {}
                                            // } else {
                                            //   if (isConnect &&
                                            //           _connectivityStatus ==
                                            //               'Connected to WiFi' ||
                                            //       isConnect &&
                                            //           _connectivityStatus ==
                                            //               'Connected to mobile network') {
                                            //     _sendAdId = _adId;
                                            //     _sendAdFee = _adFee;
                                            //
                                            //     var sendResult = await _sendSMS(
                                            //         message,
                                            //         [widget.phoneNumber!]);
                                            //
                                            //     // FolderScreen.of(
                                            //     //   widget.allChatsPageContext ??
                                            //     //       context,
                                            //     // )?.addToLastMessages(
                                            //     //     smsMessage);
                                            //
                                            //     if (sendResult) {
                                            //       userTextController.text = "";
                                            //       String? res =
                                            //           await updateWallet(
                                            //               SharedPrefs
                                            //                   .getPhoneNumber(),
                                            //               widget.phoneNumber!,
                                            //               Constants
                                            //                   .SEND_MESSAGE,
                                            //               _sendAdId);
                                            //
                                            //       WidgetsBinding.instance
                                            //           .addPostFrameCallback(
                                            //               (_) {
                                            //         showDialog(
                                            //             context: context,
                                            //             builder:
                                            //                 (ctx) =>
                                            //                     AlertDialog(
                                            //                       title: Text(
                                            //                           AppLocalizations.of(
                                            //                                   context)
                                            //                               .congratulations,
                                            //                           textAlign:
                                            //                               TextAlign
                                            //                                   .center),
                                            //                       content: Text(
                                            //                           '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
                                            //                           textAlign:
                                            //                               TextAlign
                                            //                                   .center),
                                            //                       actions: <
                                            //                           Widget>[
                                            //                         TextButton(
                                            //                           onPressed:
                                            //                               () {
                                            //                             Navigator.of(context,
                                            //                                     rootNavigator: true)
                                            //                                 .pop();
                                            //                           },
                                            //                           child:
                                            //                               Container(
                                            //                             width: double
                                            //                                 .infinity,
                                            //                             decoration: const BoxDecoration(
                                            //                                 color:
                                            //                                     Colors.green,
                                            //                                 borderRadius: BorderRadius.all(Radius.circular(4))),
                                            //                             padding:
                                            //                                 const EdgeInsets.all(14),
                                            //                             child:
                                            //                                 Text(
                                            //                               AppLocalizations.of(context)
                                            //                                   .ok,
                                            //                               style:
                                            //                                   const TextStyle(
                                            //                                 color:
                                            //                                     Colors.white,
                                            //                                 fontSize:
                                            //                                     18,
                                            //                               ),
                                            //                               textAlign:
                                            //                                   TextAlign.center,
                                            //                             ),
                                            //                           ),
                                            //                         ),
                                            //                       ],
                                            //                     ));
                                            //       });
                                            //     } else {
                                            //       ScaffoldMessenger.of(context)
                                            //           .showSnackBar(
                                            //               const SnackBar(
                                            //         content: Text(
                                            //           'Failed',
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //         ),
                                            //       ));
                                            //       setState(() {
                                            //         _disableSend = false;
                                            //       });
                                            //     }
                                            //   } else {
                                            //     var sendResult = await _sendSMS(
                                            //         userTextController.text,
                                            //         [widget.phoneNumber!]);
                                            //
                                            //     if (sendResult) {
                                            //       userTextController.text = "";
                                            //
                                            //       WidgetsBinding.instance
                                            //           .addPostFrameCallback(
                                            //               (_) {
                                            //         showDialog(
                                            //             context: context,
                                            //             builder:
                                            //                 (ctx) =>
                                            //                     AlertDialog(
                                            //                       title: Text(
                                            //                           AppLocalizations.of(
                                            //                                   context)
                                            //                               .congratulations,
                                            //                           textAlign:
                                            //                               TextAlign
                                            //                                   .center),
                                            //                       content: Text(
                                            //                           '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
                                            //                           textAlign:
                                            //                               TextAlign
                                            //                                   .center),
                                            //                       actions: <
                                            //                           Widget>[
                                            //                         TextButton(
                                            //                           onPressed:
                                            //                               () {
                                            //                             Navigator.of(context,
                                            //                                     rootNavigator: true)
                                            //                                 .pop();
                                            //                           },
                                            //                           child:
                                            //                               Container(
                                            //                             width: double
                                            //                                 .infinity,
                                            //                             decoration: const BoxDecoration(
                                            //                                 color:
                                            //                                     Colors.green,
                                            //                                 borderRadius: BorderRadius.all(Radius.circular(4))),
                                            //                             padding:
                                            //                                 const EdgeInsets.all(14),
                                            //                             child:
                                            //                                 Text(
                                            //                               AppLocalizations.of(context)
                                            //                                   .ok,
                                            //                               style:
                                            //                                   const TextStyle(
                                            //                                 color:
                                            //                                     Colors.white,
                                            //                                 fontSize:
                                            //                                     18,
                                            //                               ),
                                            //                               textAlign:
                                            //                                   TextAlign.center,
                                            //                             ),
                                            //                           ),
                                            //                         ),
                                            //                       ],
                                            //                     ));
                                            //       });
                                            //     } else {
                                            //       ScaffoldMessenger.of(context)
                                            //           .showSnackBar(
                                            //               const SnackBar(
                                            //         content: Text(
                                            //           'Failed',
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //         ),
                                            //       ));
                                            //       setState(() {
                                            //         _disableSend = false;
                                            //       });
                                            //     }
                                            //   }
                                            // }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content:
                                                        Text("fill data")));
                                          }
                                        },
                                  child: const Icon(
                                    Icons.send,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ))),
            visible: true,
          )
        : const Center(
            child: Text(
          "you can't send message to Id number",
          style: TextStyle(fontSize: 14),
          maxLines: 1,
        ));
  }

  ///helpers
  Future<List<Ad>?> getGroupAds() async {
    Apis api = Apis();
    try {
      List<dynamic> response = await api.getGroupAds();
      if (response[0] != null) {
        Constants.adGroup = response[0];
        return Constants.adGroup!.adsList;
      } else {
        return Constants.adGroup!.adsList;
      }
    } catch (e) {
      print("no internet");
      return null;
    }
  }

  _launchURL(String? url) async {
    if (url != null) {
      final Uri urlLaunchUri = Uri(
        scheme: url.startsWith('https')
            ? 'https'
            : url.startsWith('http')
                ? 'http'
                : 'https',
        path: url.startsWith('https')
            ? url.replaceAll('https:', '')
            : url.startsWith('http')
                ? url.replaceAll('http:', '')
                : url,
      );

      if (await canLaunchUrl(urlLaunchUri)) {
        await launchUrl(urlLaunchUri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Future<bool> _sendSMS(String message, List<String> recipients) async {
    if (await permissionCheckAndRequest()) {
      await sendSMS(message: message, recipients: recipients, sendDirect: true)
          .catchError((onError) {
        return Future.value(onError.toString());
      });
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> permissionCheckAndRequest() async {
    if (await Permission.sms.status.isDenied) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.sms].request();
      return Future.value(statuses[Permission.sms] == PermissionStatus.granted);
    } else {
      return Future.value(true);
    }
  }

  Future<String?> updateWallet(
      String sender, String receiver, String purpose, String adId) async {
    Apis api = Apis();
    List<dynamic> response =
        await api.updateWallet(sender, receiver, purpose, adId);

    if (response[0] != null) {
      String? message = response[0];
      return message;
    } else {
      return response[1];
    }
  }
}
