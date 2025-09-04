import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:radio_super_app/models/chat/entity/chatMessage.dart';
import 'package:radio_super_app/router/wrappers/ChatScreenArgs.dart';

import '../../managers/sharedPreferencesManager.dart';
import '../../models/chat/requests/insertChatRequest.dart';
import '../../services/chatLoginService.dart';

class ChatScreen extends StatefulWidget {
  final ChatScreenArgs chatScreenArgs;

  const ChatScreen({super.key, required this.chatScreenArgs});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? _timer;
  List<ChatMessage> _messages = [];
  String currentUserId = '';
  final TextEditingController _controller = TextEditingController();
  final ChatLoginService _chatLoginService = ChatLoginService();

  @override
  void initState() {
    super.initState();
    _fetchChatMessages();
    _startFetchingMessages();
  }

  void _startFetchingMessages() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      _fetchChatMessages();
    });
  }

  Future<void> _fetchChatMessages() async {
    try {
      final userId = await SharedPreferencesManager().getUserId();
      setState(() {
        currentUserId = userId;
      });

      final showId = widget.chatScreenArgs.currentShow.id;
      final chatData = await _chatLoginService.getChatByShowId(showId);

      setState(() {
        _messages = chatData;
      });
    } catch (error) {
      debugPrint("Error fetching chat messages: $error");
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final messageText = _controller.text.trim();
    final newMessage = ChatMessage(
      showId: widget.chatScreenArgs.currentShow.id,
      name: "Me", // Change to actual user's name if available
      userId: currentUserId,
      userTypeId: "1", // Replace with actual user type ID if available
      message: messageText,
      createDateTime: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, newMessage);
    });

    _controller.clear();

    try {
      final chatRequest = InsertChatRequest(
        userId: currentUserId,
        showId: widget.chatScreenArgs.currentShow.id,
        message: messageText,
      );
      await _chatLoginService.insertChat(chatRequest: chatRequest);

      // Refresh messages from server
      await _fetchChatMessages();
    } catch (error) {
      debugPrint("Error sending message: $error");
    }
  }

  String formatDateTime(String createDateTime) {
    final dateTime = DateTime.parse(createDateTime);
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat.jm().format(dateTime);
    } else {
      return DateFormat('dd MMM yyyy').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFEFD),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.chatScreenArgs.stationEntity.picUrl ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatScreenArgs.currentShow.showName ?? "",
                  style: const TextStyle(
                    color: Color(0xFF476D79),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.chatScreenArgs.currentShow.hostName ?? "",
                  style: const TextStyle(
                    color: Color(0xFF476D79),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            while (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFCFEFD),
                  Color(0xFFB2D7E7),
                  Color(0xFF6A9FB1),
                ],
                stops: [0.0, 0.49, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isMe = message.userId == currentUserId;
                      return Align(
                        alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[200] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                message.message,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formatDateTime(
                                    message.createDateTime.toString()),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
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
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
