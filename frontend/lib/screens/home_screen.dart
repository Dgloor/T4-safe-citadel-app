import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[ 
              Text(
                "Home ",
                style: Theme.of(context).textTheme.titleLarge
              )
            ],
          )
        ),
    );
  }
}