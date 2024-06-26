import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({Key? key,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: const BorderSide(
    color: Colors.black,
    width: 1,
        )
      ),
    hintText: hintText,
    ),
    textAlign: TextAlign.left,
    );
  }
}
