import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import '../../apis/apis.dart';
import '../../models/wallet.dart';
import '../home_screen.dart';
import 'payment_view/payment_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isConnect = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
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

  Future<void> _recheckInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnect = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isConnect)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0039C8),
              title: Text(
                AppLocalizations.of(context).wallet,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            body: FutureBuilder<List<dynamic>>(
              future: getWalletData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ),
                    widthFactor: 15,
                    heightFactor: 15,
                  );
                } else {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("دستگاه به اینترنت متصل نیست"));
                  } else {
                    Wallet wallet = snapshot.data![0];
                    SharedPrefs.setWallet(wallet.wallet);
                    SharedPrefs.setTotalMessage(wallet.totalMessages);
                    return ClipPath(
                      // clipper :ArcClipper(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: double.maxFinite,
                        height: double.maxFinite,
                        // height: 300,
                        // color:  const Color(0xFF3f51b5),
                        // alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF0039C8),
                                Color(0xFF002861),
                              ],
                              //  begin: const FractionalOffset(-1.0, 0.0),
                              // end: const FractionalOffset(1.0, 0.0),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),

                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: double.maxFinite,
                                height: 173,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.expand,
                                    clipBehavior:
                                    Clip.antiAliasWithSaveLayer,
                                    //overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.only(
                                            right: 16, left: 16),
                                        //height: 158,
                                        //    color: Colors.red,
                                      ), //Container
                                      Positioned(
                                        top: 5,
                                        left: 16,
                                        right: 16,
                                        bottom: 12,
                                        child: Container(
                                          width: double.maxFinite,
                                          // height: 140,

                                          decoration: BoxDecoration(
                                              color:
                                              const Color(0xFF0B44D1),
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              border: Border.all(
                                                width: 0,
                                                // color: Color(0xFF25CEA0)
                                              )),

                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    16.0),
                                                child: Text(
                                                  AppLocalizations.of(
                                                      context)
                                                      .walletBalance,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 2),
                                                child: Text(
                                                  wallet.wallet.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ), //Container
                                      Positioned(
                                        bottom: 3,
                                        left: 26,
                                        right: 26,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 20.0,
                                              bottom: 0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                                style: TextButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                  Colors.white,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12), // <-- Radius
                                                  ), // HexColor("#F46D9D")
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentScreen(
                                                                  wallet
                                                                      .wallet)));
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                        context)
                                                        .cashOut,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 16,
                                                      color:
                                                      Color(0xFF2C66FF),
                                                    ))),
                                          ),
                                        ),
                                      ), //Container
                                    ], //<Widget>[]
                                  ), //Stack
                                ), //Center
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF083AAD),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 0,
                                    // color: Color(0xFF25CEA0)
                                  )),
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, top: 32),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 16),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .sentMessages,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 16),
                                    child: Text(
                                      wallet.totalMessages.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }
              },
            ))
        :(SharedPrefs.getWallet() !=-1 && SharedPrefs.getTotalMessage() != -1)? //Not Connected to Internet bot have data
    Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0039C8),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
            },
          ),
          title: Text(
            AppLocalizations.of(context).wallet,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: ClipPath(
          // clipper :ArcClipper(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: double.maxFinite,
            // height: 300,
            // color:  const Color(0xFF3f51b5),
            // alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF0039C8),
                    Color(0xFF002861),
                  ],
                  //  begin: const FractionalOffset(-1.0, 0.0),
                  // end: const FractionalOffset(1.0, 0.0),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),

            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 173,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        //overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(right: 16, left: 16),
                            //height: 158,
                            //    color: Colors.red,
                          ), //Container
                          Positioned(
                            top: 5,
                            left: 16,
                            right: 16,
                            bottom: 12,
                            child: Container(
                              width: double.maxFinite,
                              // height: 140,

                              decoration: BoxDecoration(
                                  color: const Color(0xFF0B44D1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 0,
                                    // color: Color(0xFF25CEA0)
                                  )),

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .walletBalance,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 2),
                                    child: Text(
                                      SharedPrefs.getWallet().toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ), //Container //Container
                        ], //<Widget>[]
                      ), //Stack
                    ), //Center
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color(0xFF083AAD),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0,
                        // color: Color(0xFF25CEA0)
                      )),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: Text(
                          AppLocalizations.of(context).sentMessages,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: Text(
                          SharedPrefs.getTotalMessage().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("هشدار:دستگاه به اینترنت متصل نیست",style: TextStyle(color: Colors.white,fontSize: 16)),
                    Icon(Icons.dangerous_outlined,color: Colors.white,),
                  ],
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: (){
                    _recheckInternetConnectivity();
                  },
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.blue.shade100,
                  child: const Text("دوباره سعی کنید",style: TextStyle(color: Colors.black),),
                )
              ],
            ),
          ),
        )
    )://Not Connected to Internet
    Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("دستگاه به اینترنت متصل نیست"),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: (){
              _recheckInternetConnectivity();
            },
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            color: Colors.blue.shade900,
            child: const Text("دوباره سعی کنید",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }

  Future<List<dynamic>> getWalletData() async {
    Apis api = Apis();
    List<dynamic> response = await api.getWalletData();
    if (response[0] != null) {
      /* for(var item in [response[0]])
      {
        var tt = item as Wallet;
        print("ttttttttttttt111 == " + tt.phoneNumber.toString());
        print("ttttttttttttt222 == " + tt.userId);
        print("ttttttttttttt333 == " + tt.wallet.toString());

      }*/

      return [response[0]];
    } else {
      throw response[1];
      // return [null, response[1]];
    }
  }
}
