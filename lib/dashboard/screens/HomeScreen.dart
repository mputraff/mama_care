import 'package:flutter/material.dart';
import 'package:hallo_dunia/dashboard/widgets/ProfileImage.dart';
import 'package:hallo_dunia/dashboard/widgets/AppBarHome.dart';
import 'package:hallo_dunia/dashboard/widgets/BodyHome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: AppBarHome(),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: BodyHome(),
      ),
            
    );
  }
}
