// history.dart
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFEFE),
        title: Text('History'),
        automaticallyImplyLeading: true, // Allow back navigation
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Belum di buat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Detail data nanti ketampil disini.'),
          ],
        ),
      ),
    );
  }
}
