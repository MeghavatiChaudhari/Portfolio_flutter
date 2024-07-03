import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneFieldWidget extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  const CustomPhoneFieldWidget(
      {Key? key, this.initialValue, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: const InputDecoration(
        hintText: 'Enter Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 5),
        ),
      ),
      initialCountryCode: 'IN',
      initialValue: initialValue,
      onChanged: (PhoneNumber? phone) {
        if (phone != null) {
          onChanged(phone.completeNumber);
        }
      },
    );
  }
}
