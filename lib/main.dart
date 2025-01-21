import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/screens/onboarding_screen.dart';
import 'package:whatsapp_clone/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: FutureBuilder<bool>(
        future: getLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading screen while waiting for the future to resolve
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle errors gracefully
            return Scaffold(
              body: Center(
                child: Text("An error occurred: ${snapshot.error}"),
              ),
            );
          } else {
            // Navigate based on login status
            final bool isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? HomeScreen() : OnboardingPage();
          }
        },
      ),
    );
  }
}

Future<bool> getLoginStatus() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  } catch (e) {
    print("Error retrieving login status: $e");
    return false; // Default to not logged in on error
  }
}
