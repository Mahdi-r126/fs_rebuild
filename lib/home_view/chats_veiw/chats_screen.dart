import 'package:flutter/material.dart';
import 'package:freesms/home_view/widget/drawer.dart';
import 'package:provider/provider.dart';
import '../../Costanat.dart';
import '../../helpers/smsHelper.dart';
import '../../models/folders.dart';
import '../../presentation/pages/home/contacts_view/read_contacts_page.dart';
import '../../user/providers/userProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/chats/folder_screen.dart';

class ChatsScreen extends StatefulWidget {

  List<Folders>folders;
  ChatsScreen({Key? key,required this.folders}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> _tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.folders.length+1, vsync: this);
  }

  List<Tab> initTabs(double size){
    List<Tab> folderTabs=[];
    print("===="+widget.folders.length.toString());
    for(Folders folder in widget.folders.reversed){
      folderTabs.add(
          Tab(
              child: Text(
                folder.title!,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.04),
              )
          )
      );
    }
    return folderTabs;
  }

  List<Tab> staticTabs(double size){
    List<Tab> staticTabs=[];
    Tab allTab=Tab(child: Text(
      AppLocalizations.of(context).all,
      style: TextStyle(
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.04),
    ));
    staticTabs.add(allTab);
    return staticTabs;
  }

  List<Tab> setAllTabs(double size){
    setState(() {
      _tabs=staticTabs(size)+initTabs(size)/*+[Tab(child: Text("+",style:TextStyle(
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.04) ))]*/;
    });
    return _tabs;
  }


  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    double size = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      drawer: const MainDrawer(),
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        title: Text(
          AppLocalizations.of(context).chats,
          style: TextStyle(
              color: Costanat.appBarTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          Visibility(
            visible: false,
            child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                    color: Costanat.appBarTextColor,
                  ),
                )),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: setAllTabs(size)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF2C66FF),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        onPressed: () {
          Dialog errorDialog = Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: SizedBox(
              height: 450,
              width: double.infinity,
              child: ReadContactsPage(removeDrawer: true),
            ),
          );
          showDialog(
              context: context, builder: (BuildContext context) => errorDialog);
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FolderScreen(messages: SmsHelper.allInboxes(null)), //all chats folder
          // FolderScreen(messages: SmsHelper.allInboxes(widget.folders[1].numbers)),
          // FolderScreen(messages: SmsHelper.allInboxes(widget.folders[0].numbers)),
          for(Folders folder in widget.folders.reversed) FolderScreen(messages: SmsHelper.allInboxes(folder.numbers)),
          // AddFolderScreen(),
        ],
      ),
    );
  }

  Future<List<String>> getDepartments() async {
    var list = ["a", "b", "a", "b", "a", "b", "a", "b"];
    return list;
  }
}
