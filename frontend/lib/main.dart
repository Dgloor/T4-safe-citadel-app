import 'package:flutter/material.dart';
import 'package:prueba/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCitadel',
      home: SplashScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.green),
          titleMedium: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
