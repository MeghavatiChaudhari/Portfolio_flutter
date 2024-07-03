import 'package:flutter/material.dart';
import 'package:first_app/view/custom_text_field_widget.dart';
import 'package:first_app/view/custom_profile_image_widget.dart';
import 'package:first_app/view/custom_dropdown_widget.dart';
import 'package:first_app/view/custom_phone_field_widget.dart';
import 'package:first_app/view/custom_appbar_widget.dart';
import 'package:first_app/pages/user_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  String? _selectedGender;
  String? _contactNumber;
  String _name = '';
  String _about = '';
  String _gender = '';
  String _contact = '';

  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Not provided';
      _about = prefs.getString('about') ?? 'Not provided';
      _gender = prefs.getString('gender') ?? 'Not provided';
      _contact = prefs.getString('contact') ?? 'Not provided';

      nameController.text = _name;
      aboutController.text = _about;
      _selectedGender = _gender;
      _contactNumber = _contact;
    });
  }

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
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileImage(),
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
              CustomPhoneFieldWidget(
                initialValue: _contactNumber,
                onChanged: (String newNumber) {
                  setState(() {
                    _contactNumber = newNumber;
                  });
                },
              ),
              Container(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // print("name is ${nameController.text}");
                  print('name is+${aboutController.text}');
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
                  backgroundColor: Colors.blue, // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'), // Button tex
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
