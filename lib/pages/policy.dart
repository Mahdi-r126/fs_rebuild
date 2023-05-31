import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class Policy extends StatelessWidget {
  const Policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // backgroundColor: Color(0xFF0C0D0F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,color:Color(0xFF0C0D0F),
              size: 20.0,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text( "Policy",
            style: TextStyle(color: Color(0xFF0C0D0F),
                fontSize: 20,fontWeight: FontWeight.w700),
          ),

        ),

    body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(Constants.policy,
      textAlign: TextAlign.justify
      ,style: const TextStyle(
      color: Color(0xFF0C0D0F),fontSize: 16,
      fontWeight: FontWeight.w400
      ),),
      ),

      /*SizedBox(
            height: MediaQuery.of(context).size.height - 144,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                AppLocalizations.of(context).helpText,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 17),
              )),
            ),
          ));*/

      ],),
    ));



    /*SizedBox(
      height: MediaQuery.of(context).size.height -144,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Text(
          AppLocalizations.of(context).aboutUsText
        , textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 15),)),
      ),
    ));*/
  }
}