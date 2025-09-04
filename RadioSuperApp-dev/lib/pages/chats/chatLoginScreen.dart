import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/models/radio/entities/stationEntity.dart';
import 'package:radio_super_app/router/wrappers/ChatScreenArgs.dart';
import '../../components/button.dart';
import '../../models/chat/requests/insertUserRequest.dart';
import '../../router/appRoutes.dart';
import '../../services/chatLoginService.dart'; // Import the ContinueButton component

class ChatLoginScreen extends StatefulWidget {
  final ChatScreenArgs chatScreenArgs;

  const ChatLoginScreen({
    super.key,
    required this.chatScreenArgs
  });

  @override
  State<ChatLoginScreen> createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ChatLoginService _chatLoginService = ChatLoginService();
  bool _isSubmitting = false;

  Future<void> _submitData() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      _showErrorDialog("Name and phone number are required.");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {

      InsertUserRequest insertUserRequest;
      await SharedPreferencesManager().getDeviceId().then((value) {
        insertUserRequest = InsertUserRequest(
          guestId: value,
          phone: phone,
          name: name,
          companyId: 'COM001',
          description: 'test',
          languageId: 1,
          email: email.isEmpty ? null : email,
          password: 'test',
          picUrl: 'test',
          userTypeId: 1,
          keyPara: '',
          countryId: 1,
          districtId: 1,
          townId: 1,
          address: 'Colombo',
        );

        _chatLoginService.insertUser(insertUserRequest: insertUserRequest).then((value) {
          print("USERID : ${value}");
          if (value != null) {
            // Save USERID
            SharedPreferencesManager().setUserId(value);
          }

          GoRouter.of(context).push(AppRoutes.chatOtp, extra: widget.chatScreenArgs);
        });
      });

    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4360AA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4360AA), // Blue at 8%
                  Color(0xFF91B7F6), // Purple at 46%
                  Color(0xFFD55774), // Pink at 100%
                ],
                stops: [0.10, 0.60, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${widget.chatScreenArgs.stationEntity.name}\nLog In to chat with host',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Input Fields
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Optional text
                const Center(
                  child: Text(
                    'optional',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Spacer(), // This spacer will push the button to the bottom
                // Using the ContinueButton
                Button(
                  onPressed: () {
                    _submitData();
                  },
                  buttonText: 'Continue', // Custom button text
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
