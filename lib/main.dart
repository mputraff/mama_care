import 'package:flutter/material.dart';
import 'package:hallo_dunia/auth/screens/LoginScreen.dart';
import 'package:hallo_dunia/screens/FirstScreen.dart';
import 'package:hallo_dunia/auth/screens/RegisterScreen.dart';
import 'package:hallo_dunia/dashboard/screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mama Care',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) =>  RegisterScreen(),
        '/home' : (context) => HomeScreen(),
      },
    );
  }
}

