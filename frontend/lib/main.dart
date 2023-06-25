import 'package:flutter/material.dart';
import 'package:prueba/routes.dart';
import 'package:prueba/screens/home/home_screen.dart';
import 'package:prueba/screens/profile/profile_screen.dart';
import 'package:prueba/screens/splash/splash_screen.dart';
import 'package:prueba/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCitadel',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
