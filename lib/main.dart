// main.dart
import 'package:coffee/controller/controller.dart';
import 'package:coffee/firebase_options.dart';
import 'package:coffee/screen/prediction_page.dart';
import 'package:coffee/screen/sign_screen.dart';
import 'package:coffee/screen/signup_screen.dart';
import 'package:coffee/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coffee/screen/home_screen.dart';
import 'package:coffee/screen/profile.dart'; // Import ProfileScreen
import 'package:coffee/screen/history.dart';
import 'package:provider/provider.dart'; //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skintone Prediction',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFD2A588),
        ),
      ),
      routes: {
        '/login': (context) => Login(),
        '/regis': (context) => Regis(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/predict': (context) => PredictionPage(),
        '/history': (context) => HistoryScreen(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
