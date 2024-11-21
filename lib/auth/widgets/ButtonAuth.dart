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
      width: 300,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink.shade200,
          textStyle: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black
          )
        ),        
      ),
    );
  }
}
