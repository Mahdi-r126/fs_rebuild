// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:freesms/helpers/constants.dart';
// import 'package:freesms/models/sponsor_ad.dart';
// import 'package:freesms/pages/sponsor_setting.dart';
// import '../apis/apis.dart';
// import '../models/categories.dart';
// import '../models/themes.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../presentation/pages/sponsor_ads/sponsors_ads_page.dart';
//
// class AddAds extends StatefulWidget {
//   const AddAds({Key? key}) : super(key: key);
//
//   @override
//   State<AddAds> createState() => _AddAdsState();
// }
//
// class _AddAdsState extends State<AddAds> with SingleTickerProviderStateMixin {
//   var _selectedIndex = 0;
//   var _payForAdSlider = 0.0;
//   var _publishCount = 0.0;
//   var _loading = false;
//   var _groupValue = Object();
//   File? adsPick;
//   var _selectedCategoryId = '';
//   var _selectedThemeId = '';
//   var _adMainText = '';
//   var _adAdditionalText = '';
//   var _image = '';
//   var _payForAd = 0;
//   var _orderCount = 0;
//   int _stepIndex = 0;
//   final _mainTextAdTypeTextController = TextEditingController();
//   final _additionalTextAdTypeTextController = TextEditingController();
//   Categories? _categories = Categories(categoryList: []);
//   Themes? _themes = Themes(themeList: []);
//
//   List<Step> stepList() => [
//         Step(
//           state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
//           isActive: _stepIndex >= 0,
//           title: const Text('Step 1'),
//           content: firstStep(),
//         ),
//         Step(
//             state: _stepIndex <= 1 ? StepState.editing : StepState.complete,
//             isActive: _stepIndex >= 1,
//             title: const Text('Step 2'),
//             content: Center(
//               child: secondStep(),
//             )),
//         Step(
//             state: _stepIndex <= 2 ? StepState.editing : StepState.complete,
//             isActive: _stepIndex >= 2,
//             title: const Text('Step 3'),
//             content: Center(
//               child: thirdStep(),
//             )),
//         Step(
//             state: StepState.complete,
//             isActive: _stepIndex >= 3,
//             title: const Text('Step 4'),
//             content: Center(
//               child: fourthStep(),
//             )),
//       ];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context).sponsors,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const SponsorSetting()),
//               );
//             },
//             icon: const Icon(Icons.settings),
//             disabledColor: Colors.grey,
//           )
//         ],
//         // buttonStyle: const NeumorphicStyle(
//         //   shape: NeumorphicShape.convex,
//         // ),
//       ),
//       body: Stepper(
//         type: StepperType.horizontal,
//         steps: stepList(),
//         currentStep: _stepIndex,
//         onStepContinue: null,
//         onStepCancel: null,
//         controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
//           return const Text('');
//         },
//         onStepTapped: (value) {
//           setState(() {
//             _stepIndex = value;
//           });
//         },
//       ),
//     );
//   }
//
//   // set category id
//   Widget firstStep() {
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: FutureBuilder<Categories?>(
//             future: getCategories(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.indigo,
//                   ),
//                   widthFactor: 15,
//                   heightFactor: 15,
//                 );
//               } else {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   _categories = snapshot.data;
//                   return Center(
//                       child: Column(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         child: NeumorphicText(
//                           'Step 1 \n Please select the section you want',
//                           textStyle: NeumorphicTextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                           style: const NeumorphicStyle(
//                               shape: NeumorphicShape.concave,
//                               color: Colors.blueGrey),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Expanded(
//                           child: Column(
//                               children:
//                                   _categories!.categoryList.map((category) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 120,
//                             width: 150,
//                             child: NeumorphicButton(
//                               onPressed: () {
//                                 if (_stepIndex < (stepList().length - 1)) {
//                                   setState(() {
//                                     _selectedCategoryId = category.categoryId;
//                                     _stepIndex += 1;
//                                   });
//                                 }
//                               },
//                               child: Center(
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Image.network(
//                                           category.icon,
//                                           height: 30,
//                                           width: 30,
//                                           alignment: Alignment.center,
//                                         ),
//                                       ),
//                                       Text(category.name,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15)),
//                                     ]),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList()))
//                     ],
//                   ));
//                 }
//               }
//             }),
//       ),
//     );
//   }
//
//   // set theme id
//   Widget secondStep() {
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: NeumorphicText(
//                 'Step 2 \n OK, now select ads theme',
//                 textStyle: NeumorphicTextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//                 style: const NeumorphicStyle(
//                     shape: NeumorphicShape.concave, color: Colors.blueGrey),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(child: createThemesRow())
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget createThemesRow() {
//     return FutureBuilder<Themes?>(
//         future: getThemes(_selectedCategoryId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.indigo,
//               ),
//               widthFactor: 15,
//               heightFactor: 15,
//             );
//           } else {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//                _themes = snapshot.data;
//               return GridView.count(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                   children: _themes!.themeList.map((theme) {
//                     return NeumorphicButton(
//                       onPressed: () {
//                         if (_stepIndex < (stepList().length - 1)) {
//                           setState(() {
//                             _selectedThemeId = theme.themeId;
//                             _stepIndex += 1;
//                           });
//                         }
//                       },
//                       child: Center(
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Image.network(
//                                   theme.icon,
//                                   height: 30,
//                                   width: 30,
//                                   alignment: Alignment.center,
//                                 ),
//                               ),
//                               Text(theme.name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15)),
//                             ]),
//                       ),
//                     );
//                   }).toList());
//             }
//           }
//         });
//   }
//
//   // set text and image
//   Widget thirdStep() {
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height - 144,
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: NeumorphicText(
//                   'Step 3 \n Create your ads Content',
//                   textStyle: NeumorphicTextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                   style: const NeumorphicStyle(
//                       shape: NeumorphicShape.concave, color: Colors.blueGrey),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: NeumorphicToggle(
//                         height: 50,
//                         selectedIndex: _selectedIndex,
//                         displayForegroundOnlyIfSelected: true,
//                         thumb: Neumorphic(
//                           style: NeumorphicStyle(
//                               boxShape: NeumorphicBoxShape.roundRect(
//                                   const BorderRadius.all(Radius.circular(12)))),
//                         ),
//                         children: [
//                           ToggleElement(
//                             background: const Center(
//                                 child: (Text(
//                               'A text',
//                               style: TextStyle(fontWeight: FontWeight.w500),
//                             ))),
//                             foreground: const Center(
//                                 child: (Text(
//                               'A text',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.blueAccent),
//                             ))),
//                           ),
//                           ToggleElement(
//                               background: const Center(
//                                   child: (Text(
//                                 'A pic',
//                                 style: TextStyle(fontWeight: FontWeight.w500),
//                               ))),
//                               foreground: const Center(
//                                   child: (Text(
//                                 'A pic',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.blueAccent),
//                               )))),
//                           ToggleElement(
//                               background: const Center(
//                                   child: (Text(
//                                 'A video',
//                                 style: TextStyle(fontWeight: FontWeight.w500),
//                               ))),
//                               foreground: const Center(
//                                   child: (Text('A video',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.blueAccent))))),
//                           ToggleElement(
//                               background: const Center(
//                                   child: (Text(
//                                 'An audio',
//                                 style: TextStyle(fontWeight: FontWeight.w500),
//                               ))),
//                               foreground: const Center(
//                                   child: (Text(
//                                 'An audio',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.blueAccent),
//                               ))))
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedIndex = value;
//                           });
//                         },
//                       ),
//                     ),
//                     _selectedIndex == 0
//                         ? textAdsType()
//                         : _selectedIndex == 1
//                             ? picAdsType()
//                             : _selectedIndex == 2
//                                 ? videoAdsType()
//                                 : audioAdsType(),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: NeumorphicButton(
//                           onPressed: () {
//                             if (_stepIndex < (stepList().length - 1)) {
//                               setState(() {
//                                 _adMainText =
//                                     _mainTextAdTypeTextController.text;
//                                 _adAdditionalText =
//                                     _additionalTextAdTypeTextController.text;
//                                 _stepIndex += 1;
//                               });
//                             }
//                             //TODO get text and IDs then send to server
//                           },
//                           child: const Text(
//                             'Submit',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           )),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget textAdsType() {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             NeumorphicText(
//               'type your ads message',
//               textStyle: NeumorphicTextStyle(
//                   fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//               style: const NeumorphicStyle(
//                   shape: NeumorphicShape.concave, color: Colors.blueGrey),
//             ),
//             SizedBox(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Neumorphic(
//                       style: const NeumorphicStyle(depth: -4),
//                       child: TextField(
//                         textAlignVertical: TextAlignVertical.center,
//                         maxLength: 70,
//                         maxLines: null,
//                         controller: _mainTextAdTypeTextController,
//                         decoration: const InputDecoration(
//                           label: Text('Main text'),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(10.0),
//                           hintText: 'Type your main text here',
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Neumorphic(
//                       style: const NeumorphicStyle(depth: -4),
//                       child: TextField(
//                         textAlignVertical: TextAlignVertical.center,
//                         maxLength: 70,
//                         maxLines: null,
//                         controller: _additionalTextAdTypeTextController,
//                         decoration: const InputDecoration(
//                           label: Text('Additional text'),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(10.0),
//                           hintText: 'Type your additional text here',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget picAdsType() {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             NeumorphicText(
//               'upload your pic, pics will only be shown to the sender.',
//               textStyle: NeumorphicTextStyle(
//                   fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//               style: const NeumorphicStyle(
//                   shape: NeumorphicShape.concave, color: Colors.blueGrey),
//             ),
//             const SizedBox(height: 5,),
//             adsPick != null
//                 ? NeumorphicButton(
//                 onPressed: () async {
//                   setState(() {
//                     _image = '';
//                     adsPick = null;
//                   });
//                 },
//                 child: const Icon(
//                   Icons.delete_forever,
//                   size: 20.0,
//                 ))
//                 : const SizedBox(),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Neumorphic(
//                   style: const NeumorphicStyle(
//                     depth: -4,
//                   ),
//                   child: Center(
//                     child: adsPick == null
//                         ? NeumorphicButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 File file = File(result.files.single.path!);
//                                 if(file.lengthSync() < 200000) {
//                                   setState(() {
//                                     _image = imageToBase64(file);
//                                     adsPick = file;
//                                   });
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                       content: Text('The size of the picture needs to be under 200 kilobyte, please resize it and try again')
//                                   ));
//                                   // size is big
//                                 }
//                               }
//                             },
//                             child: const Text(
//                               'select a pic',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ))
//                         : Image.file(adsPick!),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget videoAdsType() {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             NeumorphicText(
//               'upload your video',
//               textStyle: NeumorphicTextStyle(
//                   fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//               style: const NeumorphicStyle(
//                   shape: NeumorphicShape.concave, color: Colors.blueGrey),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Neumorphic(
//                   style: const NeumorphicStyle(
//                     depth: -4,
//                   ),
//                   child: Center(
//                     child: NeumorphicButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'select a video, video will only be shown to the sender.',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget audioAdsType() {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             NeumorphicText(
//               'upload your audio',
//               textStyle: NeumorphicTextStyle(
//                   fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//               style: const NeumorphicStyle(
//                   shape: NeumorphicShape.concave, color: Colors.blueGrey),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Neumorphic(
//                   style: const NeumorphicStyle(
//                     depth: -4,
//                   ),
//                   child: Center(
//                     child: NeumorphicButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'select an audio, audio will only be shown to the sender.',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   // publish setting
//   Widget fourthStep() {
//     return SingleChildScrollView(
//         child: SizedBox(
//       height: MediaQuery.of(context).size.height - 50,
//       child: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: NeumorphicText(
//                 'Step 4 \n advertisement publish setting',
//                 textStyle: NeumorphicTextStyle(
//                     fontSize: 10, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//                 style: const NeumorphicStyle(
//                     shape: NeumorphicShape.concave, color: Colors.blueGrey),
//               ),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Expanded(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Neumorphic(
//                     style: NeumorphicStyle(
//                         boxShape: NeumorphicBoxShape.roundRect(
//                             const BorderRadius.all(Radius.circular(8)))),
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Text(
//                           'How much are you paying for this Ad, each?',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                             '${(_payForAdSlider.toInt()) * 100}  ${AppLocalizations.of(context).toman}',
//                             style: const TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.bold)),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: NeumorphicSlider(
//                             height: 20,
//                             value: _payForAdSlider,
//                             style: const SliderStyle(depth: 4),
//                             min: 1,
//                             max: 10,
//                             sliderHeight: 10,
//                             onChanged: (value) {
//                               setState(() {
//                                 _payForAdSlider = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Neumorphic(
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'How many Ads you want to publish?',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               NeumorphicRadio(
//                                 child: const SizedBox(
//                                   height: 50,
//                                   width: 60,
//                                   child: Center(
//                                     child: Text(
//                                       "<10000",
//                                       style: TextStyle(fontSize: 13),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                                 value: 1,
//                                 groupValue: _groupValue,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _groupValue = value!;
//                                   });
//                                 },
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               NeumorphicRadio(
//                                 child: const SizedBox(
//                                   height: 50,
//                                   width: 60,
//                                   child: Center(
//                                     child: Text("<100000",
//                                         style: TextStyle(fontSize: 13)),
//                                   ),
//                                 ),
//                                 value: 2,
//                                 groupValue: _groupValue,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _groupValue = value!;
//                                   });
//                                 },
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               NeumorphicRadio(
//                                 child: const SizedBox(
//                                   height: 50,
//                                   width: 60,
//                                   child: Center(
//                                     child: Text("<1000000",
//                                         style: TextStyle(fontSize: 13)),
//                                   ),
//                                 ),
//                                 value: 3,
//                                 groupValue: _groupValue,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _groupValue = value!;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text('${(_publishCount.toInt())}  Ads',
//                               style: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold)),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: NeumorphicSlider(
//                               height: 20,
//                               value: _publishCount,
//                               style: const SliderStyle(depth: 4),
//                               min: _groupValue == 1
//                                   ? 1
//                                   : _groupValue == 2
//                                       ? 10001
//                                       : 100001,
//                               max: _groupValue == 1
//                                   ? 10000
//                                   : _groupValue == 2
//                                       ? 100000
//                                       : 1000000,
//                               sliderHeight: 10,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _publishCount = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Neumorphic(
//                       style: NeumorphicStyle(
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               const BorderRadius.all(Radius.circular(8)))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                             'cost: ${((_payForAdSlider.toInt()) * 100) * ((_publishCount.toInt()))} ${AppLocalizations.of(context).toman}',
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blueAccent)),
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 NeumorphicButton(
//                     onPressed: () {
//                       if (_stepIndex < (stepList().length - 1)) {
//                         setState(() {
//                           _stepIndex += 1;
//                         });
//                       }
//                       _payForAd = _payForAdSlider.toInt() * 100;
//                       _orderCount = _publishCount.toInt();
//                       saveAdToServer();
//                     },
//                     child: _loading
//                         ? const Center(
//                             child: SizedBox(
//                                 height: 22,
//                                 width: 22,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.blueAccent,
//                                 )))
//                         : Text(
//                             AppLocalizations.of(context).payAndSubmit,
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.purpleAccent),
//                           )),
//               ],
//             ))
//           ],
//         ),
//       ),
//     ));
//   }
//
//   String imageToBase64(File image) {
//     List<int> fileInByte = image.readAsBytesSync();
//     String fileInBase64 = base64Encode(fileInByte);
//     return fileInBase64;
//   }
//
//   Future<Categories?> getCategories() async {
//     if (_categories != null) {
//       if (_categories!.categoryList.isNotEmpty) {
//         return _categories;
//       } else {
//         Apis api = Apis();
//         List<dynamic> response = await api.getCategories();
//         if (response[0] != null) {
//           return response[0];
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 response[1].contains('SocketException')
//                     ? 'Network error, please check your network connection'
//                     : response[1],
//                 textAlign: TextAlign.center),
//           ));
//           return null;
//         }
//       }
//     } else {
//       Apis api = Apis();
//       List<dynamic> response = await api.getCategories();
//       if (response[0] != null) {
//         return response[0];
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//               response[1].contains('SocketException')
//                   ? 'Network error, please check your network connection'
//                   : response[1],
//               textAlign: TextAlign.center),
//         ));
//         return null;
//       }
//     }
//   }
//
//   Future<Themes?> getThemes(String categoryId) async {
//     if (_themes != null) {
//       if (_themes!.themeList.isNotEmpty) {
//         return _themes;
//       } else {
//         Apis api = Apis();
//         List<dynamic> response = await api.getThemes(categoryId);
//         if (response[0] != null) {
//           return response[0];
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 response[1].contains('SocketException')
//                     ? 'Network error, please check your network connection'
//                     : response[1],
//                 textAlign: TextAlign.center),
//           ));
//           return null;
//         }
//       }
//     } else {
//       Apis api = Apis();
//       List<dynamic> response = await api.getThemes(categoryId);
//       if (response[0] != null) {
//         return response[0];
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//               response[1].contains('SocketException')
//                   ? 'Network error, please check your network connection'
//                   : response[1],
//               textAlign: TextAlign.center),
//         ));
//         return null;
//       }
//     }
//   }
//
//   Future saveAdToServer() async {
//
//     setState(() {
//       _loading = true;
//     });
//
//     print('Constants.sponsorAdsSetting: ${Constants.sponsorAdsSetting['targetPhoneNumbers']}');
//     Apis api = Apis();
//     SponsorAd sponsorAd = SponsorAd(
//       text: _adMainText,
//       additionalText: _adAdditionalText,
//       themeId: _selectedThemeId,
//       categoryId: _selectedCategoryId,
//       fee: _payForAd,
//       orderCount: _orderCount,
//       image: _image,
//       targetPhoneNumbers: Constants.sponsorAdsSetting['targetPhoneNumbers'],
//       targetPhoneNumbersCanSent:
//           Constants.sponsorAdsSetting['targetPhoneNumberCanSent'],
//       targetPhoneNumbersCanReceive:
//           Constants.sponsorAdsSetting['targetPhoneNumberCanReceive'],
//       senderFee: Constants.sponsorAdsSetting['senderFee'].toInt(),
//       receiverFee: Constants.sponsorAdsSetting['receiverFee'].toInt(),
//       startAt: Constants.sponsorAdsSetting['isoFrom'],
//       endAt: Constants.sponsorAdsSetting['isoTo'],
//       maximumViewPerSender: Constants.sponsorAdsSetting['maximumViewPerSender'],
//       maximumViewPerReceiver:
//           Constants.sponsorAdsSetting['maximumViewPerReceiver'],
//       senderMobileTypes: Constants.sponsorAdsSetting['senderMobileTypes'],
//       receiverMobileTypes: Constants.sponsorAdsSetting['receiverMobileTypes'],
//       senderOperators: Constants.sponsorAdsSetting['senderOperatorTypes'],
//       receiverOperators: Constants.sponsorAdsSetting['receiverOperatorTypes'],
//       senderMobileNumbers: Constants.sponsorAdsSetting['senderMobileNumbers'],
//       receiverMobileNumbers:
//           Constants.sponsorAdsSetting['receiverMobileNumbers'],
//     );
//         // print('iiiiiiiiimage ${sponsorAd.image}');
//
//     print('taaaaaaaaaaaarget ${sponsorAd}');
//
//     List<dynamic> response = await api.createAd(sponsorAd);
//     if (response[0] != null) {
//       setState(() {
//         _loading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(AppLocalizations.of(context).adsCreatedSuccessfully,
//             textAlign: TextAlign.center),
//       ));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SponsorsAdsPage()),
//       );
//       Constants.sponsorAdsSetting = {
//         'maximumViewPerSender': 1,
//         'maximumViewPerReceiver': 1,
//         'targetPhoneNumbers': [],
//         'targetPhoneNumberCanSent': true,
//         'senderFee': 0.0,
//         'targetPhoneNumberCanReceive': true,
//         'receiverFee': 0.0,
//         'isoFrom': 'from',
//         'isoTo': 'to',
//         'senderOperatorTypes': [],
//         'receiverOperatorTypes': [],
//         'senderMobileTypes': [],
//         'receiverMobileTypes': [],
//         'senderMobileNumbers': [],
//         'receiverMobileNumbers': [],
//       };
//       return response[0];
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//             response[1].contains('SocketException')
//                 ? 'Network error, please check your network connection'
//                 : response[1],
//             textAlign: TextAlign.center),
//       ));
//       setState(() {
//         _loading = false;
//       });
//       return null;
//     }
//   }
// }
