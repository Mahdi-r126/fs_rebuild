import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home_view/home_screen.dart';

class VersionConflict extends StatelessWidget {
  final String version;

  const VersionConflict(this.version, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height - 144,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  version.startsWith('1.') || version.startsWith('2.') ||
                      version.startsWith('3.')
                      ? '${AppLocalizations.of(context).aNewVersion} ($version) ${AppLocalizations.of(context).updateIsAvailable}}'
                      :
                  version.contains('SocketException') ? 'Network error, please check your network connection' : version
                  , textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(AppLocalizations.of(context).later, style: const TextStyle(color: Colors.white)),
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen() /*MainPage()*/),
                        );
                        //TODO
                        // SharedPrefs.setCheckLts(false);
                        // SharedPrefs.setVersion(version);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text((AppLocalizations.of(context).ok),style: const TextStyle(color: Colors.white)),
                      onPressed: () async {
                        const url = 'https://smsonlines.ir';
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                        } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("'Could not launch $url'")));
                        }
                      },
                    ),
                  ],
                )
              ],
            )
            ),
          ),
        ));
  }
}