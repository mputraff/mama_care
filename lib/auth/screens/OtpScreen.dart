import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  void _moveToNextField(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA6CDC6),
        body: SingleChildScrollView(
          child: Center(
            
              child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 120),
                alignment: Alignment.center,
                child: Text("Verify Otp Code",
                    style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Image.asset(
                  "assets/img/otp.png",
                  width: 280,
                  height: 280,
                ),
              ),
              Container(
                width: 300,
                child: Text(
                  "Masukkan kode OTP yang telah dikirim ke Gmail Anda",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        counterText: '',
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLength: 1,
                      onChanged: (value) => _moveToNextField(index, value),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak menerima kode?"),
                  TextButton(
                    onPressed: () {},
                    child: Text("Kirim ulang kode"),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF16404D),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Verify"),
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
