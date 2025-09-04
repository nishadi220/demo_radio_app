import 'package:flutter/material.dart';
import 'legalInfoScreen.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const termsContent = '''
These Terms and Conditions govern your use of our application and services. By using our app, you agree to comply with these terms.

1. Acceptance of Terms:
   - By accessing or using our services, you agree to be bound by these Terms and Conditions.

2. User Responsibilities:
   - You agree to use our services only for lawful purposes and in compliance with applicable laws.
   - You are responsible for maintaining the confidentiality of your account credentials.

3. Intellectual Property:
   - All content and materials within our application are the intellectual property of [App Name] and are protected by copyright laws.
   - You may not copy, distribute, or modify any content without prior written consent.

4. Limitation of Liability:
   - We are not liable for any direct, indirect, or incidental damages arising from your use of our services.
     
5. Termination of Use:
   - We reserve the right to terminate or suspend your access to the app at our sole discretion if you violate these terms.

6. Changes to Terms:
   - We may revise these Terms and Conditions at any time. Continued use of our app constitutes acceptance of the updated terms.

7. Governing Law:
   - These terms are governed by the laws of [Country/State]. Any disputes will be resolved in the courts of [Jurisdiction].

For questions or concerns, please contact us at support@app.com.''';

    return const LegalInfoScreen(
      title: 'Terms and Conditions',
      content: termsContent,
    );
  }
}
