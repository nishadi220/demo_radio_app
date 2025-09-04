import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/button.dart'; // Import the ContinueButton component

class ChatOTPScreen extends StatelessWidget {
  const ChatOTPScreen({super.key});

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
      body: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 68,
              width: 64,
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                onSaved: (pin1) {},
                decoration: const InputDecoration(hintText: "0"),
                style: Theme.of (context).textTheme.titleLarge,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(
              height: 64,
              width: 68,
              child: TextFormField(
                onSaved: (pin2) {},
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: const InputDecoration(hintText: "0"),
                style: Theme.of (context).textTheme.titleLarge,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(
              height: 68,
              width: 64,
              child: TextFormField(
                onSaved: (pin3) {},
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: const InputDecoration(hintText: "0"),
                style: Theme.of (context).textTheme.titleLarge,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(
              height: 68,
              width: 64,
              child: TextFormField(
                onSaved: (pin4) {},
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: const InputDecoration(hintText: "0"),
                style: Theme.of (context).textTheme.titleLarge,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            // Content
            // Using the ContinueButton at the bottom
            Positioned(
              bottom: 16, // Adjust this value as needed for padding from the bottom
              left: 16,
              right: 16,
              child: Button(
                onPressed: () {
                  // Add verification logic here
                  print('Verification button pressed!');
                },
                buttonText: 'Verify', // Custom button text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
