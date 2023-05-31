import 'package:flutter/material.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/helpers/folderHelper.dart';
import 'package:freesms/main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../helpers/smsHelper.dart';
import '../../../home_view/home_screen.dart';
import '../../../user/providers/userProvider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  Future<void> init() async {
    await Permission.sms.request();
    await Permission.contacts.request();

    await FolderHelper.init();
    await SmsHelper.init();
    await ContactHelper.init();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 2.3),
                Image.asset(
                  'assets/logo.png',
                  height: 85,
                  width: 85,
                ),
                // Image.asset(
                //   'assets/images/free_sms.png',
                //   height: 64,
                //   width: 64,
                // ),
                const Spacer(),
                const CircularProgressIndicator(
                  color: Color(0xFF2C66FF),
                )
              ],
            ),
          )),
    );
  }
}

Future<bool> versionConflict(String serverVersion) async {
  //a:server version
  //b:app version
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;
  List<String> appVersionSpilt = appVersion.split(".");
  List<String> serverVersionSpilt = serverVersion.split(".");
  int a = int.parse(serverVersionSpilt[0]) * 1000 +
      int.parse(serverVersionSpilt[1]) * 100 +
      int.parse(serverVersionSpilt[2]);
  int b = int.parse(appVersionSpilt[0]) * 1000 +
      int.parse(appVersionSpilt[1]) * 100 +
      int.parse(appVersionSpilt[2]);
  print("${a}___$b");
  return b < a;
}
