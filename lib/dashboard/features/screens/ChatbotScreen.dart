import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import '../services/api_chatbot.dart';
import '../models/chat_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:MamaCare/auth/models/user_model.dart';


class ChatbotScreen extends StatelessWidget {
  final UserModel? user;
  
  const ChatbotScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gunakan user dari konstruktor jika tersedia, jika tidak ambil dari route
    final UserModel currentUser = user ?? ModalRoute.of(context)?.settings.arguments as UserModel;
    
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(
        profilePicture: currentUser.profilePicture,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.profilePicture}) : super(key: key);
  final String profilePicture;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  List<ChatModel> _messages = [];
  bool _isLoading = false; // Variabel untuk status loading

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String prompt = _controller.text;
    _controller.clear();

    // Ambil waktu saat ini (hanya jam dan menit)
    String timestamp = DateFormat('HH:mm').format(DateTime.now().toLocal());

    setState(() {
      // Tambahkan pesan user ke daftar
      _messages
          .add(ChatModel(prompt: prompt, response: null, timestamp: timestamp));
      _isLoading = true; // Set loading menjadi true
    });

    try {
      // Kirim permintaan ke API dan dapatkan respon
      String response = await _apiService.sendMessage(prompt);
      setState(() {
        // Tambahkan pesan bot ke daftar
        _messages.add(
            ChatModel(prompt: null, response: response, timestamp: timestamp));
        _isLoading = false; // Set loading menjadi false
      });
    } catch (e) {
      setState(() {
        // Tambahkan pesan error dari bot
        _messages.add(ChatModel(
            prompt: null, response: 'Error: $e', timestamp: timestamp));
        _isLoading = false; // Set loading menjadi false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/img/chatbot.png'), // Foto robot
              radius: 20,
            ), // Logo robot
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chatbot',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka'),
                ),
                Text('Powered by Gemini AI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka',
                    ))
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length +
                  (_isLoading ? 1 : 0), // Tambahkan 1 untuk loading
              itemBuilder: (context, index) {
                if (_isLoading && index == _messages.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: LoadingAnimationWidget.waveDots(
                            color: Colors.pink.shade300,
                            size: 40, // Ukuran animasi lebih kecil
                          ),
                        ), // Animasi loading
                      ],
                    ),
                  );
                }

                final message = _messages[index];
                final isUser =
                    message.prompt != null; // Jika prompt ada, berarti user

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isUser)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0), // Tambahkan padding di kiri
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/img/chatbot.png'), // Foto robot
                          radius: 20,
                        ),
                      ),
                    if (!isUser) SizedBox(width: 2),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 12, right: 12, bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.pink[100] : Colors.orange[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isUser ? message.prompt! : message.response!,
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5), // Jarak antara pesan dan waktu
                            Align(
                              alignment: Alignment
                                  .bottomRight, // Posisikan di pojok kanan bawah
                              child: Text(
                                message.timestamp, // Tampilkan timestamp
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isUser) SizedBox(width: 2),
                    if (isUser)
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0), // Tambahkan padding di kiri
                        child: CircleAvatar(
                          backgroundImage: widget.profilePicture.isNotEmpty ? NetworkImage(widget.profilePicture) : AssetImage('assets/img/LogoMamaCare.png'),
                          radius: 20,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Mengatur sudut rounded
                        borderSide: BorderSide(
                          color: Colors
                              .pink, // Ganti dengan warna border yang diinginkan
                          width: 2.0, // Lebar border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Sudut rounded saat fokus
                        borderSide: BorderSide(
                          color: Colors
                              .grey, // Ganti dengan warna border saat fokus
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Sudut rounded saat tidak fokus
                        borderSide: BorderSide(
                          color: Colors
                              .black, // Ganti dengan warna border saat tidak fokus
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
