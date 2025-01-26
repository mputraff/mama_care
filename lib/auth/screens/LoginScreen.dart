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
            color: Color(0xFF16404D),
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
        backgroundColor: Color(0xFF7EACB5),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 26,
                ),
                child: Image.asset(
                  "assets/img/login_image.png",
                  fit: BoxFit.none,
                  scale: 3.7,
                ),
              ),
            ),
            //Color(0xFF7EACB5)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 586,
              decoration: BoxDecoration(
                color: Color(0xFFF2F9FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    alignment: Alignment.center,
                    child: Text(
                      "Login to Mama Care",
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Container(
                      height: 521,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFA6CDC6),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(35)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                "Email Address",
                                style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 5),
                            InputAuth(
                              hintText: 'youremail@domain.com',
                              icon: Icons.email,
                              controller: emailController,
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 5),
                            InputAuth(
                              hintText: 'password',
                              icon: Icons.lock,
                              controller: passwordController,
                              isPassword: true,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 190),
                              child: TextButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      textStyle: TextStyle(
                                        fontFamily: 'Fredoka',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  onPressed: () => {
                                    Navigator.pushNamed(context, '/forgot-password')
                                  },
                                  child: Text("Forgot Password ?")),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonAuth(
                                      text: "Login",
                                      onPressed: () => login(context))
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontFamily: 'Fredoka',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.pushNamed(context, '/register')
                                    },
                                    child: Text('Register'),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        textStyle: TextStyle(
                                            fontFamily: 'Fredoka',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ]),
        ));
  }
}
