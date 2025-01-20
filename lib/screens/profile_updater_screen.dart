import 'package:flutter/material.dart';

class ProfileUpdater extends StatefulWidget {
  const ProfileUpdater({super.key});

  @override
  State<ProfileUpdater> createState() => _ProfileUpdaterState();
}

class _ProfileUpdaterState extends State<ProfileUpdater> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16,60,16,16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Create your buisness profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 65, 155, 69)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Help your customers learn about your buisness',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300]
                ),
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}