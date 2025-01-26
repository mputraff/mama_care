import 'package:flutter/material.dart';
import 'package:MamaCare/dashboard/widgets/AppBarHome.dart';
import 'package:MamaCare/dashboard/widgets/BodyHome.dart';
import 'package:MamaCare/auth/models/user_model.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFA6CDC6),
        title: AppBarHome(username: user.name, profilePicture: user.profilePicture, user: user),
      ),
      body: BodyHome(user: user), // Passing user to BodyHome
    );
  }
}