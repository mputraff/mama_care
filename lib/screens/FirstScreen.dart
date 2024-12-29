import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const FirstScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Inisialisasi AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Durasi animasi
      vsync: this,
    );

    // Membuat animasi fade
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Memulai animasi setelah sedikit delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    // Pastikan untuk dispose controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 191, 209),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // Gunakan FadeTransition untuk animasi
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/img/pregnant.png',
                height: 350,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _animation,
              child: Text(
                ' Welcome to Mama Care',
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FadeTransition(
                opacity: _animation,
                child: Text(
                  'Mama Care hadir sebagai teman setia bagi para ibu hamil, memberikan informasi, dukungan, dan komunitas yang dibutuhkan selama masa kehamilan.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade900,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: ElevatedButton(
                child: Text(
                  'Get Started',
                  style: TextStyle(fontFamily: 'Fredoka'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade200,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Panggil onComplete sebelum navigasi
                  widget.onComplete();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
            SizedBox(height: 130),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Mama Care',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}