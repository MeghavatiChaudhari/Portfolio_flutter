import 'package:first_app/screens/weather/home/weather_home_view.dart';
import 'package:flutter/material.dart';
import '../view/custom_profile_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:first_app/pages/edit_profile_page.dart';
import 'package:first_app/theme/colors.dart';

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

  @override
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, AppColors.purpleTransparent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ProfileImage(),
              const SizedBox(height: 20),
              _buildProfileDetail('Name', _name),
              const SizedBox(height: 30),
              _buildProfileSection('About Me', _about),
              const SizedBox(height: 30),
              _buildProfileDetail('Gender', _gender),
              const SizedBox(height: 30),
              _buildProfileDetail('Contact No', _contact),
              const SizedBox(height: 40),
              _buildButton('Edit', Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              }),
              const SizedBox(height: 40),
              _buildButton('Goto MyWeatherApp', Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherHomeView(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '$title: $value',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color, // Text color
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
