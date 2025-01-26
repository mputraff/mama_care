import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  ProfileImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 1.8,
            offset: Offset(0, 0),
          ),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/img/LogoMamaCare.png',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
