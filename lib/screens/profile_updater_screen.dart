import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/data/category_data.dart';
import 'package:whatsapp_clone/screens/loading_screen.dart';

class ProfileUpdater extends StatefulWidget {
  final String phoneNumber;

  const ProfileUpdater({super.key, required this.phoneNumber});

  @override
  State<ProfileUpdater> createState() => _ProfileUpdaterState();
}

class _ProfileUpdaterState extends State<ProfileUpdater> {
  final TextEditingController businessNameController = TextEditingController();
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load data specific to the logged-in phone number
      businessNameController.text = prefs.getString('${widget.phoneNumber}_businessName') ?? '';
      selectedCategory = prefs.getString('${widget.phoneNumber}_category');
    });
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save data specific to the logged-in phone number
    await prefs.setString('${widget.phoneNumber}_businessName', businessNameController.text.trim());
    if (selectedCategory != null) {
      await prefs.setString('${widget.phoneNumber}_category', selectedCategory!);
    }

    // Set isLoggedIn flag to true
    await prefs.setBool('isLoggedIn', true);

    // Navigate to LoadingScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Create your business profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 65, 155, 69),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Help your customers learn about your business',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
              const SizedBox(height: 20),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    color: Colors.grey[600],
                    size: 25,
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 86,
                    child: TextField(
                      controller: businessNameController,
                      decoration: const InputDecoration(
                        hintText: 'Business name',
                        contentPadding: EdgeInsets.only(bottom: 2),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.category_outlined,
                    color: Colors.grey[600],
                    size: 25,
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(),
                        ),
                      );
                      if (result != null && result is String) {
                        setState(() {
                          selectedCategory = result;
                        });
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text(
                        selectedCategory ?? 'Category',
                        style: TextStyle(
                          color: selectedCategory == null
                              ? Colors.grey[600]
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Colors.grey[600],
                    size: 25,
                  ),
                ],
              ),
              const Spacer(),
              // Next Button
              ElevatedButton(
                onPressed: saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(110, 45),
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
