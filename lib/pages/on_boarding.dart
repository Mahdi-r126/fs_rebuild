import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: <Widget>[
      //     PageView.builder(
      //       controller: controller,
      //       onPageChanged: (index) {
      //         setState(() {
      //           currentPage = index;
      //         });
      //       },
      //       itemCount: 5,
      //       itemBuilder: (BuildContext context, int index) {
      //         return IntroSlide(
      //             Constants.messages[index], Constants.images[index]);
      //       },
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: SizedBox(
      //         height: 50,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             Flexible(child: Container()),
      //             Flexible(
      //               child: Indicator(controller: controller),
      //             ),
      //             Flexible(
      //               child: (currentPage == Constants.numberOfIntroPages - 1)
      //                   ? GestureDetector(
      //                   onTap: () {},
      //                   child: Center(
      //                       child: TextButton(
      //                         onPressed: () {
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) =>
      //                                 const Login()),
      //                           );
      //                           // go to login page
      //                         },
      //                         child: const Text("ورود",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 color: Colors.blue,
      //                                 fontSize: 20)),
      //                       )))
      //                   : GestureDetector(
      //                   onTap: () {
      //                     controller
      //                         .jumpToPage(Constants.numberOfIntroPages - 1);
      //                   },
      //                   child: const Center(
      //                       child: Text(
      //                         "رد شدن",
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.blue,
      //                             fontSize: 20),
      //                       ))),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}