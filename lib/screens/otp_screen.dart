import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'verify_screen.dart'; // Make sure this import exists
import 'profile_updater_screen.dart'; // Import the ProfileUpdater screen

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String otp;

  OtpVerificationPage({required this.phoneNumber, required this.otp});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // Creating a list of TextEditingControllers for each OTP input field
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  void verifyOtp() {
    String enteredOtp = otpControllers.map((controller) => controller.text).join();
    if (enteredOtp.trim() == widget.otp) {
      // OTP is correct, navigate to ProfileUpdater page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileUpdater()), // Navigate to ProfileUpdater()
      );
    } else {
      // OTP is incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Icon
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Title
            Text(
              'Verifying your number',
              style: TextStyle(
                fontSize: 25,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            // Subtitle
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                children: [
                  TextSpan(
                    text: 'Waiting to automatically detect an SMS sent to ',
                  ),
                  TextSpan(
                    text: widget.phoneNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '. ',
                  ),
                  TextSpan(
                    text: 'Wrong number?',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyPage()),
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 6-Digit OTP Entry
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: otpControllers[index], // Bind each controller to the TextField
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "-",
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(167, 56, 142, 60),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      counterText: "",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    onChanged: (value) {
                      // Move to the next or previous TextField as needed
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter 6-digit code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 25),
                        Text(
                          'Resend SMS',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(123, 189, 189, 189),
                      thickness: 1,
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 25),
                        Text(
                          'Call me',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Verify Button
            ElevatedButton(
              onPressed: verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: const Text(
                'Verify',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
