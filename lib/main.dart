import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:first_app/view/custom_text_field_widget.dart';
import 'package:first_app/view/custom_profile_image_widget.dart';
import 'package:first_app/view/custom_dropdown_widget.dart';
import 'package:first_app/view/custom_phone_field_widget.dart';
import 'package:first_app/view/custom_appbar_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWidget(),
      backgroundColor: Colors.white,
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileImage(),
              const CustomTextField(hintText: 'what is your last name '),
              Container(
                height: 40,
              ),
              const CustomTextField(hintText: 'about me'),
              Container(
                height: 40,
              ),
              DropDown(
                  selectedGender: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  }),
              Container(
                height: 40,
              ),
              const CustomPhoneFieldWidget(),
              Container(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Submit'), // Button tex
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
