import 'package:flutter/material.dart';
import 'legalInfoScreen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const privacyPolicyContent = '''
We value your privacy. This policy outlines how we collect, use, and protect your personal information.

1. Information Collection:
   - We may collect personal information such as 
     your name, email address, phone number, and
     device details.
   - Information is collected when you create an
    account, use our services, or interact with us.

2. Use of Information:
   - The information collected is used to:
       - Provide, improve, and personalize our services.
       - Respond to inquiries or customer service requests.
       - Send notifications, updates, or promotional content (with your consent).

3. Data Security:
   - We implement appropriate technical and organizational measures to protect your personal information from unauthorized access, disclosure, or destruction.
   - While we strive to safeguard your data, no method of transmission or storage is 100% secure.

4. Third-Party Sharing:
   - Your personal information will not be shared with third parties without your explicit consent, except:
       - When required by law or legal process.
       - To trusted third parties providing services on our behalf, under confidentiality agreements.
     
5. Your Rights:
   - You have the right to access, update, or delete your personal information. To exercise these rights, contact us at privacy@app.com.

5. Changes to Privacy Policy:
   - We may update this Privacy Policy periodically. Any changes will be posted on this page, and we encourage you to review it regularly.

By using our services, you consent to the terms outlined in this Privacy Policy.''';

    return const LegalInfoScreen(
      title: 'Privacy Policy',
      content: privacyPolicyContent,
    );
  }
}
