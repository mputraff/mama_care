import 'package:flutter/material.dart';
import 'package:MamaCare/auth/widgets/InputAuth.dart';
import 'package:MamaCare/auth/models/user_model.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA6CDC6),
        appBar: AppBar(
            backgroundColor: Color(0xFFA6CDC6),
            title: Container(
              padding: EdgeInsets.only(left: 47),
              child: Text("Forgot Password",
                  style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            )),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Container(
                child: Image.asset(
                  "assets/img/forgotPass.png",
                  width: 260,
                  height: 260,
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 300,
                child: Text(
                  "Masukkan Gmail terdaftar untuk mereset password akun Anda",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20), // Menambahkan jarak antara teks dan input
              Container(
                width: 370,
                child: InputAuth(
                  hintText: 'youremail@domain.com',
                  icon: Icons.email,
                  controller: emailController,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  width: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF16404D),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Send"),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ))
            ],
          )),
        ));
  }
}
