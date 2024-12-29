import 'package:flutter/material.dart';
import 'package:MamaCare/auth/widgets/InputAuth.dart';
import 'package:MamaCare/auth/widgets/ButtonAuth.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:MamaCare/auth/models/user_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email and Password cannot be empty')),
      );
      return;
    }

    // Tampilkan loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.pink.shade200,
          ),
        );
      },
    );

    try {
      final loginResult = await AuthService().loginUser(email, password);

      // Tutup loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      if (loginResult != null) {
        UserModel user = loginResult['user'];
        String token = loginResult['token'];

        // Simpan data user dan token ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toJson()));
        await prefs.setString('jwt_token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigasi ke halaman utama dan kirim objek UserModel
        Navigator.pushReplacementNamed(context, '/home', arguments: user);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your email or password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Tutup loading dialog jika terjadi error
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFFFCCE1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/pregnant.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            InputAuth(
              hintText: 'Email',
              icon: Icons.email,
              controller: emailController,
            ),
            SizedBox(height: 10),
            InputAuth(
              hintText: 'Password',
              icon: Icons.lock,
              controller: passwordController,
              isPassword: true,
            ),
            SizedBox(height: 10),
            ButtonAuth(
              text: 'Login',
              onPressed: () => login(context),
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () => {Navigator.pushNamed(context, '/register')},
                  child: Text('Register'),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.pink.shade200,
                      textStyle: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                          color: Colors.pink.shade300)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
