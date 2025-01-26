import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const FirstScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
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
      backgroundColor: Color(0xFFA6CDC6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // Gunakan FadeTransition untuk animasi
            FadeTransition(
              opacity: _animation,
              child: Text(
                ' Welcome to Mama Care',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FadeTransition(
                opacity: _animation,
                child: Text(
                  'Mama Care hadir sebagai teman setia bagi para ibu hamil dan menyusui.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 7),

            FadeTransition(
              opacity: _animation,
              child: Text(
                'Click get started to learn more',
                style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 80),

            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/img/logo_first.png',
                height: 310,
                width: 310,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 100),

            FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 16,
                        
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8D77AB),
                      foregroundColor: Colors.white,
                      minimumSize: Size(170, 45),
                    ),
                    onPressed: () {
                      // Panggil onComplete sebelum navigasi
                      widget.onComplete();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
