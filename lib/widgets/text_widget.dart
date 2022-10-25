import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText({required this.text, required this.value, Key? key})
      : super(key: key);
  String text;
  String value;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text: $value",
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
