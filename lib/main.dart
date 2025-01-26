import 'package:flutter/material.dart';
import 'package:MamaCare/auth/screens/LoginScreen.dart';
import 'package:MamaCare/screens/FirstScreen.dart';
import 'package:MamaCare/auth/screens/RegisterScreen.dart';
import 'package:MamaCare/dashboard/screens/HomeScreen.dart';
import 'package:MamaCare/dashboard/features/screens/ChatbotScreen.dart';
import 'package:MamaCare/dashboard/features/screens/PanduanMenyusui.dart';
import 'package:MamaCare/dashboard/features/screens/Profile.dart';
import 'package:MamaCare/dashboard/features/screens/Faq.dart';
import 'package:MamaCare/dashboard/features/screens/Artikel.dart';
import 'package:MamaCare/dashboard/features/screens/KomunitasScreen.dart';
import 'package:MamaCare/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MamaCare/auth/screens/OtpScreen.dart';
import 'package:MamaCare/auth/screens/ForgotPassScreen.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('is_first_time') ?? true;
  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  UserModel? _user;
  late bool _showFirstScreen;

  @override
  void initState() {
    super.initState();
    _showFirstScreen = widget.isFirstTime;
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (!_showFirstScreen) {
      await Future.delayed(Duration(seconds: 2)); // Loading screen duration
    }
    
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');
      String? userJson = prefs.getString('user_data');

      setState(() {
        if (token != null && token.isNotEmpty && userJson != null && userJson.isNotEmpty) {
          try {
            Map<String, dynamic> userMap = jsonDecode(userJson);
            _user = UserModel.fromJson(userMap);
            _isLoggedIn = true;
          } catch (jsonError) {
            print('Error parsing user JSON: $jsonError');
            prefs.remove('jwt_token');
            prefs.remove('user_data');
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      print('Error checking login status: $e');
      setState(() {
        _isLoading = false;
        _isLoggedIn = false;
      });
    }
  }

  Future<void> _markFirstTimeDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
    setState(() {
      _showFirstScreen = false;
    });
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Color(0xFFA6CDC6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo_first.png',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Color(0xFF16404D),
            ),
            SizedBox(height: 20),
            Text(
              'Memuat Mama Care...',
              style: TextStyle(
                color: Color(0xFF16404D),
                fontSize: 16,
                fontFamily: 'Fredoka',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mama Care',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Fredoka',
      ),
      home: _showFirstScreen
          ? FirstScreen(onComplete: _markFirstTimeDone)
          : _isLoading
              ? _buildLoadingScreen()
              : _isLoggedIn
                  ? HomeScreen(user: _user!)
                  : LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot-password': (context) => ForgotPassScreen(), 
        '/otp' : (context) => OtpScreen(),
        '/home': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as UserModel? ?? _user;
          return HomeScreen(user: user!);
        },
        '/chatbot': (context) => ChatbotScreen(),
        '/breastfeedingGuide': (context) => PanduanMenyusuiScreen(),
        '/profile': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as UserModel;
          return ProfileScreen(user: user);
        },
        '/faq': (context) => FAQScreen(),
        '/artikel': (context) => ArticleScreen(),
        '/komunitas': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as UserModel;
          return ChatKomunitasScreen(user: user);
        },
      },
    );
  }
}