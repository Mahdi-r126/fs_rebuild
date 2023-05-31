// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import '../../../apis/apis.dart';
// import '../../../helpers/sharedprefs.dart';
// import '../../../models/ad.dart';
// import '../../../models/admin_login.dart';
// import '../../../models/ads_list.dart';
// import '../../../models/organizations.dart';
// import '../../../pages/add_ads.dart';
// import '../../../pages/admin_panel.dart';
// import '../../../pages/media_holder.dart';
// import '../../shared/utils/injection_container.dart';
// import '../add_ads/add_ads_page.dart';
// import 'sponsor_ads_bloc.dart';
// import 'sponsor_ads_state.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// TextEditingController _controller = TextEditingController();
// TextEditingController _userNameController = TextEditingController();
// TextEditingController _passwordController = TextEditingController();
// late List<Ad> _ads = [];
//
// class SponsorsAdsPage extends StatefulWidget {
//   const SponsorsAdsPage({Key? key}) : super(key: key);
//
//   @override
//   State<SponsorsAdsPage> createState() => SponsorsAdsPageState();
// }
//
// class SponsorsAdsPageState extends State<SponsorsAdsPage> {
//   bool _loading = true;
//   bool _error = false;
//   bool _loginLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getAdsByPagination();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: const Text(
//           'Sponsors',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//             child: GestureDetector(
//               child: const Icon(Icons.search),
//               onTap: () {
//                 // searchAds(_controller.text);
//               },
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//               height: MediaQuery.of(context).size.height - 144,
//               child: buildSponsorsView()),
//         ),
//       ),
//     );
//   }
//
//   Widget buildSponsorsView() {
//     if (_ads.isEmpty) {
//       if (_loading) {
//         return const Center(
//             child: Padding(
//           padding: EdgeInsets.all(8),
//           child: CircularProgressIndicator(),
//         ));
//       } else if (_error) {
//         return Center(child: errorDialog());
//       }
//     }
//
//     return Column(
//       children: [
//         SizedBox(
//           height: (MediaQuery.of(context).size.height - 144) * 0.1,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Neumorphic(
//               style: NeumorphicStyle(
//                 depth: -4,
//                 boxShape:
//                     NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
//               ),
//               child: TextField(
//                 textAlignVertical: TextAlignVertical.center,
//                 controller: _controller,
//                 textInputAction: TextInputAction.search,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.all(10.0),
//                   suffixIcon: GestureDetector(
//                     child: const Icon(Icons.search),
//                     onTap: () {
//                       // searchAds(_controller.text);
//                     },
//                   ),
//                   hintText: AppLocalizations.of(context).search,
//                 ),
//                 onEditingComplete: () {
//                   // searchAds(_controller.text);
//                 },
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: (MediaQuery.of(context).size.height - 144) * 0.1,
//           child: NeumorphicButton(
//             style: NeumorphicStyle(
//                 boxShape: NeumorphicBoxShape.roundRect(
//                     const BorderRadius.all(Radius.circular(20)))),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AddAds()),
//               );
//             },
//             child: Text(
//               AppLocalizations.of(context).adAd,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: (MediaQuery.of(context).size.height - 144) * 0.7,
//           child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _ads.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: _ads.isNotEmpty
//                         ? createAdsRow(context, _ads, index)
//                         : const SizedBox());
//               }),
//         ),
//       ],
//     );
//   }
//
//   Widget errorDialog() {
//     return SizedBox(
//       height: 180,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'An error occurred when fetching the adds.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             NeumorphicButton(
//                 onPressed: () {
//                   setState(() {
//                     _loading = true;
//                     _error = false;
//                     getAdsByPagination();
//                   });
//                 },
//                 child: const Text(
//                   "Retry",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget createAdsRow(BuildContext context, List<Ad>? ads, int index) {
//     Ad a = ads![index];
//     return NeumorphicButton(
//       onPressed: () {},
//       child: Container(
//         padding: const EdgeInsets.all(3.0),
//         width: double.infinity,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   height: 35,
//                   width: 35,
//                   decoration: const BoxDecoration(
//                       color: Colors.blueAccent,
//                       borderRadius: BorderRadius.all(Radius.circular(30))),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '${index + 1}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Text(
//                   a.text!,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Row(
//                 children: [
//                   const Text(
//                     'Sent ads: ',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   Text(
//                     '${a.orderCount - a.remainingOrderCount}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 20),
//               Row(
//                 children: [
//                   const Text(
//                     'Total ads: ',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   Text(
//                     '${a.orderCount}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ]),
//             const SizedBox(
//               height: 10,
//             ),
//             NeumorphicSlider(
//               thumb: const SizedBox(width: 2),
//               height: 20,
//               value: (a.orderCount - a.remainingOrderCount).toDouble(),
//               style: const SliderStyle(depth: 4),
//               min: 1,
//               max: a.orderCount.toDouble(),
//               sliderHeight: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> getAdsByPagination() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.getAllAdsByPagination();
//     if (response[0] != null) {
//       AdsList adsList = response[0];
//       setState(() {
//         _loading = false;
//         _ads = [];
//         _ads.addAll(adsList.adsList);
//       });
//       return response[0];
//     } else {
//       setState(() {
//         _loading = false;
//         if (response[2] != 404) {
//           _error = true;
//         }
//       });
//       if (response[2] == 404) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(response[1], textAlign: TextAlign.center),
//         ));
//       }
//     }
//   }
//
//   Future<void> loginOrganization() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.organizationLogin(
//         _userNameController.text, _passwordController.text);
//
//     if (response[0] != null) {
//       SharedPrefs.setOrganizationAccessToken(
//           (response[0] as Organizations).accessToken);
//       SharedPrefs.setOrganizationRefreshToken(
//           (response[0] as Organizations).refreshToken);
//       setState(() {
//         _loginLoading = !_loginLoading;
//       });
//       Navigator.of(context, rootNavigator: true).pop();
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const MediaHolder('Bank Sina')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Network error, can`t connect to server',
//             textAlign: TextAlign.center),
//       ));
//       setState(() {
//         _loginLoading = !_loginLoading;
//       });
//     }
//   }
//
//   Future<void> loginAdmin() async {
//     Apis api = Apis();
//     List<dynamic> response = await api.adminLogin(
//         _userNameController.text, _passwordController.text);
//
//     if (response[0] != null) {
//       SharedPrefs.setAdminAccessToken((response[0] as AdminLogin).accessToken);
//       SharedPrefs.setAdminRefreshToken(
//           (response[0] as AdminLogin).refreshToken);
//       setState(() {
//         _loginLoading = !_loginLoading;
//       });
//       Navigator.of(context, rootNavigator: true).pop();
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const AdminPanel()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Network error, can`t connect to server',
//             textAlign: TextAlign.center),
//       ));
//       setState(() {
//         _loginLoading = !_loginLoading;
//       });
//     }
//   }
// }