import 'package:first_app/main.dart';
import 'package:flutter/material.dart';

import '../view/custom_profile_image_widget.dart';

class UserProfile extends StatefulWidget {
  final String nameOfPerson;
  final String aboutMe;
  const UserProfile(
      {Key? key, required this.nameOfPerson, required this.aboutMe})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome ${widget.nameOfPerson}',
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
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            ProfileImage(),
            const SizedBox(height: 20),
            Text(
              'Name  ${widget.nameOfPerson}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.0,
                fontFamily: 'Roboto',
              ),
            )
          ],
        ));
  }
}
