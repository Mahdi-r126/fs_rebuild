import 'package:flutter/material.dart';
import 'package:freesms/home_view/chats_veiw/screens/chats/providers/contact_provider.dart';
import 'package:provider/provider.dart';

import 'components/addFolder_button.dart';
import 'components/folder_button.dart';
import 'components/folder_input.dart';
import 'components/folder_richText.dart';

class AddFolderScreen extends StatefulWidget {
  const AddFolderScreen({Key? key}) : super(key: key);

  @override
  State<AddFolderScreen> createState() => _AddFolderScreenState();
}

class _AddFolderScreenState extends State<AddFolderScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedContact=Provider.of<ContactProvider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const FolderRichText(),
            const SizedBox(height: 15,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FolderInput(),
                SizedBox(width: 10,),
                FolderButton(),
              ],
            ),
            const SizedBox(height: 40,),
            const AddFolderButton(),
            const SizedBox(height: 40,),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (selectedContact.getContact.isNotEmpty)?Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage("assets/images/avatar.png"),
                          ),
                          const SizedBox(width: 10,),
                          Text(selectedContact.getContact[index].displayName!,style: const TextStyle(color: Colors.black,fontSize: 15),)
                        ],
                      ),
                    ):Container();
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: selectedContact.getContact.length),
            )
          ],
        ),
      ),
    );
  }
}
