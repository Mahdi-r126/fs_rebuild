import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RewardScreen extends StatelessWidget {

  bool reward;
  RewardScreen({Key? key,required this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:(reward)?Colors.green.shade200:Colors.red.shade300 ,
      appBar: AppBar(
        // backgroundColor: Color(0xFF0C0D0F),
        title: Text(AppLocalizations.of(context).reward,
          style: const TextStyle(color: Color(0xFF0C0D0F),
              fontSize: 20,fontWeight: FontWeight.w700),
        ),

      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            text: AppLocalizations.of(context).seeAds+": ",
              style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: (reward)?AppLocalizations.of(context).on:AppLocalizations.of(context).off,
                style: (reward)? TextStyle(color: Colors.green.shade800,fontSize: 18,fontWeight: FontWeight.bold):
                TextStyle(color: Colors.red.shade900,fontSize: 18,fontWeight: FontWeight.bold)
              )
            ]
          ),
        )
      ),
    );
  }
}
