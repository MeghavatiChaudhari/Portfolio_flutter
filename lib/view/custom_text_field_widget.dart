import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController nameController;
  // final TextEditingController aboutController;
  // var nameController = TextEditingController();
  CustomTextField(
      {Key? key, required this.hintText, required this.nameController})
      : super(key: key);

//    const CustomTextField({
//     Key? key,
//      required this.hintText,
//      this.controller,
// }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
            )),
        hintText: hintText,
      ),
      controller: nameController,
    );
  }
}
