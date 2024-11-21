import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/img/pregnant.png',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              ' Welcome to Mama Care',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40), // Padding horizontal
              child: Text(
                'Mama Care hadir sebagai teman setia bagi para ibu hamil, memberikan informasi, dukungan, dan komunitas yang dibutuhkan selama masa kehamilan.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign
                    .justify, // Ubah menjadi center untuk meratakan teks
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Get Started'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade200,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(height: 130),
            Text('Mama Care',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w300,
                ))
          ],
        ),
      ),
    );
  }
}
