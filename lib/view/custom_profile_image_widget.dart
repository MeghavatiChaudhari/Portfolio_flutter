import 'package:flutter/material.dart';
import 'package:first_app/pages/user_profile.dart';

class ProfileImage extends StatelessWidget {
  // final String name;
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png',
                  fit: BoxFit.cover,
                  width: 150.0,
                  height: 150.0,
                ),
              ),
            ),
            // Text(
            //   // 'SIDOP',
            //
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //     fontStyle: FontStyle.italic,
            //     letterSpacing: 1.2,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
