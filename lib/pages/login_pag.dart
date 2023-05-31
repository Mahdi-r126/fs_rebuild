// import 'dart:ui';
// import 'package:country_calling_code_picker/country.dart';
// import 'package:country_calling_code_picker/country_code_picker.dart';
// import 'package:country_calling_code_picker/functions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import '../apis/apis.dart';
// import '../models/user.dart';
// import 'otp_page.dart';
//
// //TODO delete this screen if unused
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   bool _submitted = false;
//   bool _loading = false;
//   late Country _selectedCountry;
//   final TextEditingController _phoneNumberTextController =
//       TextEditingController();
//
//   String? get _phoneNumberErrorText {
//     final text = _phoneNumberTextController.value.text;
//     if (text.isEmpty) {
//       return 'Can\'t be empty';
//     }
//     if (text.length < 10) {
//       return 'Must be at least 10 letters, or 11 if starts with 0';
//     }
//     return null;
//   }
//
//   @override
//   void initState() {
//     initCountry();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 80),
//                 child: NeumorphicText(
//                   'SIGN IN',
//                   textStyle: NeumorphicTextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'serif'),
//                   textAlign: TextAlign.center,
//                   style: const NeumorphicStyle(
//                       shape: NeumorphicShape.convex,
//                       depth: 5,
//                       color: Colors.black87),
//                 ),
//               ),
//               const SizedBox(
//                 height: 120,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 6.0, left: 1.0),
//                           child: NeumorphicButton(
//                             onPressed: () {
//                               _showCountryPicker();
//                             },
//                             style: NeumorphicStyle(
//                                 boxShape: NeumorphicBoxShape.roundRect(
//                                     const BorderRadius.all(Radius.circular(20)))),
//                             child: SizedBox(
//                               width: double.infinity,
//                               child: Image.asset(_selectedCountry.flag,package: countryCodePackageName, width: 32,),
//
//                               // Text('${_selectedCountry.name}',
//                               //         textAlign: TextAlign.center,
//                               //         style: const TextStyle(
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.white),
//                               //       ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         child: Neumorphic(
//                           style: NeumorphicStyle(
//                               depth: -5,
//                               boxShape: NeumorphicBoxShape.roundRect(
//                                   const BorderRadius.all(Radius.circular(20)))),
//                           child: TextField(
//                             onChanged: (phoneNumber) => setState(() {}),
//                             controller: _phoneNumberTextController,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: const EdgeInsets.only(
//                                     right: 4.0,
//                                     top: 20.0,
//                                     bottom: 20.0,
//                                     left: 15),
//                                 alignLabelWithHint: true,
//                                 hintText: 'phoneNumber',
//                                 errorText:
//                                     _submitted ? _phoneNumberErrorText : null,
//                                 errorStyle: const TextStyle(
//                                     fontWeight: FontWeight.w500),
//                                 prefixIcon:
//                                     const Icon(Icons.account_box_outlined)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // const SizedBox(
//               //   height: 4,
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.only(
//               //       right: 40.0, left: 40, bottom: 16, top: 16),
//               //   child: Neumorphic(
//               //     style: NeumorphicStyle(
//               //         depth: -5,
//               //         boxShape: NeumorphicBoxShape.roundRect(
//               //             const BorderRadius.all(Radius.circular(20)))),
//               //     child: TextField(
//               //       onChanged: (password) => setState(() {}),
//               //       obscureText: true,
//               //       controller: _passwordTextController,
//               //       decoration: InputDecoration(
//               //           border: InputBorder.none,
//               //           contentPadding: const EdgeInsets.only(
//               //               right: 4.0, top: 20.0, bottom: 20.0, left: 15),
//               //           hintText: 'password',
//               //           errorText: _submitted ? _passwordErrorText : null,
//               //           errorStyle:
//               //               const TextStyle(fontWeight: FontWeight.w500),
//               //           alignLabelWithHint: true,
//               //           prefixIcon: const Icon(Icons.password)),
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 40.0, left: 40),
//                 child: NeumorphicButton(
//                     padding: const EdgeInsets.only(top: 16, bottom: 16),
//                     onPressed: (_phoneNumberTextController.text.isNotEmpty)
//                         ? _submit
//                         : null,
//                     style: NeumorphicStyle(
//                         color: Colors.blueAccent,
//                         boxShape: NeumorphicBoxShape.roundRect(
//                             const BorderRadius.all(Radius.circular(20)))),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: _loading
//                           ? const Center(
//                               child: SizedBox(
//                                   height: 22,
//                                   width: 22,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )))
//                           : const Text(
//                               'SIGN IN',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                     )),
//               ),
//               // const Spacer(),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     const Text(
//               //       'Don\'t have an account yet? ',
//               //       textAlign: TextAlign.center,
//               //       style: TextStyle(fontSize: 15, color: Colors.black),
//               //     ),
//               //     GestureDetector(
//               //       onTap: () {
//               //         Navigator.push(
//               //           context,
//               //           MaterialPageRoute(
//               //               builder: (context) => const SignupPage()),
//               //         );
//               //       },
//               //       child: const Text(
//               //         'Sign up',
//               //         textAlign: TextAlign.center,
//               //         style: TextStyle(fontSize: 15, color: Colors.blueAccent),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // const SizedBox(
//               //   height: 30,
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _submit() async {
//     setState(() {
//       _submitted = true;
//       _loading = true;
//     });
//     // if there is no error text
//     if (_phoneNumberErrorText == null) {
//       User user = User(phoneNumber: _phoneNumberTextController.text.startsWith('0') ? _phoneNumberTextController.text : _phoneNumberTextController.text.startsWith('+98') ? '0${_phoneNumberTextController.text.substring(3)}' : '0${_phoneNumberTextController.text}');
//       Apis api = Apis();
//       // List<dynamic> response = await api.requestOtpCode(user);
//       List<dynamic> response = [];
//
//       if (response[0] != null) {
//         String otpCode = response[0];
//         String appSignature = await SmsAutoFill().getAppSignature;
//
//         bool res = await _sendSMS(
//             'Welcome to SMS, Checking mobile number: $otpCode \n$appSignature', [_phoneNumberTextController.text]);
//         // bool res = true;
//         if (res) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     OtpPage(phoneNumber: user.phoneNumber)),
//           );
//         }
//         setState(() {
//           _loading = false;
//         });
//       } else {
//         setState(() {
//           _loading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(response[1].contains('SocketException') ? 'Network error, please check your network connection' : response[1], textAlign: TextAlign.center),
//         ));
//       }
//     } else {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }
//
//   Future<bool> _sendSMS(String message, List<String> recipients) async {
//     if (await permissionCheckAndRequest()) {
//       await sendSMS(message: message, recipients: recipients, sendDirect: true)
//           .catchError((onError) {
//         return Future.value(onError.toString());
//       });
//       return Future.value(true);
//     } else {
//       return Future.value(false);
//     }
//   }
//
//   Future<bool> permissionCheckAndRequest() async {
//     if (await Permission.sms.status.isDenied) {
//       Map<Permission, PermissionStatus> statuses =
//           await [Permission.sms].request();
//       return Future.value(statuses[Permission.sms] == PermissionStatus.granted);
//     } else {
//       return Future.value(true);
//     }
//   }
//
//   @override
//   void dispose() {
//     _phoneNumberTextController.dispose();
//     super.dispose();
//   }
//
//   void initCountry() async {
//     final country = await getDefaultCountry(context);
//     setState(() {
//       _selectedCountry = country;
//     });
//   }
//
//   void _showCountryPicker() async {
//     final country = await showCountryPickerSheet(context,);
//     if (country != null) {
//       setState(() {
//         _selectedCountry = country;
//       });
//     }
//   }
// }
