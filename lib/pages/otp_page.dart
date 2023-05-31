// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import '../apis/apis.dart';
// import '../helpers/sharedprefs.dart';
// import '../models/tokens.dart';
// import '../models/user.dart';
// import 'splash_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class OtpPage extends StatefulWidget {
//   final phoneNumber;
//
//   const OtpPage({required this.phoneNumber, Key? key}) : super(key: key);
//
//   @override
//   State<OtpPage> createState() => _OtpPageState();
// }
//
// class _OtpPageState extends State<OtpPage> {
//   bool _loading = false;
//   var _code = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: NeumorphicAppBar(
//           title: Text(
//             AppLocalizations.of(context).verifyingMobile,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           buttonStyle: const NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//           ),
//         ),
//         body: SizedBox(
//           height: MediaQuery.of(context).size.height - 144,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: _loading
//                   ? const CircularProgressIndicator(color: Colors.blueAccent)
//                   : Column(
//                       children: [
//                         Text(AppLocalizations.of(context).waitSecond),
//                         const SizedBox(
//                           height: 6,
//                         ),
//                         PinFieldAutoFill(
//                             decoration: BoxLooseDecoration(
//                                 strokeColorBuilder:
//                                     FixedColorBuilder(Colors.grey)),
//                             // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
//                             currentCode: _code,
//                             onCodeSubmitted: (code) {
//                               FocusScope.of(this.context)
//                                   .requestFocus(FocusNode());
//                               WidgetsBinding.instance
//                                   .addPostFrameCallback((timeStamp) {
//                                 setState(() {
//                                   _code = code;
//                                   // if (code.length == 6) {
//                                   //   _verifyOtpCode(int.parse(code));
//                                   // }
//                                 });
//                                 if (code.length == 6) {
//                                   _verifyOtpCode(int.parse(code));
//                                 }
//                               });
//                               //
//                               // if (code.length == 6) {
//                               //   // FocusScope.of(this.context).requestFocus(FocusNode());
//                               //   // WidgetsBinding.instance
//                               //   //     .addPostFrameCallback((timeStamp) {
//                               //   //   setState(() {
//                               //   //     _loading = true;
//                               //   //     _code = code;
//                               //   //   });
//                               //   // });
//                               //   _verifyOtpCode(code);
//                               // }
//                             },
//                             onCodeChanged: (code) {
//                               if (code!.length == 6) {
//                                 FocusScope.of(this.context)
//                                     .requestFocus(FocusNode());
//                                 WidgetsBinding.instance
//                                     .addPostFrameCallback((timeStamp) {
//                                   setState(() {
//                                     _loading = true;
//                                     _code = code;
//                                   });
//                                 });
//                                 _verifyOtpCode(int.parse(code));
//                               }
//                             },
//                             //code changed callback
//                             codeLength: 6 //code length, default 6
//                             ),
//                       ],
//                     ),
//             ),
//           ),
//         ));
//   }
//
//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//   }
//
//   void _verifyOtpCode(int code) async {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         _loading = true;
//       });
//     });
//     User user = User(phoneNumber: widget.phoneNumber, otpCode: code);
//     print(user.phoneNumber);
//     Apis api = Apis();
//     // List<dynamic> response = await api.verifyOtp(user);
//
//     List<dynamic> response = [];
//
//     if (response[0] != null) {
//       Tokens? tokens = response[0];
//       SharedPrefs.setAccessToken(tokens!.accessToken);
//       SharedPrefs.setRefreshToken(tokens.refreshToken);
//       SharedPrefs.setPhoneNumber(widget.phoneNumber);
//       SharedPrefs.setLoginDone(true);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SplashScreen()),
//       );
//     } else {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         setState(() {
//           _loading = false;
//           _code = '';
//         });
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//             response[1].contains('SocketException')
//                 ? 'Network error, please check your network connection'
//                 : response[1],
//             textAlign: TextAlign.center),
//       ));
//     }
//   }
// }
