// profile.dart
import 'package:coffee/widget/botnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF5EE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEF5EE),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Allow back navigation
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
      bottomNavigationBar: Botnavbar(
        ItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/home");
              break;
            case 1:
              Navigator.pushNamed(context, '/predict');
              break;
            case 2:
              break;
          }
        },
        index: 2,
      ),
    );
  }
}
