import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6), // Warna bayangan
            spreadRadius: 1, // Jarak bayangan
            blurRadius: 1, // Tingkat keburaman bayangan
            offset: Offset(0, 1), // Posisi bayangan
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: Image.asset(
          'assets/img/uta.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
