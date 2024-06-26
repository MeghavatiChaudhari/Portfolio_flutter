import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;
  // const DropDown({super.key});
  const DropDown({
     Key? key,
    required this.selectedGender,
    required this.onChanged,
   }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedGender,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: Colors.grey[700], fontSize: 15),
      padding: const EdgeInsets.all(10.0),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: onChanged,
      items: <String>['Male', 'Female']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  }

