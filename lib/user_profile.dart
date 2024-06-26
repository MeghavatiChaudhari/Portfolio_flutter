import 'package:first_app/main.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(const MaterialApp(
    home: UserProfile(),
  ));
}

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
