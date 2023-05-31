import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Map<String, dynamic> options = {
  "fa_IR": ["Farsi", "assets/images/iran_flag.png"],
  "en_US": ["English", "assets/images/england_flag.png"],
};

class CustomDropdown extends StatelessWidget {


  const CustomDropdown(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(14.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).select,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const Icon(Icons.expand_more),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 144,
        // child: Column(
        //   children: [
        //     Row(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(left: 20, right: 20),
        //           child: Image.asset(
        //             "assets/images/languages.png",
        //             height: 50,
        //             width: 50,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         Text(
        //           AppLocalizations.of(context).chooseLanguage,
        //           style: const TextStyle(
        //               fontSize: 20, fontWeight: FontWeight.bold),
        //         ),
        //       ],
        //     ),
        //     Container(
        //       height: MediaQuery.of(context).size.height * 0.8,
        //       decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(10)),
        //           color: Colors.grey),
        //       child: ListView.builder(
        //         itemCount: options.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return ListTile(
        //             title: Text(options[index]),
        //           );
        //         },
        //       ),
        //     )
        //   ],
        // ),
      );
    },
  );
}
