import 'package:flutter/material.dart';

class InputAuth extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  const InputAuth({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _InputAuthState createState() => _InputAuthState();
}

class _InputAuthState extends State<InputAuth> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.hintText} is required';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Fredoka',
            color: Color(0xFF16404D),  
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF16404D), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF16404D), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF16404D), width: 2.0),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 10),
            child: Icon(widget.icon, color: Color(0xFF16404D)),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF16404D),
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Fredoka',
          fontWeight: FontWeight.w500,
          color: Color(0xFF16404D),
        ),
      ),
    );
  }
}
