import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/country_data.dart';
import 'package:whatsapp_clone/data/login_data.dart';
import 'otp_screen.dart'; // Import the OTP page

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  String selectedCountry = "India";
  String selectedCode = "+91";
  final TextEditingController phoneController = TextEditingController();

  void verifyPhoneNumber() {
    String phoneNumber = selectedCode + phoneController.text.trim();

    if (loginCredentials.containsKey(phoneNumber)) {
      String otp = loginCredentials[phoneNumber]!["otp"]!;
      // Navigate to OTP Verification Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationPage(
            phoneNumber: phoneNumber,
            otp: otp,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Verification Failed"),
          content: Text("The phone number entered is not registered."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Retry"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Icon
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Verify your phone number',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              // Subtitle
              const Center(
                child: Text(
                  'WhatsApp will need to verify your phone number. Carrier charges may apply.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dropdown for Country
                  SizedBox(
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: selectedCountry,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCountry = value!;
                            selectedCode = countryData
                                .firstWhere((c) => c["name"] == value)["code"]!;
                          });
                        },
                        items: countryData.map<DropdownMenuItem<String>>((country) {
                          return DropdownMenuItem<String>(
                            value: country["name"],
                            child: Center(child: Text(country["name"]!)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Phone Number Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Country Code
                      SizedBox(
                        width: 50,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: selectedCode,
                            hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Phone Number
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Phone number",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // Next Button
              ElevatedButton(
                onPressed: verifyPhoneNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text(
                  'Next',
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
      ),
    );
  }
}
