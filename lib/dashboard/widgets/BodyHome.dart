import 'dart:async';
import 'package:flutter/material.dart';
import 'CardVideo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MamaCare/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MamaCare/dashboard/widgets/CardArticle.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyHome extends StatefulWidget {
  final UserModel user;

  const BodyHome({Key? key, required this.user}) : super(key: key);

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.group_outlined, 'label': 'Komunitas'},
    {'icon': Icons.book, 'label': 'Artikel'},
    {'icon': Icons.child_care_outlined, 'label': 'Chatbot'},
    {'icon': Icons.local_hospital_rounded, 'label': 'RS terdekat'},
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
        vsync: this, duration: const Duration(milliseconds: 300));

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
        backgroundColor: Color(0xFFA6CDC6),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            height: 930,
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
                  Container(
                    height: 97,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (features[index]['label'] == 'Chatbot') {
                              Navigator.pushNamed(context, '/chatbot',
                                  arguments: widget.user);
                            }

                            if (features[index]['label'] == 'Artikel') {
                              Navigator.pushNamed(context, '/artikel');
                            }
                            if (features[index]['label'] == 'Komunitas') {
                              Navigator.pushNamed(context, '/komunitas',
                                  arguments: widget.user);
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

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Popular Video',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Fredoka',
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/video');
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Fredoka',
                                  color: Color(0xFF16404D),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CardVideo(
                                  description:
                                      "Cara menyusui yang baik dan benar! dr. Nisa Uswatun Karimah",
                                  views: "24k Views",
                                  image:
                                      "assets/img/tutorial-cara-menyusui.jpg",
                                  url: "rX5hfhGJ6KU",
                                ),
                                SizedBox(width: 12),
                                CardVideo(
                                  description:
                                      "Tips Menyusui Tanpa Rasa Nyeri Seri Edukasi Eka Hospital",
                                  views: "399k Views",
                                  image:
                                      "assets/img/tutorial-tanpa-rasa-sakit.jpg",
                                  url: "NRNeVXIXWIU",
                                ),
                                SizedBox(width: 12),
                                CardVideo(
                                  description:
                                      "Tips Cerdas Memperbanyak ASI Pada Ibu Menyusui",
                                  views: "399k Views",
                                  image:
                                      "assets/img/tutorial-memperbanyak-asi.jpg",
                                  url: "goipat4h6bY",
                                ),
                                SizedBox(width: 12),
                                CardVideo(
                                  description:
                                      "Cara ASI Diproduksi - Animasi Dolewak",
                                  views: "399k Views",
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
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "New Article",
                          style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Text("See All"))
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        CardArticle(
                          image: "assets/img/coping_with_breastfeeding.png",
                          title: "Ibu Hamil Muda Emosional",
                          description:
                              "Ibu hamil muda umumnya mudah mengalami perubahan suasana hati",
                          author: "dr. Kevin Adrian",
                          source: "Alodokter",
                          onTap: () async {
                            final Uri url = Uri.parse(
                                "https://www.alodokter.com/alasan-ibu-hamil-muda-emosional-dan-cara-mengatasinya");
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Could not launch $url')),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CardArticle(
                          image: "assets/img/sesak-hamil.jpg",
                          title:
                              "Mengatasi Sesak Napas",
                          description: "Sesak napas menjadi keluhan yang sering dialami ibu hamil.",
                          author: "dr. Kevin Adrian",
                          source: "Alodokter",
                          onTap: () async {
                            final Uri url = Uri.parse(
                                "https://www.alodokter.com/cara-mengatasi-sesak-napas-pada-ibu-hamil-saat-tidur");

                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Could not launch $url')),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CardArticle(
                          image: "assets/img/cnn.jpeg",
                          title: "Judul",
                          description: "Deskripsi",
                          author: "Author",
                          source: "Alodokter",
                          onTap: () async {
                            final Uri url = Uri.parse(
                                "https://www.alodokter.com/yuk-ketahui-fakta-di-balik-buah-yang-dilarang-untuk-ibu-hamil");
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Could not launch $url')),
                              );
                            }
                          },
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xFFA6CDC6),
            border: Border(
              top: BorderSide(
                color: Color(0xFF16404D), // Warna border
                width: 1, // Ketebalan border
              ),
            ),
          ),
          child: BottomNavigationBar(
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
            backgroundColor: Color(0xFFA6CDC6),
            selectedItemColor: Colors.grey.shade100,
            unselectedItemColor: Color(0xFF181C14),
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
                  Navigator.pushNamed(context, '/komunitas',
                      arguments: widget.user);
                  break;
                case 1:
                  // Chatbot
                  Navigator.pushNamed(context, '/chatbot',
                      arguments: widget.user);
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
        ));
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
      padding: EdgeInsets.only(right: 30, top: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 73, 150, 154),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 67,
            height: 57,
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Fredoka',
            ),
          ),
        ],
      ),
    );
  }
}
