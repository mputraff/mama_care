import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ProfileImage.dart';
import 'package:MamaCare/auth/models/user_model.dart';

class AppBarHome extends StatelessWidget {
  final UserModel user;
  final String username;
  final String profilePicture;

  AppBarHome(
      {required this.username,
      required this.profilePicture,
      required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImage(imageUrl: profilePicture),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                    fontFamily: 'Fredoka', fontSize: 12, color: Colors.black),
              ),
              Text(
                username,
                style: TextStyle(
                    fontFamily: 'Fredoka', fontSize: 19, color: Colors.black),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: user);
            },
            icon: Icon(Icons.person),
            style: IconButton.styleFrom(
              foregroundColor: Color(0xFF16404D),
              backgroundColor: Colors.white,
              iconSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
