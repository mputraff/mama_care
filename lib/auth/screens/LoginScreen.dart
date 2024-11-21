import 'package:flutter/material.dart';
import 'package:hallo_dunia/auth/widgets/InputAuth.dart';
import 'package:hallo_dunia/auth/widgets/ButtonAuth.dart';
import '../services/auth_service.dart';

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
    } else {
      try {
        final response = await AuthService().loginUser(email, password);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));
        // Jika login berhasil, navigasi ke halaman utama
        if (response.contains('successfully')) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w300,
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
                          color: Colors.pink.shade200)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
