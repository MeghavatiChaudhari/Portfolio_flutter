import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:first_app/view/custom_text_field_widget.dart';
import 'package:first_app/view/custom_profile_image_widget.dart';
import 'package:first_app/view/custom_dropdown_widget.dart';
import 'package:first_app/view/custom_phone_field_widget.dart';
import 'package:first_app/view/custom_appbar_widget.dart';
import 'package:first_app/pages/user_profile.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
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
              // Container(
              //   child: CustomTextField(
              //     hintText: 'name ',
              //     nameController: nameController,
              //   ),
              // ),
              CustomTextField(
                hintText: 'what is your last name ',
                nameController: nameController,
              ),
              Container(
                height: 40,
              ),
              CustomTextField(
                  hintText: 'about me', nameController: aboutController),
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
                onPressed: () {
                  // print("name is ${nameController.text}");
                  print('name is+${aboutController.text}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(
                        nameOfPerson: nameController.text,
                        aboutMe: aboutController.text,
                      ),
                    ),
                  );
                },
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
