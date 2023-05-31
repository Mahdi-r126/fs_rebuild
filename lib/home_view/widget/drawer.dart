import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/sharedprefs.dart';
import '../../pages/about_us.dart';
import '../../pages/admin_panel.dart';
import '../../pages/help.dart';
import '../../pages/setting.dart';
import '../../presentation/pages/sponsor_ads/sponsors_ads_page.dart';
import '../../widgets/share_to_friends.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFDDE6E8),
              ),
              child: null,
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).shareToFriends,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShareToFriends()),
                );
              },
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).setting,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context).help,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Help(),
                    ));
              },
            ),
            // ListTile(
            //   title: Text(
            //     AppLocalizations.of(context).aboutUs,
            //     style:
            //     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {
            //     Navigator.of(context, rootNavigator: true).pop();
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const AboutUs(),
            //         ));
            //   },
            // ),
            // ListTile(
            //   title: Text(
            //     AppLocalizations.of(context).sponsors,
            //     style:
            //     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {
            //     Navigator.of(context, rootNavigator: true).pop();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const SponsorsAdsPage()),
            //     );
            //   },
            // ),
            // (SharedPrefs.getAdmin())
            //     ? ListTile(
            //   title: Text(
            //     AppLocalizations.of(context).adminPanel,
            //     style: const TextStyle(
            //         fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const AdminPanel()),
            //     );
            //   },
            // )
            //     : const ListTile(),
          ],
        ),
      );
  }
}
