import 'package:flutter/material.dart';

class FolderRichText extends StatelessWidget {
  const FolderRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
          text: "Folder Name",
          style:TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red,)
            ),
          ]
      ),
    );
  }
}
