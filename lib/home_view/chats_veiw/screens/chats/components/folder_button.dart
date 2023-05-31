import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderButton extends StatelessWidget {
  const FolderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text("Icon", style: TextStyle(fontSize: 16,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold),),
      ),
    );
  }
}
