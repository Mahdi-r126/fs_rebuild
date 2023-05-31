import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freesms/main.dart';
import 'package:freesms/metrix/metrix.dart';
import 'package:freesms/presentation/pages/on_boarding/on_boarding.dart';

import '../helpers/sharedprefs.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({Key? key}) : super(key: key);

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {

  Map<String, dynamic> mainOptions = {
    "fa_IR": ["Farsi", "assets/images/iran_flag.png"],
    "en_GB": ["English", "assets/images/england_flag.png"]
  };

  final Map<String, dynamic> reservedOptions = {
    "ar_SA": ["Arabic", "assets/images/saudi_arabia_flag.png"],
    "de_DE": ["Germany", "assets/images/germany_flag.png"],
    "es_ES": ["Spanish", "assets/images/spain_flag.png"],
  };

  final Object? _languageSelectionValue = Object();

  @override
  void initState() {
    super.initState();
    FreeSmsMetrix.selectLanguage(SharedPrefs.getLocal());

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.only(top: 56),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Image.asset(
                    "assets/images/languages.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  AppLocalizations.of(context).chooseLanguage,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  AppLocalizations.of(context).selectLanguage,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: mainOptions.keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            setLocal(
                                mainOptions.keys
                                    .toList()[index]
                                    .toString()
                                    .split("_")[0],
                                mainOptions.keys
                                    .toList()[index]
                                    .toString()
                                    .split("_")[0]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                mainOptions[mainOptions.keys.toList()[index]]
                                    [1],
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "${mainOptions[mainOptions.keys.toList()[index]][0]} ${WidgetsBinding.instance.window.locale.toString() == mainOptions.keys.toList()[index] ? "(System Default)" : ""}"),
                              const Spacer(),
                              Icon(Icons.check_circle,
                                  color: mainOptions.keys
                                          .toList()[index]
                                          .toString()
                                          .contains(Localizations.maybeLocaleOf(
                                                  context)
                                              .toString())
                                      ? Colors.green
                                      : Colors.transparent)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context).othersLanguages,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.red)),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        final double statusBarHeight =
                            MediaQuery.of(context).padding.top;
                        _showBottomSheet(context, statusBarHeight);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).select,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                            const Icon(Icons.expand_more),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            if (states
                                .contains(MaterialState.pressed)) {
                              return const Color(0xFF2C66FF);
                            } else {
                              return const Color(0xFF2C66FF);
                            }
                          }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      FreeSmsMetrix.selectLanguage(SharedPrefs.getLocal());
                      SharedPrefs.setFirstLaunch(false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const OnBoardingPage(),
                          ));
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        AppLocalizations.of(context).start,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    ));
  }

  void _showBottomSheet(BuildContext context, double statusBarHeight) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - statusBarHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Image.asset(
                          "assets/images/languages.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).chooseLanguage,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      (108 + statusBarHeight),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Color(0xFFf4f5f8)),
                  child: Column(
                    children: [
                      const Divider(
                          thickness: 3,
                          color: Colors.black,
                          indent: 120,
                          endIndent: 120,
                          height: 50),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            (158 + statusBarHeight),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              indent: 10,
                              endIndent: 10,
                            );
                          },
                          itemCount: reservedOptions.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setLocal(
                                    reservedOptions.keys
                                        .toList()[index]
                                        .toString()
                                        .split("_")[0],
                                    reservedOptions.keys
                                        .toList()[index]
                                        .toString()
                                        .split("_")[0]);

                                mainOptions.putIfAbsent(reservedOptions.keys
                                    .toList()[index], () => reservedOptions[reservedOptions.keys
                                    .toList()[index]]);

                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(reservedOptions[
                                    reservedOptions.keys.toList()[index]][0]),
                                leading: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Image.asset(
                                    reservedOptions[reservedOptions.keys
                                        .toList()[index]][1],
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  changeLocal(Locale newLocale) {
    MyApp.setLocale(context, newLocale);
  }

  void setLocal(String s1, String s2) {
    setState(() {
      changeLocal(Locale(s1, s2));
      SharedPrefs.setLocal("${s1}_$s2");
    });
  }
}
