import 'dart:async';
import 'package:flutter/material.dart';
import 'CardVideo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MamaCare/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyHome extends StatefulWidget {
  final UserModel user;

  const BodyHome({Key? key, required this.user}) : super(key: key);

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> with SingleTickerProviderStateMixin{
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.local_hospital, 'label': 'Panduan'},
    {'icon': Icons.help_outline, 'label': 'FAQ'},
    {'icon': Icons.person, 'label': 'Profil'},
    {'icon': Icons.group_outlined, 'label': 'Komunitas'},
    {'icon': Icons.book, 'label': 'Artikel'},
    {'icon': Icons.child_care_outlined, 'label': 'Chatbot'},
  ];

  final List<String> images = [
    "assets/img/gambar2.png",
    "assets/img/gambar1.png",
    "assets/img/gambar3.png",
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  int _selectedIndex = 0; 

  late AnimationController _animationController;

   @override
  void initState() {
    super.initState();
    
    // Inisialisasi PageController
    _pageController = PageController(initialPage: _currentPage);
    
    // Inisialisasi AnimationController dengan menggunakan late
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 300)
    );

    // Mulai timer
    _startTimer();
  }

   void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          if (_currentPage < images.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
        });
        
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose semua controller dan timer
    _pageController.dispose();
    _timer?.cancel();
    _animationController.dispose();
    
    super.dispose();
  }

  Future<void> _performLogout() async {
  try {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_data');
    
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout gagal: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCCE1),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slider Foto
              Container(
                height: 140,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      margin: EdgeInsets.only(top: 5),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Fredoka',
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (features[index]['label'] == 'Chatbot') {
                          Navigator.pushNamed(context, '/chatbot', arguments: widget.user);
                        }
                        if (features[index]['label'] == 'Panduan') {
                          Navigator.pushNamed(context, '/breastfeedingGuide');
                        }
                        if (features[index]['label'] == 'Profil') {
                          Navigator.pushNamed(context, '/profile', arguments: widget.user);
                        }
                        if (features[index]['label'] == 'FAQ') {
                          Navigator.pushNamed(context, '/faq');
                        }
                        if (features[index]['label'] == 'Artikel') {
                          Navigator.pushNamed(context, '/artikel');
                        }
                        if (features[index]['label'] == 'Komunitas') {
                          Navigator.pushNamed(context, '/komunitas', arguments: widget.user);
                        }
                      },
                      child: FeatureCard(
                        icon: features[index]['icon'],
                        label: features[index]['label'],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Fredoka',
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 195,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CardVideo(
                              description:
                                  "Cara menyusui yang baik dan benar! dr. Nisa Uswatun Karimah",
                              image: "assets/img/tutorial-cara-menyusui.jpg",
                              url: "rX5hfhGJ6KU",
                            ),
                            SizedBox(width: 10),
                            CardVideo(
                              description:
                                  "Tips Menyusui Tanpa Rasa Nyeri Seri Edukasi Eka Hospital",
                              image:
                                  "assets/img/tutorial-tanpa-rasa-sakit.jpg",
                              url: "NRNeVXIXWIU",
                            ),
                            SizedBox(width: 10),
                            CardVideo(
                              description:
                                  "Tips Cerdas Memperbanyak ASI Pada Ibu Menyusui",
                              image:
                                  "assets/img/tutorial-memperbanyak-asi.jpg",
                              url: "goipat4h6bY",
                            ),
                            SizedBox(width: 10),
                            CardVideo(
                              description:
                                  "Cara ASI Diproduksi - Animasi Dolewak",
                              image:
                                  "assets/img/bagaimana-asi-diproduksi.png",
                              url: "Vo1G-7CWZwM",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: 23),
            label: 'Komunitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care_outlined, size: 23),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.accusoft, size: 23),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined, size: 23),
            label: 'Logout',
          ),
        ],
        backgroundColor: Color(0xFFFFCCE1),
        selectedItemColor: Colors.grey.shade100,
        unselectedItemColor: Colors.grey.shade800,
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Fredoka',
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Fredoka',
        ),
        currentIndex: _selectedIndex, 
        onTap: (int index) async {
          setState(() {
            _selectedIndex = index; 
          });
          
          switch (index) {
            case 0:
              // Home
              Navigator.pushNamed(context, '/komunitas', arguments: widget.user); 
              break;
            case 1:
              // Chatbot
              Navigator.pushNamed(context, '/chatbot', arguments: widget.user);
              break;
            case 2:
              // Artikel
              Navigator.pushNamed(context, '/artikel');
              break;
            case 3:
              // Profil
              await _performLogout();
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF5D7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.pink.shade200,
          ),
          SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: 'Fredoka',
            ),
          ),
        ],
      ),
    );
  }
}
