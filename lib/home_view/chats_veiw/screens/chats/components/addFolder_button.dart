import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/folderName_provider.dart';
import 'modal_contact.dart';

class AddFolderButton extends StatelessWidget {
  const AddFolderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final folderName=Provider.of<FolderNameProvider>(context);
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width-30,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const ModalContact();
          },));
        },
        child: const Text("Select Contact", style: TextStyle(fontSize: 16,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold),),
      ),
    );
  }
}
