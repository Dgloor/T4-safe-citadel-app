import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safecitadel/routes.dart';
import 'package:safecitadel/screens/splash/splash_screen.dart';
import 'package:safecitadel/theme.dart';
import '../../../utils/Persistencia.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) .then((_) 
  { runApp(const MyApp()); });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCitadel',
      theme: theme(),
      // home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

