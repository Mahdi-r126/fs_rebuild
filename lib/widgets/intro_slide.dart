import 'package:flutter/material.dart';

class IntroSlide extends StatelessWidget {
  final String message;
  final String image;

  const IntroSlide(this.message, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(child: Container(width: MediaQuery.of(context).size.width, decoration: const BoxDecoration(color: Colors.white),height: 100, child: Text(message, style: const TextStyle(fontSize: 50), textAlign: TextAlign.center,)),bottom: 0,)
          ],
        ),
      ),
    );
  }
}
