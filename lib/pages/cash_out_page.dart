// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import '../apis/apis.dart';
// import 'wallet_page.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// bool _loading = false;
//
// class CashOutPage extends StatefulWidget {
//   final int wallet;
//   const CashOutPage(this.wallet, {Key? key}) : super(key: key);
//
//   @override
//   State<CashOutPage> createState() => _CashOutPageState();
// }
//
// class _CashOutPageState extends State<CashOutPage> {
//
//   final TextEditingController _firstInputBoxController = TextEditingController();
//   final TextEditingController _secondInputBoxController = TextEditingController();
//   final TextEditingController _thirdInputBoxController = TextEditingController();
//   final TextEditingController _fourthInputBoxController = TextEditingController();
//   final TextEditingController _cashOutController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//         appBar: NeumorphicAppBar(
//           title: Text(
//             AppLocalizations.of(context).cashOut,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           buttonStyle: const NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//           ),
//         ),
//         body: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height - 144,
//           child: SingleChildScrollView(
//             child: Column(children: [
//               const SizedBox(height: 15,),
//               Text(AppLocalizations.of(context).registerBankCard, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//               const SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: Neumorphic(
//                       style: NeumorphicStyle(
//                           depth: -5,
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(4)))),
//                       child: TextField(
//                         onChanged: (v) {},
//                         controller: _firstInputBoxController,
//                         maxLength: 4,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.only(left: 4.0, right: 4.0),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: Neumorphic(
//                       style: NeumorphicStyle(
//                           depth: -5,
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(4)))),
//                       child: TextField(
//                         onChanged: (v) {},
//                         controller: _secondInputBoxController,
//                         maxLength: 4,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 4.0, right: 4.0),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: Neumorphic(
//                       style: NeumorphicStyle(
//                           depth: -5,
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(4)))),
//                       child: TextField(
//                         onChanged: (v) {},
//                         controller: _thirdInputBoxController,
//                         maxLength: 4,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 4.0, right: 4.0),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: Neumorphic(
//                       style: NeumorphicStyle(
//                           depth: -5,
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(4)))),
//                       child: TextField(
//                         onChanged: (v) {},
//                         controller: _fourthInputBoxController,
//                         maxLength: 4,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 4.0, right: 4.0),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                   )
//                 ],),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               NeumorphicButton(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   onPressed: () {
//                   },
//                   style: NeumorphicStyle(
//                       color: Colors.blueAccent,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           const BorderRadius.all(Radius.circular(20)))),
//                   child: SizedBox(
//                     width: 150,
//                     child: Text(
//                       AppLocalizations.of(context).register,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   )),
//               const SizedBox(
//                 height: 15,
//               ),
//               Neumorphic(
//                   style: const NeumorphicStyle(
//                     shape: NeumorphicShape.concave,
//                     boxShape: NeumorphicBoxShape.rect(),
//                     lightSource: LightSource.topLeft,
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(AppLocalizations.of(context).walletBalance, style: const TextStyle(fontWeight: FontWeight.bold),),
//                             Text('${widget.wallet} ${AppLocalizations.of(context).toman}',
//                                 style:const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueAccent),),
//                           ]),
//                     ),
//                   )),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 child: Neumorphic(
//                   style: NeumorphicStyle(
//                       depth: -5,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           const BorderRadius.all(Radius.circular(4)))),
//                   child: TextField(
//                     onChanged: (v) {},
//                     controller: _cashOutController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: false),
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                     decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 4.0, right: 4.0),
//                         border: InputBorder.none),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               NeumorphicButton(
//                   padding: const EdgeInsets.only(top: 8, bottom: 8),
//                   onPressed: () {
//                     setState(() {
//                       _loading = true;
//                     });
//                     withdraw();
//                   },
//                   style: NeumorphicStyle(
//                       color: Colors.blueAccent,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           const BorderRadius.all(Radius.circular(20)))),
//                   child: SizedBox(
//                     width: 120,
//                     child: _loading
//                         ? const Center(
//                         child: SizedBox(
//                             height: 22,
//                             width: 22,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                             )))
//                         : Text(
//                       AppLocalizations.of(context).cashOut,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   )),
//             ]),
//           ),
//         ));
//   }
//
//   Future<void> withdraw() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.withdraw(
//         '${_firstInputBoxController.text}${_secondInputBoxController.text}${_thirdInputBoxController.text}${_fourthInputBoxController.text}'
//         , int.parse(_cashOutController.text));
//
//     if (response[0] != null) {
//       setState(() {
//         _loading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(response[0], textAlign: TextAlign.center),
//       ));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                const WalletPage()),
//       );
//     } else {
//       setState(() {
//         _loading = false;
//       });
//       if(response[1] is List) {
//         for(String message in response[1]) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(message, textAlign: TextAlign.center),
//           ));
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(response[1], textAlign: TextAlign.center),
//         ));
//       }
//     }
//   }
// }
