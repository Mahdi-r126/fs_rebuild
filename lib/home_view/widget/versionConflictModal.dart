import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/sharedprefs.dart';


class VersionModal extends StatelessWidget {
  String version;
  VersionModal({Key? key,required this.version}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  version.startsWith('1.') || version.startsWith('2.') ||
                      version.startsWith('3.')
                      ? '${AppLocalizations.of(context).aNewVersion} ($version.version) ${AppLocalizations.of(context).updateIsAvailable}'
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
                      onPressed: () async {
                        SharedPrefs.setSeenVersion(version);
                        print(SharedPrefs.getSeenVersion());
                        SharedPreferences shared=await SharedPreferences.getInstance();
                        shared.setString("vers", version);
                        Navigator.of(context).pop();
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
      );
  }
}
