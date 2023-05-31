import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freesms/helpers/constants.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/home_view/chats_veiw/screens/chats/providers/contact_provider.dart';
import 'package:freesms/home_view/chats_veiw/screens/chats/providers/folderName_provider.dart';
import 'package:freesms/metrix/metrix.dart';
import 'package:freesms/pages/about_us.dart';
import 'package:freesms/pages/select_language_page.dart';
import 'package:freesms/user/providers/userProvider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import './helpers/objectbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './presentation/shared/utils/injection_container.dart' as di;
import 'helpers/path_provider.dart';
import 'home_view/home_screen.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/splash/splash_page.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
late ObjectBox? objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FreeSmsMetrix.init();

  di.init();
  objectBox = await ObjectBox.create();
  await GetStorage.init();
  await AppPathProvider.initPath();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => FolderNameProvider()),
    ChangeNotifierProvider(create: (context) => ContactProvider()),
  ], child: const MyApp()));
  await SmsAutoFill().listenForCode();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(SharedPrefs.getLocal().toString().split("_")[0],
      SharedPrefs.getLocal().toString().split("_")[1]);

  changeLanguage(Locale locale) {
    SharedPrefs.setLocal('${locale.languageCode}_${_locale.countryCode}');
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navKey,
        routes: {
          'login': (BuildContext context) => const Login(),
          'ads_login': (context) => const AboutUs(),
        },
        locale: _locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: Constants.appTitle,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(
              primary: Colors.white,
              brightness: Brightness.light,
              onPrimary: Colors.black),
          appBarTheme: const AppBarTheme(
              elevation: 1,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  systemNavigationBarColor: Color(0xFF000000),
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true),
          // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(Constants.accentColor)),
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 18.0),
            bodyMedium: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          ),
        ),
        home:
            // first launch
            SharedPrefs.isFirstLaunch()
                ? const SelectLanguagePage()
                :
                // not first launch but not logged in yet
                !SharedPrefs.isLoginDone()
                    ? const Login()
                    :
                    // not first launch and logged in and db injection is done
                    !SharedPrefs.isFirstDBInjection()
                        // ? const MainPage()
                        ? const SplashPage()
                        : const HomeScreen()
        // : const ReadContactsPage()
        );
  }
}
