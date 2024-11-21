import 'package:flutter/material.dart';
import 'package:hallo_dunia/auth/widgets/InputAuth.dart';
import 'package:hallo_dunia/auth/widgets/ButtonAuth.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
    } else {
      try {
        AuthService authService = AuthService();
        String response = await authService.registerUser(name, email, password);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response)));

        if (response.contains('successfully')) {
          // Redirect user to login screen
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $error')),
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
              hintText: 'Username',
              icon: Icons.person,
              controller: nameController,
            ),
            SizedBox(height: 10),
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
              onPressed: () => register(context),
              text: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
