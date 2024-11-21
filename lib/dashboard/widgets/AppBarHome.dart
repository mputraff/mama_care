import 'package:flutter/material.dart';
import 'ProfileImage.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build 
    return Row(
      children: [
        ProfileImage(),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 12,
                  color: Colors.grey.shade600),
            ),
            Text(
              'Putra Fauzan',
              style: TextStyle(
                  fontFamily: 'Fredoka', fontSize: 18, color: Colors.black),
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.notifications_none_outlined),
      ],
    );
  }
}
