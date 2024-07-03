import 'package:flutter/material.dart';
import '../view/custom_profile_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:first_app/pages/edit_profile_page.dart';

class UserProfile extends StatefulWidget {
  final String nameOfPerson;
  final String aboutMe;
  final String gender;
  final String contactNumber;

  const UserProfile({
    Key? key,
    required this.nameOfPerson,
    required this.aboutMe,
    required this.gender,
    required this.contactNumber,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome $_name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.0,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            ProfileImage(),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Name: $_name',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me:',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _about,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Gender: $_gender',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact No: $_contact',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
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
              child: const Text('Edit',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.0,
                    fontFamily: 'Roboto',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
