import 'package:flutter/material.dart';

List themes = ['Bank', 'Cloth', 'Cosmetics', 'Food', 'Medical', 'Science', 'Sport', 'Travel', 'Other'];

class Themes extends StatelessWidget {
  const Themes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.builder(itemCount: themes.length, itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        height: 130,
        decoration: const BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
        width: MediaQuery.of(context).size.height * 0.9, // Set the width of the container inside the card
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, bottom: 14.0, right: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(themes[index], style: const TextStyle(fontWeight: FontWeight.bold),),
              const Icon(Icons.arrow_forward_ios, size: 20)
            ],
          ),
        ),
      ),
          )
    );
  }
}
