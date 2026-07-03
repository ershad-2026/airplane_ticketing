import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: const [

            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Md Ershad",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text("ershad@gmail.com"),

            SizedBox(height: 10),

            Text("+968 XXXXXXXX"),
          ],
        ),
      ),
    );
  }
}