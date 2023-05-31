import 'package:flutter/material.dart';
import 'package:freesms/home_view/chats_veiw/screens/chats/providers/folderName_provider.dart';
import 'package:provider/provider.dart';

class FolderInput extends StatefulWidget {
  const FolderInput({Key? key}) : super(key: key);

  @override
  State<FolderInput> createState() => _FolderInputState();
}

class _FolderInputState extends State<FolderInput> {

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // final FocusNode _focusNode = FocusNode();
    final folderName=Provider.of<FolderNameProvider>(context);
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextField(
          cursorColor: Colors.blue,
          focusNode: _focusNode,
          onChanged: (value) {
            _focusNode.requestFocus();
            folderName.setFolderName=value;
          },
          autofillHints: const ["Enter Folder Name"],
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              focusColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
