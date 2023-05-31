import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/main.dart';
import 'package:freesms/metrix/metrix.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int systemLocal = 1;
  int primary = 2;

  Map<String, dynamic> options = {
    "fa_IR": ["Farsi", "assets/images/iran_flag.png"],
    "en_US": ["English", "assets/images/england_flag.png"]
  };

  final Object? _languageSelectionValue = Object();

  int english = 0;
  int persian = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF0C0D0F),
              size: 20.0,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppLocalizations.of(context).setting,
            style: const TextStyle(
                color: Color(0xFF0C0D0F),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 144,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      height: 50,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setLocal(systemLocal);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                WidgetsBinding.instance.window.locale
                                            .toString() ==
                                        "fa_IR"
                                    ? options["fa_IR"][1]
                                    : options["en_US"][1],
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "${AppLocalizations.of(context).systemDefault} (${WidgetsBinding.instance.window.locale.toString() == "fa_IR" ? options["fa_IR"][0] : options["en_US"][0]})")
                            ],
                          ),
                        ),
                        const Divider(height: 30),
                        GestureDetector(
                          onTap: () {
                            setLocal(primary);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                WidgetsBinding.instance.window.locale
                                            .toString() ==
                                        "fa_IR"
                                    ? options["en_US"][1]
                                    : options["fa_IR"][1],
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "${WidgetsBinding.instance.window.locale.toString() == "fa_IR" ? options["en_US"][0] : options["fa_IR"][0]} (${AppLocalizations.of(context).primary})")
                            ],
                          ),
                        ),
                        const Divider(height: 30),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }

  changeLocal(Locale newLocale) {
final phoneNumber=SharedPrefs.getPhoneNumber();
    FreeSmsMetrix.settingChangeLanguage(
      phoneNumber: phoneNumber,
      locale: '${newLocale.languageCode}_${newLocale.countryCode}',
    );
    MyApp.setLocale(context, newLocale);
  }

  void setLocal(int type) {
    if (type == systemLocal) {
      WidgetsBinding.instance.window.locale.toString() == "fa_IR"
          ? changeLocal(const Locale('fa', 'IR'))
          : changeLocal(const Locale('en', 'US'));
    } else {
      WidgetsBinding.instance.window.locale.toString() == "fa_IR"
          ? changeLocal(const Locale('en', 'Us'))
          : changeLocal(const Locale('fa', 'IR'));
    }
  }
}
