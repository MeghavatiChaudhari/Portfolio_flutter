import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneFieldWidget extends StatelessWidget {
  const CustomPhoneFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: const InputDecoration(
        hintText: 'Enter Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 5),
        ),
      ),
    );
  }
}
