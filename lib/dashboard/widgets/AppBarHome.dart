import 'package:flutter/material.dart';
import 'ProfileImage.dart';

class AppBarHome extends StatelessWidget {

  final String username;
  final String profilePicture;

  AppBarHome({required this.username, required this.profilePicture});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      child: Row(
        children: [
          ProfileImage(imageUrl: profilePicture),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 12,
                    color: Colors.grey.shade700),
              ),
              Text(
                username,
                style: TextStyle(
                    fontFamily: 'Fredoka', fontSize: 19, color: Colors.black),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
