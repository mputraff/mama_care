import 'package:flutter/material.dart';
import 'package:MamaCare/auth/widgets/InputAuth.dart';
import 'package:MamaCare/auth/widgets/ButtonAuth.dart';
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
                      "Register account Mama Care",
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
                                "Username",
                                style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 5),
                            InputAuth(
                              hintText: 'username',
                              icon: Icons.person,
                              controller: nameController,
                            ),
                            SizedBox(height: 15),
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
                            SizedBox(height: 25),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonAuth(
                                      text: "Register",
                                      onPressed: () => register(context))
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        fontFamily: 'Fredoka',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.pushNamed(context, '/login')
                                    },
                                    child: Text('Login'),
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
