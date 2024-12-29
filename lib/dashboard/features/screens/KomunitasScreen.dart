import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:MamaCare/auth/models/user_model.dart';

class ChatKomunitasScreen extends StatefulWidget {
  final UserModel user;

  ChatKomunitasScreen({required this.user});

  @override
  _ChatKomunitasScreenState createState() => _ChatKomunitasScreenState();
}

class _ChatKomunitasScreenState extends State<ChatKomunitasScreen> {
  IO.Socket? socket;
  List<ChatModelKomunitas> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final int messageLimit = 15;

  @override
  void initState() {
    super.initState();
    connectToSocket();
    fetchMessages();
  }

  @override
  void dispose() {
    socket?.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void connectToSocket() {
    socket = IO.io(
      'https://mamacare-api-447228900001.asia-southeast2.run.app',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionAttempts': 10,
        'reconnectionDelay': 2000,
      },
    );

    socket?.onConnect((_) {
      print('Connected to socket server');
      fetchMessages(); // Fetch messages saat koneksi berhasil
    });

    socket?.on("updateMessages", (data) {
      if (!mounted) return;

      try {
        final newMessage = ChatModelKomunitas(
          content: data["content"],
          senderName: data["senderName"] ?? "Unknown",
          senderProfilePicture: data["senderProfilePicture"] ?? "",
          timestamp: data["timestamp"],
        );

        setState(() {
          messages.add(newMessage);
          if (messages.length > messageLimit) {
            messages.removeAt(0);
          }
        });

        // Scroll otomatis ke bawah
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } catch (e) {
        print("Error parsing message: $e");
      }
    });

    socket?.onReconnect((_) {
      print('Reconnected to socket server');
      fetchMessages(); // Fetch ulang pesan setelah reconnect
    });

    socket?.onDisconnect((_) {
      print("Disconnected from server");
    });

    socket?.onError((error) {
      print("Socket error: $error");
    });
  }

  Future<void> fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://mamacare-api-447228900001.asia-southeast2.run.app/api/auth/get-messages'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> messageList = json.decode(response.body);
        setState(() {
          messages = messageList
              .skip(messageList.length > messageLimit ? messageList.length - messageLimit : 0)
              .map((msg) => ChatModelKomunitas(
                    content: msg['content'],
                    senderName: msg['senderName'] ?? "Unknown",
                    senderProfilePicture: msg['senderProfilePicture'] ?? "",
                    timestamp: msg['timestamp'],
                  ))
              .toList();
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } else {
        print('Failed to load messages: ${response.body}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  void sendMessage(String content) async {
    if (content.isEmpty) return;

    final newMessage = ChatModelKomunitas(
      content: content,
      senderName: widget.user.name,
      senderProfilePicture: widget.user.profilePicture,
      timestamp: DateTime.now().toIso8601String(),
    );

    setState(() {
      messages.add(newMessage);
      if (messages.length > messageLimit) {
        messages.removeAt(0);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    final response = await http.post(
      Uri.parse(
          'https://mamacare-api-447228900001.asia-southeast2.run.app/api/auth/send-message'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'senderId': widget.user.id,
        'message': content,
      }),
    );

    if (response.statusCode == 201) {
      socket?.emit("newMessage", {
        "content": content,
        "senderName": widget.user.name,
        "senderProfilePicture": widget.user.profilePicture,
        "timestamp": DateTime.now().toIso8601String(),
      });
      _messageController.clear();
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade100,
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.group_outlined),
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Komunitas',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka'),
                ),
                Text('Komunitas Chat Online',
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
          Expanded(
            child: messages.isEmpty
                ? const Center(child: Text("No messages yet."))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUserMessage =
                          message.senderName == widget.user.name;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUserMessage)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 6),
                              child: CircleAvatar(
                                backgroundImage: message
                                        .senderProfilePicture.isNotEmpty
                                    ? NetworkImage(message.senderProfilePicture)
                                    : const AssetImage(
                                            'assets/img/LogoMamaCare.png')
                                        as ImageProvider,
                                radius: 20,
                              ),
                            ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isUserMessage
                                    ? Colors.pink[100]
                                    : Colors.orange[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.senderName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Fredoka',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    message.content,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Fredoka',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      message.timestamp,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isUserMessage)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0, top: 6),
                              child: CircleAvatar(
                                backgroundImage: message
                                        .senderProfilePicture.isNotEmpty
                                    ? NetworkImage(message.senderProfilePicture)
                                    : const AssetImage(
                                            'assets/img/LogoMamaCare.png')
                                        as ImageProvider,
                                radius: 20,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: () => sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatModelKomunitas {
  final String content;
  final String senderName;
  final String senderProfilePicture;
  final String timestamp;

  ChatModelKomunitas({
    required this.content,
    required this.senderName,
    required this.senderProfilePicture,
    required this.timestamp,
  });
}
