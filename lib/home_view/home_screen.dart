import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freesms/helpers/constants.dart';
import 'package:freesms/helpers/folderHelper.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/home_view/widget/versionConflictModal.dart';
import 'package:freesms/pages/rewardScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../Costanat.dart';
import '../apis/apis.dart';
import '../helpers/sharedprefs.dart';
import '../helpers/smsHelper.dart';
import '../models/folders.dart';
import '../pages/version_conflict.dart';
import '../presentation/pages/home/contacts_view/read_contacts_page.dart';
import '../user/providers/userProvider.dart';
import '../widgets/contact_list.dart';
import 'chats_veiw/chats_screen.dart';
import 'contacts_view/contacts_screen.dart';
import 'wallet_view/wallet_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver  {

  bool rewardOn=SharedPrefs.getReward();
  List<Folders>_folders=[];
  @override
  void initState() {
    super.initState();
    if(SharedPrefs.isFirstDBInjection()) {
      SharedPrefs.setFirstDBInjection(false);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // final userProvider = Provider.of<UserProvider>(context,listen: false);
      // print(userProvider.getRoles());
      // if (userProvider.getRoles().contains("admin")) {
      //   SharedPrefs.setAdmin(true);
      //   setState(() {
      //
      //   });
      // } else {
      //   SharedPrefs.setAdmin(false);
      //   setState(() {
      //
      //   });
      // }

    });

    checkVersion();

  }

  void checkVersion()async{
    try {
      Apis apis = Apis();
      String serverVersion = await apis.checkVersion();
      //a:server version
      //b:app version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;
      List<String> appVersionSpilt = appVersion.split(".");
      List<String> serverVersionSpilt = serverVersion.split(".");
      print(SharedPrefs.getSeenVersion());
      SharedPreferences shared=await SharedPreferences.getInstance();
      List<String> seenVersionSpilt =(shared.getString("vers")!=null)?shared.getString("vers")!.split("."):[];
      print("_"+seenVersionSpilt.length.toString());
      int a = int.parse(serverVersionSpilt[0]) * 1000 +
          int.parse(serverVersionSpilt[1]) * 100 +
          int.parse(serverVersionSpilt[2]);
      int b = int.parse(appVersionSpilt[0]) * 1000 +
          int.parse(appVersionSpilt[1]) * 100 +
          int.parse(appVersionSpilt[2]);
      int seenVersion=(seenVersionSpilt.isNotEmpty)?int.parse(seenVersionSpilt[0]) * 1000 +
          int.parse(seenVersionSpilt[1]) * 100 +
          int.parse(seenVersionSpilt[2]):-1;
      print("${a}___${b}");

      if (b < a) {
        if (seenVersion != -1 && a != seenVersion) {
          //show modal
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return VersionModal(version: serverVersion);
            },
          );
        }
        if(seenVersion == -1){
          //show modal
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return VersionModal(version: serverVersion);
            },
          );
        }
        else{
          print("version maybe Ok!");
        }
      }
      else{
        print("version is Ok!");
      }
    }
    catch(e){
      print("err:$e");
    }

  }

  int _currentIndex = 0;

  void onTabTapped(int index, _BottomProvider provider) {
    if (index < 3) {
      setState(() {
        _currentIndex = index;
      });
    } else if (index == 3) {
      provider.changeRewarded();
      Toast.show("Ads box is ${provider.isRewarded ? 'On' : 'OFF'}",
          backgroundColor: Colors.black87,
          duration: 1,
          textStyle: const TextStyle(color: Colors.white));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget build(BuildContext context) {
    ToastContext().init(context);
    List<Widget> _children() {
      return [
        ChatsScreen(folders: FolderHelper.getAll()),
        ReadContactsPage(),
        const WalletScreen(),
        ChatsScreen(folders: FolderHelper.getAll()),
      ];
    }

    double size = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) =>
          _BottomProvider(isRewarded: SharedPrefs.getReward()),
      child: Builder(builder: (context) {
        return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 65,
              child:
              Consumer<_BottomProvider>(builder: (context, state, _) {
                return BottomNavigationBar(
                  backgroundColor: Costanat.colorWhite,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: (index) => onTabTapped(index, state),
                  currentIndex: _currentIndex,
                  selectedItemColor: Costanat.selectedIconColor,
                  unselectedItemColor: Costanat.unselectedIconColor,
                  iconSize: 25,
                  selectedLabelStyle: TextStyle(
                      fontSize: size * 0.03, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      fontSize: size * 0.03, fontWeight: FontWeight.bold),
                  items: [
                    BottomNavigationBarItem(
                      label: AppLocalizations.of(context).chats,
                      icon: const Icon(Icons.chat),
                    ),
                    BottomNavigationBarItem(
                      label: AppLocalizations.of(context).contacts,
                      icon: const Icon(Icons.person),
                    ),
                    BottomNavigationBarItem(
                      label: AppLocalizations.of(context).wallet,
                      icon:
                      const Icon(Icons.account_balance_wallet_outlined),
                    ),
                    BottomNavigationBarItem(
                      label: state.isRewarded
                          ? AppLocalizations.of(context).reward +
                          " " +
                          AppLocalizations.of(context).on
                          : AppLocalizations.of(context).reward +
                          " " +
                          AppLocalizations.of(context).off,
                      icon: Icon(Icons.card_giftcard,
                          color:
                          state.isRewarded ? Colors.green : Colors.red),
                    ),
                  ],
                );
              }),
            ),
            body: Center(
              child: _children().elementAt(_currentIndex),
            ));
      }),
    );
  }
}

class _BottomProvider extends ChangeNotifier {
  _BottomProvider({required this.isRewarded});

  bool isRewarded;

  changeRewarded() {
    isRewarded = !isRewarded;
    SharedPrefs.setReward(isRewarded);
    notifyListeners();
  }
}



