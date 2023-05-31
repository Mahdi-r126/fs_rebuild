import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 144,
      width: double.infinity,
      child: Column(
        children: [
          const Text('Select Ads Segment', style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Container(
            height: 130,
            decoration: const BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.height * 0.9, // Set the width of the container inside the card
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0, bottom: 14.0, right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Free Services', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('Include 9 themes', style: TextStyle(fontSize: 14))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            height: 130,
            decoration: const BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.height * 0.9, // Set the width of the container inside the card
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0, bottom: 14.0, right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Private Sector', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('Include 9 themes', style: TextStyle(fontSize: 14))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            height: 130,
            decoration: const BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.height * 0.9, // Set the width of the container inside the card
            child: const Padding(
              padding: EdgeInsets.only(left: 14.0, bottom: 14.0, right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Public Services', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('Include 9 themes', style: TextStyle(fontSize: 14))
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
