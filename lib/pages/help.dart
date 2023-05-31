import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
       /* appBar: NeumorphicAppBar(
          title: Text(
            AppLocalizations.of(context).help,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          buttonStyle: const NeumorphicStyle(
            shape: NeumorphicShape.convex,
          ),
        ),*/

        appBar: AppBar(
          // backgroundColor: Color(0xFF0C0D0F),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Color(0xFF0C0D0F),
              size: 20.0,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text( AppLocalizations.of(context).help,
            style: TextStyle(color: Color(0xFF0C0D0F),
                fontSize: 20,fontWeight: FontWeight.w700),
          ),

        ),


        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          Container(
              width: double.maxFinite,
              // color: Colors.yellowAccent,
              height: 150,
              // margin: const EdgeInsets.only(bottom: 20.0),
              child:
              Image.asset("assets/images/help-img.jpg",
                width: 150,height: 150,)
          ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(AppLocalizations.of(context).helpText,
                  textAlign: TextAlign.justify
                ,style: TextStyle(
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

        ],)



    );


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
  }
}
