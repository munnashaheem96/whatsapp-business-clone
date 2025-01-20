import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Business Clone',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: OnboardingPage(),
    );
  }
}

