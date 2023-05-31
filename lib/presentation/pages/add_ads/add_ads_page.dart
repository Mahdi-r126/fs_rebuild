import 'package:flutter/material.dart';
import 'package:freesms/presentation/pages/add_ads/widgets/steps.dart';

class AddAdsPage extends StatelessWidget {
  const AddAdsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Advertise',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SponsorSetting()),
              // );
            },
            icon: Image.asset('assets/images/sponsor_setting.png', height: 20),
            disabledColor: Colors.grey,
          )
        ],
      ),
      body: const Steps(),
    );
  }
}
