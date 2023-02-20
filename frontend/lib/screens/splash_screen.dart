import 'package:flutter/material.dart';
import 'package:prueba/screens/login_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key : key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }
  
  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[ 
              Image.asset('assets/img/logo.png'),
              Text(
                "SafeCitadel",
                style: Theme.of(context).textTheme.titleLarge
              )
            ],
          )
        ),
    );
  }
}