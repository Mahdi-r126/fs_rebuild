import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freesms/home_view/home_screen.dart';
import 'package:freesms/home_view/wallet_view/wallet_screen.dart';

class PaymenetAlert extends StatelessWidget {
  final String message;
  PaymenetAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(AppLocalizations.of(context).alert, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(message,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 17))),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).ok,
              style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
