import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF16404D),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
