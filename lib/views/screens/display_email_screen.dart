import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wilfredemail/models/generated_email_response_model.dart';

import '../../utils/constants.dart';
import '../widgets/bottom_navbar_widget.dart';

class DisplayEmailScreen extends StatelessWidget {
  final Payload generatedEmail;

  const DisplayEmailScreen({Key? key, required this.generatedEmail})
      : super(key: key);

  static const _headingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: greenMainColor2,
  );

  static const _contentStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(213, 225, 218, 1),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarWidget(),
        appBar: AppBar(
          title: const Text("Announcement Email"),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            launchEmailApp(
              generatedEmail.toEmailId,
              "",
              generatedEmail.subject,
              generatedEmail.generatedEmail,
            );
          },
          backgroundColor: greenMainColor2,
          child: const Icon(Icons.email_rounded, color: Colors.black, size: 35),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //To Email Heading
                const Text("To:", style: _headingStyle),

                //To Email Content
                Text(generatedEmail.toEmailId, style: _contentStyle),

                // const SizedBox(height: 15),

                // //From Email Heading
                // const Text("From:", style: _headingStyle),
                //
                // //From Email Content
                // const Text("xyz@example.com", style: _contentStyle),

                const SizedBox(height: 15),

                //Subject Heading
                const Text("Subject:", style: _headingStyle),

                //Subject Content
                Text(generatedEmail.subject, style: _contentStyle),

                const SizedBox(height: 15),

                //Keywords Heading
                const Text("Keywords:", style: _headingStyle),

                //Keywords Content
                Text(generatedEmail.keywords, style: _contentStyle),

                const SizedBox(height: 15),

                //Generated Email Heading
                const Text("Generated Email:", style: _headingStyle),

                //Generated Email Content
                Text(generatedEmail.generatedEmail, style: _contentStyle),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchEmailApp(to, from, subject, body) async {
    final url = Uri.parse(
        'mailto:$to?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}');

    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }
}
