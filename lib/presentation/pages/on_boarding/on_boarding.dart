import 'package:flutter/material.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/metrix/metrix.dart';

import '../../../helpers/contactHelper.dart';
import '../login/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "title": "هزینه هر پیامک رو به درآمد تبدیل کن",
      "description":
          "In this section, you must enter a description of one of the unique features of the product in a maximum of 3 lines and explain about this feature.",
      "image": "assets/images/intro001.png"
    },
    {
      "title": "تبلیغ بده 100 درصد دیده شو",
      "description":
          "In this section, you must enter a description of one of the unique features of the product in a maximum of 3 lines and explain about this feature.",
      "image": "assets/images/intro002.png"
    },
    {
      "title": "هدف ما تولید ثروت برای نشاندن بیشتر لبخند بر لبان است",
      "description":
          "In this section, you must enter a description of one of the unique features of the product in a maximum of 3 lines and explain about this feature.",
      "image": "assets/images/intro003.png"
    },
    {
      "title": "چیزی بیشتر از یک پیام",
      "description":
          "In this section, you must enter a description of one of the unique features of the product in a maximum of 3 lines and explain about this feature.",
      "image": "assets/images/intro004.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) {
                    return SplashContent(
                      image: splashData[index]["image"]!,
                      title: splashData[index]["title"]!,
                      // description: splashData[index]["description"]!,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // if (_currentPage != 0)
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _currentPage != 0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white70;
                          } else {
                            return Colors.white;
                          }
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:
                                const BorderSide(width: 1, color: Colors.blue),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  if (_currentPage == splashData.length - 1)
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _currentPage == splashData.length - 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue;
                            } else {
                              return Colors.blueAccent;
                            }
                          }),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  width: 1, color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          FreeSmsMetrix.intro(skipped: false, compeleted: true);
                          await _pushToLogin();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          child: Text(
                            'Go to Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage != splashData.length - 1)
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _currentPage != splashData.length - 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue;
                            } else {
                              return Colors.blueAccent;
                            }
                          }),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  width: 1, color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20.0),
              if (_currentPage != splashData.length - 1)
                TextButton(
                  onPressed: () async {
                    FreeSmsMetrix.intro(skipped: true, compeleted: false);
                    await _pushToLogin();
                  },
                  child: const Text(
                    'Skip and Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pushToLogin() async {
    final isGranted = await ContactHelper.permissionCheckAndRequest();

    if (!isGranted) {
      return;
    }
    SharedPrefs.setFirstLaunch(false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String image;
  final String title;
  // final String description;

  const SplashContent({
    Key? key,
    required this.image,
    required this.title,
    // required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 350.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          // Text(
          //   description,
          //   textAlign: TextAlign.start,
          //   style: const TextStyle(
          //     fontSize: 16.0,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
