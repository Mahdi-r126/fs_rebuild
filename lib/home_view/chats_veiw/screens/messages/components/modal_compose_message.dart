import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:freesms/domain/entities/contact.dart';
import 'package:linkfy_text/linkfy_text.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../apis/apis.dart';
import '../../../../../helpers/constants.dart';
import '../../../../../helpers/sharedprefs.dart';
import '../../../../../models/ad.dart';
import '../../../../../pages/ads_theme.dart';
import '../message_screen.dart';

class ModalComposeMessage extends StatefulWidget {
  // final String contactNumber;
  //final String contactdisplayName;
  final Contact? contact;
  String? message;
  String? phoneNumber;

  //final Contact contact;

  ModalComposeMessage({this.contact,this.message,this.phoneNumber, Key? key})
      : super(key: key);

  @override
  State<ModalComposeMessage> createState() => _ModalComposeMessageState();
}

class _ModalComposeMessageState extends State<ModalComposeMessage> {
  // List<Advertise> yourList = [];
  // final _serverRepository = ServerRepository();

  // TextEditingController _smsController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // کنترلر پیامک نوشته شده توسط کاربر

// کنترلر آگهی تبلیغاتی
  TextEditingController adsTextController = TextEditingController();

//کنترلر آگهی تبلیغاتی اضافه
  TextEditingController adsAdditionalTextController = TextEditingController();

  // غیر فعال کردن دکمه ارسال برای زمانی که اپلیکیشن در حال ارسال پیام است تا از ارسال چندباره جلوگیری شود
  bool _disableSend = false;

  // آی دی آگهی تبلیغاتی
  String _adId = '';

  // آی دی آگهی ارسال شده. نکته: چون به محض ارسال آگهی، آگهی تغییر میکرد و آی دی آگهی جدید به جای آی دی آگهی واقعا ارسال شده قرار می گرفت. آی دی آگهی که در واقعیت ارسال شده را در این متغیر ذخیره کردم
  String _sendAdId = '';

  // آی دی آگهی تبلیغاتی
  int _adFee = 0;

  // قیمت تبلیغ ارسال شده (همان توضیح بالا مدنظر قرار گیرد)
  int _sendAdFee = 0;

  // استرینگ بیس 64 عکس تبلیغ
  String _imageBase64String = Constants.adImage;
  String _status = '';

  // var _netConnectionCheck = new NetConnectionCheck();

  //MediaQueryData? queryData;
  //var apparentSize = 0;

  double screenWidth = 0;
  double screenHeight = 0;
  bool? _withAds = true;
  bool isConnect = true;
  var _connectivityStatus = 'Connected to WiFi';
  final Connectivity _connectivity = Connectivity();

  String _imgString =
      'iVBORw0KGgoAAAANSUhEUgAABAAAAAQACAMAAABIw9uxAAADAFBMVEX///8PDxEHBwkODhAQEBIFBQcTExUGBggRERMSEhQICAoa';

  //Uint8List _bytesImage =Base64Decoder().convert(_imgString);
  //FocusNode? _focusNode;
  // int state=0;

  // شماره تلفن مخاطب (شماره تلفن به صورت آرایه برمیگردد)
  // List<String> phoneList = [];

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);

    // گرفتن تبلیغات به صورت رندم که از این به بعد دیگه نیاز نیست رندم بگیریم و کلا 50 تا تبلیغ رو باید در اسلایدر نشان بدهید
    // Ad? ad = getRandomAd();

    // phoneList = PhoneList.fromJson(json.decode(widget.contact.phones!))
    //     .phoneList
    //     .map((phone) => phone.number)
    //     .toList();
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

  void onFocus() {
    setState(() {
      //Check if the focus node is focused
      //  if(_focusNode!.hasFocus) state=1; //Change the value of the state
    });
  }

  // ImageConvert _imageConvert = ImageConvert();

  Future<bool> _checkInternetMethod() async {
    //  encodeFile = await _imageConvert.encodeImageFileFromAssets('assets/images/Test-Img.jpg');

    //var hasNet = await _netConnectionCheck.CheckHasInternet();
    return true;
  }

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

  /*
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }
  */
  @override
  void dispose() {
    super.dispose();
    // _focusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List _bytes;

    Future<bool> _handleBackButton() {
      Navigator.pop(context);
      return Future.value(true);
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 700,
      child: Center(
        child: WillPopScope(
          onWillPop: _handleBackButton,
          child: Scaffold(
            resizeToAvoidBottomInset: true,

            body: Builder(builder: (context) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      height: MediaQuery.of(context).size.height -
                          97), //MediaQuery.of(context).size.height - 97

                  child: Container(
                    decoration: const BoxDecoration(
                      // color: AppTheme.colorPrimary,
                      image: DecorationImage(
                        image: AssetImage("assets/images/chat_bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: (isConnect &&
                                      _connectivityStatus == 'Connected to WiFi' ||
                                  isConnect &&
                                      _connectivityStatus ==
                                          'Connected to mobile network'),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: this._withAds,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _withAds = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .withAdvertising,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0xFF3f51b5),
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

                            ///////////////////////
                            (isConnect &&
                                        _connectivityStatus ==
                                            'Connected to WiFi' ||
                                    isConnect &&
                                        _connectivityStatus ==
                                            'Connected to mobile network')
                                ? FutureBuilder(
                                    //method to be waiting for in the future
                                    future: getGroupAds(),
                                    // _serverRepository.getAdvertise(phoneNumber: widget.contact),
                                    builder: (_, snapshot) {
                                      //if done show data,
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        // print("bbbbbbbbbbbb 88 - " + snapshot.data.toString());
                                        //  var list = snapshot.data as List;

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

                                        /*if(_checkInternetMethod() == true)
                                    {
                                      // delete data from hive
                                      // add data to hive
                                    }*/

                                        //var list = snapshot.data as List<Advertise>;
                                        var list = snapshot.data as List<Ad>;

                                        //  print("-kkkkkkkkk 88  " + list.length.toString());

                                        //yourList.clear();
                                        //yourList.addAll(list);

                                        _adId = list[0].adId!;

                                        _adFee = Constants.teens.contains(widget.phoneNumber!
                                                .substring(0, 4))
                                            ? 40
                                            : list[0].targetPhoneNumbers.contains(
                                            widget.phoneNumber!)
                                                ? list[0].senderFee
                                                : list[0].fee;

                                        adsTextController.text = list[0].text ?? '';
                                        adsAdditionalTextController.text =
                                            list[0].additionalText ?? '';

                                        // print("-kkkkkkkkkk 0 *** _adId " + _adId);
                                        // print("-kkkkkkkkkk 0 *** _adFee " + _adFee.toString());
                                        // print("-kkkkkkkkkk 0 *** text " +  adsTextController.text.toString());

                                        /* _sendAdId = list[0].text!;
                                  _fee= list[0].fee;

                                  _sendAdId = _adId;
                                  _sendAdFee = _adFee;*/

                                        /*for(var item in list)
                                    {
                                    yourList.add( Costanat.urlSlider + item.file);
                                    }*/
                                        // var resultData = snapshot.data as Advertise;

                                        return Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: CarouselSlider.builder(
                                            itemCount: list.length,
                                            options: CarouselOptions(
                                              enlargeCenterPage: true,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              //queryData.size.height * 0.5,
                                              // viewportFraction: 1,
                                              // initialPage: index,

                                              aspectRatio: 16 / 9,
                                              enlargeFactor: 0.2,

                                              viewportFraction: 0.8,
                                              onPageChanged: (index, reason) {
                                                // print("kkkkkkkkkk1  " + index);
                                                //  print("kkkkkkkkkk1 ***  " + list[index].status);
                                                /* _adId = list[index].adId!;
                                          _sendAdId = list[index].text!;
                                          _fee= list[index].fee;*/

                                                _adId = list[index].adId!;
                                                //  _sendAdId = list[index].adId!;
                                                //  _status = list[index].status!;
                                                // _fee= list[i].fee;
                                                // _sendAdFee = _adFee;

                                                _adFee = Constants.teens.contains(
                                                    widget.phoneNumber!
                                                            .substring(0, 4))
                                                    ? 40
                                                    : list[index]
                                                            .targetPhoneNumbers
                                                            .contains(widget.phoneNumber!)
                                                        ? list[index].senderFee
                                                        : list[index].fee;

                                                adsTextController.text =
                                                    list[index].text!;
                                                adsAdditionalTextController.text =
                                                    list[index].additionalText ??
                                                        '';

                                                //  print("-kkkkkkkkkkkkkkkkkkk **************");
                                                //  print("-kkkkkkkkkk 1 *** _adId " + _adId);
                                                //  print("-kkkkkkkkkk 1 *** _adFee " + _adFee.toString());
                                                // print("-kkkkkkkkkk 1 *** _adFee " + adsTextController.text.toString());
                                              },
                                              // autoPlay: true,
                                              //  autoPlayInterval: Duration(seconds:3),
                                              reverse: true,
                                            ),
                                            itemBuilder: (context, i, id) {
                                              //for onTap to redirect to another screen
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 0),
                                                child: GestureDetector(
                                                  child: Card(
                                                    elevation: 20,
                                                    color: Colors.red,
                                                    // margin: EdgeInsets.only(top: 10),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      //set border radius more than 50% of height and width to make circle
                                                    ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      // height: 200,
                                                      //  margin: const EdgeInsets.only(top: 10,left: 0,right: 0),
                                                      //  margin:  EdgeInsets.only(bottom: 3,top: 10),
                                                      //  padding:  EdgeInsets.only(bottom: 10,top: 10),
                                                      decoration: BoxDecoration(
                                                        //  color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        color:
                                                            const Color(0xFFE5E7EF),

                                                        /*  boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],*/

                                                        /* boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          //blurRadius: 15.0, // soften the shadow
                                          //spreadRadius: 15.0, //extend the shadow
                                          blurRadius: 5.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                           // 5.0, // Move to right 5  horizontally
                                           // 5.0, // Move to bottom 5 Vertically
                                            2.0, // Move to right 5  horizontally
                                            2.0, // Move to bottom 5 Vertically

                                          ),
                                        )
                                      ],*/

                                                        // border: Border.all(color: Colors.white,)
                                                      ),
                                                      //ClipRRect for image border radius
                                                      //   child: ClipRRect(
                                                      // borderRadius: BorderRadius.circular(15),

                                                      //  child: FittedBox(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 130,
                                                            margin: const EdgeInsets
                                                                .all(8.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              //  color: Colors.yellow,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(15),
                                                              //  color: Colors.red,
                                                              //  shape: BoxShape.circle,
                                                              // border: Border.all(color: Colors.white,)
                                                              /* image: DecorationImage(
                                            fit: BoxFit.fill,
                                              image: ,

                                          ),*/
                                                            ),
                                                            width: double.infinity,
                                                            child: Stack(
                                                              children: [
                                                                /*  Visibility(

                                                            child: CachedNetworkImage(
                                                                fit: BoxFit.fill,
                                                                // height: 200,
                                                                // width: 300,
                                                                imageUrl: list[i].image,

                                                                imageBuilder: (context, imageProvider) => Container(
                                                                  //  height: 100,
                                                                  // width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                    image: DecorationImage(
                                                                      image: imageProvider,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),

                                                                placeholder: (context, url) => const CircularProgressIndicator(
                                                                  color: Color(0xFF7986cb) ,
                                                                ),
                                                                errorWidget: (context, url, error) => Container(
                                                                  width: double.infinity,
                                                                  height: double.infinity,
                                                                  color: Colors.blueGrey,
                                                                )    //Icon(Icons.error),
                                                            ),
                                                            visible: false,
                                                          ),*/

                                                                Visibility(
                                                                  visible: true,
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  15.0),
                                                                      //  _imageBase64String = ad.image.isNotEmpty ? ad.image : Constants.adImage;
                                                                      /// child: Image.memory(Base64Decoder().convert(list[i].image),
                                                                      child: (list[i]
                                                                                  .image !=
                                                                              "")
                                                                          ? Image
                                                                              .network(
                                                                              list[i]
                                                                                  .image,
                                                                              fit: BoxFit
                                                                                  .fill,
                                                                              width:
                                                                                  double.infinity,
                                                                            )
                                                                          : Center(
                                                                              child:
                                                                                  Image.network(
                                                                                "https://sms-static.storage.iran.liara.space/ads/6432bd965e377e30d38f293f.jpg",
                                                                                height:
                                                                                    150,
                                                                                width:
                                                                                    250,
                                                                                alignment:
                                                                                    Alignment.center,
                                                                                fit:
                                                                                    BoxFit.cover,
                                                                                gaplessPlayback:
                                                                                    true,
                                                                              ),
                                                                            )),
                                                                ),
                                                                Visibility(
                                                                  visible: true,
                                                                  child: Positioned(
                                                                    bottom:
                                                                        -30, // -30
                                                                    left: 0,
                                                                    right: 0,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          60, //60
                                                                      height:
                                                                          60, // 60
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        //  shape: BoxShape.circle,
                                                                        color: Colors
                                                                            .black87
                                                                            .withOpacity(
                                                                                0.5),
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

                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10,
                                                                            top: 5,
                                                                            bottom:
                                                                                5),
                                                                        child: Text(
                                                                          " قیمت: " +
                                                                              list[i]
                                                                                  .fee
                                                                                  .toString(), //list[i].fee.toString(),
                                                                          textDirection:
                                                                              TextDirection
                                                                                  .rtl,
                                                                          style: const TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              fontSize:
                                                                                  14),
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
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                  list[i].status!,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  style:
                                                                      const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w700,
                                                                          //fontFamily: AppTheme.fontYekanNumRegular,
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black87)),
                                                            ),
                                                            visible: false,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Container(
                                                              //  height: 140,
                                                              //   color: Colors.green,
                                                              child: LinkifyText(
                                                                list[i]
                                                                    .text!
                                                                    .replaceAll(
                                                                        '\\n',
                                                                        '\n'),
                                                                textAlign:
                                                                    TextAlign.end,
                                                                textStyle:
                                                                    const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            14),
                                                                linkStyle: const TextStyle(
                                                                    color:
                                                                        Colors.blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: 15),
                                                                onTap: (link) {
                                                                  if (link.type ==
                                                                      LinkType
                                                                          .url) {
                                                                    _launchURL(
                                                                        link.value);
                                                                  }
                                                                },
                                                              ),

                                                              /*Text(list[i].text!,
                                                            //  overflow: TextOverflow.ellipsis,
                                                            textDirection: TextDirection.rtl,
                                                            style:
                                                            TextStyle(fontWeight: FontWeight.w400,
                                                                //fontFamily: AppTheme.fontYekanNumRegular,
                                                                fontSize: 13,
                                                                height: 1,
                                                                color:Colors.black87)),*/
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //  ),

                                                      /*CachedNetworkImage(
                                            ,
                                            width: 500,
                                            fit: BoxFit.cover,
                                          ),*/
                                                      //  ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _adId = list[i].adId!;
                                                    //  _sendAdId = list[index].adId!;
                                                    //  _status = list[index].status!;
                                                    // _fee= list[i].fee;
                                                    // _sendAdFee = _adFee;

                                                    _adFee = Constants.teens
                                                            .contains(widget.phoneNumber!
                                                                .substring(0, 4))
                                                        ? 40
                                                        : list[i]
                                                                .targetPhoneNumbers
                                                                .contains(widget.phoneNumber!)
                                                            ? list[i].senderFee
                                                            : list[i].fee;

                                                    adsTextController.text =
                                                        list[i].text!;
                                                    adsAdditionalTextController
                                                            .text =
                                                        list[i].additionalText ??
                                                            '';

                                                    print("_adId  " + _adId);
                                                    print(
                                                        "_sendAdId  " + _sendAdId);
                                                    //  var url = imageList[i];
                                                    // print(url.toString());
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
                                        return Center(
                                            child: Container(
                                          height: 80,
                                          width: 80,
                                          child: const SizedBox(
                                            height: 80.0,
                                            width: 80.0,
                                            child: CircularProgressIndicator(
                                              color: Color(0xFF3f51b5),
                                              // backgroundColor: Color(0xFF3f51b5),
                                            ),
                                          ),
                                        ));
                                      }
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            "اینترنت شما قطع می باشد \nاما به راحتی میتوانید پیامک های خودتان را ارسال کنید",
                                            textAlign: TextAlign.center),
                                        const SizedBox(height: 10),
                                        MaterialButton(
                                          onPressed: () {
                                            _recheckInternetConnectivity();
                                          },
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            "دوباره سعی کنید",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                            ///////////////////
                            // Visibility(
                            //   visible: true,
                            //   // (isConnect &&
                            //   //         _connectivityStatus == 'Connected to WiFi' ||
                            //   //     isConnect &&
                            //   //         _connectivityStatus ==
                            //   //             'Connected to mobile network'),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 10),
                            //     child: OutlinedButton(
                            //       onPressed: () {
                            //         Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => AdsTheme(
                            //                     phoneNumber: widget.phoneNumber,
                            //                   )),
                            //         );
                            //       },
                            //       child: Text(
                            //         AppLocalizations.of(context).changeCategory,
                            //         style: const TextStyle(
                            //             fontSize: 16,
                            //             fontStyle: FontStyle.italic,
                            //             color: Color(0xFF2C66FF),
                            //             fontWeight: FontWeight.w700),
                            //       ),
                            //       style: OutlinedButton.styleFrom(
                            //         side: const BorderSide(
                            //             width: 1.0, color: Color(0xFF2C66FF)),
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 16, horizontal: 13),
                            //         shape: const RoundedRectangleBorder(
                            //           borderRadius:
                            //               BorderRadius.all(Radius.circular(10)),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            /*  ListTile(
                            leading: new Image.memory(_bytes),
                            title: new Text(encodeFile),
                          ),*/

                            Visibility(
                                visible: true, child: Expanded(child: Container())),

                            Visibility(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 0, top: 0),
                                child: Form(
                                  key: _formKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 1),
                                        child: SizedBox(
                                            width: 250,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: TextButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color(0xFF2C66FF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // <-- Radius
                                                ), // HexColor("#F46D9D")
                                              ),
                                              onPressed: _disableSend
                                                  ? null
                                                  : () async {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                        'Please wait, message is sending',
                                                        textAlign: TextAlign.center,
                                                      )));
                                                      /* setState(() {
                                                _disableSend = true;
                                              });*/

                                                      // sending message
                                                      // var phoneList = PhoneList.fromJson(json
                                                      //     .decode(widget.contact.phones!))
                                                      //     .phoneList
                                                      //     .map((phone) => phone.number)
                                                      //     .toList();
                                                      // phoneList =
                                                      //     phoneList.getRange(0, 1).toList();

                                                      //var phoneList = [widget.contactNumber];

                                                      if (_withAds == false) {
                                                        var sendResult =
                                                            await _sendSMS(
                                                                widget.message!,
                                                                [
                                                                  widget.phoneNumber!
                                                            ]);

                                                        if (sendResult) {
                                                          widget.message =
                                                              "";

                                                          WidgetsBinding.instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            showDialog(
                                                                context: context,
                                                                builder:
                                                                    (ctx) =>
                                                                        AlertDialog(
                                                                          title: Text(
                                                                              AppLocalizations.of(context)
                                                                                  .congratulations,
                                                                              textAlign:
                                                                                  TextAlign.center),
                                                                          content: Text(
                                                                              '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
                                                                              textAlign:
                                                                                  TextAlign.center),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () {
                                                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                                                    MessagesScreen(phoneNumber: widget.phoneNumber!)), (Route<dynamic> route) => false);
                                                                              },
                                                                              child:
                                                                                  Container(
                                                                                width:
                                                                                    double.infinity,
                                                                                decoration:
                                                                                    const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(4))),
                                                                                padding:
                                                                                    const EdgeInsets.all(14),
                                                                                child:
                                                                                    Text(
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
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                              'Failed',
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                          ));
                                                          setState(() {
                                                            _disableSend = false;
                                                          });
                                                        }
                                                      } else {
                                                        if (isConnect &&
                                                                _connectivityStatus ==
                                                                    'Connected to WiFi' ||
                                                            isConnect &&
                                                                _connectivityStatus ==
                                                                    'Connected to mobile network') {
                                                          var message = widget.message!
                                                                      .length <
                                                                  70
                                                              ? '${widget.message} \n \n \n . \n ⬇️ تبلیغ از http://smsonlines.ir⬇️ \n \n . \n ${adsTextController.text} \n ${adsAdditionalTextController.text}'
                                                              : '${widget.message} \n \n \n . \n ⬇️ تبلیغ از http://smsonlines.ir⬇️ \n \n . \n ${adsTextController.text}';
                                                          _sendAdId = _adId;
                                                          _sendAdFee = _adFee;

                                                          var sendResult =
                                                              await _sendSMS(
                                                                  message, [
                                                                widget.phoneNumber!
                                                          ]);

                                                          if (sendResult) {
                                                            widget.message = "";
                                                            String? res =
                                                                await updateWallet(
                                                                    SharedPrefs
                                                                        .getPhoneNumber(),
                                                                    widget.phoneNumber!,
                                                                    Constants
                                                                        .SEND_MESSAGE,
                                                                    _sendAdId);

                                                            WidgetsBinding.instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                        title: Text(
                                                                            AppLocalizations.of(context)
                                                                                .congratulations,
                                                                            textAlign:
                                                                                TextAlign.center),
                                                                        content: Text(
                                                                            '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
                                                                            textAlign:
                                                                                TextAlign.center),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                                                      MessagesScreen(phoneNumber: widget.phoneNumber!)), (Route<dynamic> route) => false);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width:
                                                                                  double.infinity,
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(4))),
                                                                              padding:
                                                                                  const EdgeInsets.all(14),
                                                                              child:
                                                                                  Text(
                                                                                AppLocalizations.of(context).ok,
                                                                                style:
                                                                                    const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 18,
                                                                                ),
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                            });

                                                            //  Constants.adGroup!.adsList.removeWhere(
                                                            //   (item) => item.adId == _adId);
                                                            // Ad? ad = getRandomAd();
                                                            /* if (ad != null) {
                                                  setState(() {
                                                    _isLoading = false;
                                                    _disableSend = false;
                                                    _adId = ad.adId!;
                                                    _adFee = Constants.teens.contains(
                                                        phoneList.first
                                                            .substring(0, 4))
                                                        ? 40
                                                        : ad.targetPhoneNumbers
                                                        .contains(
                                                        phoneList.first)
                                                        ? ad.senderFee
                                                        : ad.fee;
                                                    userTextController.text = '';
                                                    adsTextController.text = ad.text!;
                                                    adsAdditionalTextController.text =
                                                        ad.additionalText ?? '';
                                                  });
                                                } else {
                                                  setState(() {
                                                    _isLoading = true;
                                                    _disableSend = true;
                                                  });

                                                  /*
                                                  if (await getGroupAds()) {
                                                    Ad? ad = getRandomAd();
                                                    if (ad != null) {
                                                      setState(() {
                                                        _isLoading = false;
                                                        _disableSend = false;
                                                        _adId = ad.adId!;
                                                        _adFee = Constants.teens
                                                            .contains(phoneList
                                                            .first
                                                            .substring(0, 4))
                                                            ? 40
                                                            : ad.targetPhoneNumbers
                                                            .contains(
                                                            phoneList.first)
                                                            ? ad.senderFee
                                                            : ad.fee;
                                                        userTextController.text = '';
                                                        adsTextController.text =
                                                        ad.text!;
                                                        adsAdditionalTextController
                                                            .text =
                                                            ad.additionalText ?? '';
                                                      });
                                                    }
                                                  }
                                                  */

                                                }*/
                                                          } else {
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                'Failed',
                                                                textAlign: TextAlign
                                                                    .center,
                                                              ),
                                                            ));
                                                            setState(() {
                                                              _disableSend = false;
                                                            });
                                                          }
                                                        } else {
                                                          var sendResult =
                                                              await _sendSMS(
                                                                  widget.message!,
                                                                  [
                                                                    widget.phoneNumber!
                                                              ]);

                                                          if (sendResult) {
                                                            widget.message = "";

                                                            WidgetsBinding.instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                        title: Text(
                                                                            AppLocalizations.of(context)
                                                                                .congratulations,
                                                                            textAlign:
                                                                                TextAlign.center),
                                                                        content: Text(
                                                                            '$_sendAdFee ${AppLocalizations.of(context).tomanAddToWallet}',
                                                                            textAlign:
                                                                                TextAlign.center),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                                                      MessagesScreen(phoneNumber: widget.phoneNumber!)), (Route<dynamic> route) => false);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width:
                                                                                  double.infinity,
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(4))),
                                                                              padding:
                                                                                  const EdgeInsets.all(14),
                                                                              child:
                                                                                  Text(
                                                                                AppLocalizations.of(context).ok,
                                                                                style:
                                                                                    const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 18,
                                                                                ),
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                            });
                                                          } else {
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                'Failed',
                                                                textAlign: TextAlign
                                                                    .center,
                                                              ),
                                                            ));
                                                            setState(() {
                                                              _disableSend = false;
                                                            });
                                                          }
                                                        }
                                                      }
                                                    },
                                              child: const Text(
                                                "Send",style: TextStyle(color: Colors.white,fontSize: 18),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              visible: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Uint8List convertBase64Image(String base64String) {
    return const Base64Decoder().convert(base64String);
  }

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
