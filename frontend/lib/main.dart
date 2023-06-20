import 'package:flutter/material.dart';
import 'package:prueba/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCitadel',
      home:const SplashScreen(),
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.green),
          titleMedium: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
