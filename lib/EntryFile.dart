import 'package:flutter/material.dart';
import 'package:first_app/view/custom_text_field_widget.dart';
import 'package:first_app/view/custom_profile_image_widget.dart';
import 'package:first_app/view/custom_dropdown_widget.dart';
import 'package:first_app/view/custom_phone_field_widget.dart';
import 'package:first_app/view/custom_appbar_widget.dart';
import 'package:first_app/pages/user_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/theme/colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  String? _selectedGender;
  String? _contactNumber;

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('about', aboutController.text);
    await prefs.setString('gender', _selectedGender ?? 'Not specified');
    await prefs.setString('contact', _contactNumber ?? 'not provided');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWidget(),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown, AppColors.purpleTransparent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProfileImage(),
                  CustomTextField(
                    hintText: 'What is your last name',
                    nameController: nameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'About me',
                    nameController: aboutController,
                  ),
                  const SizedBox(height: 20),
                  DropDown(
                    selectedGender: _selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomPhoneFieldWidget(
                    onChanged: (String newNumber) {
                      setState(() {
                        _contactNumber = newNumber;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveProfileData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(
                            nameOfPerson: nameController.text,
                            aboutMe: aboutController.text,
                            gender: _selectedGender ?? 'Not Specified',
                            contactNumber: _contactNumber ?? 'Not Provided',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.purpleTransparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
