import 'package:flutter/material.dart';

class PageNumberButton extends StatelessWidget {
  final int pageNumber;
  final bool isSelected;

  const PageNumberButton({Key? key, required this.pageNumber, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        backgroundColor: isSelected ? Colors.blue : Colors.grey,
        child: Text(
          pageNumber.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}