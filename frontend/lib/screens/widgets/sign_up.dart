import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba/screens/util/app_colurs.dart';


class SignUpWidget extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusName = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: 5,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const  InputDecoration(
                label: Text('Name'),
                prefixIcon: Icon(
                  Icons.person,
                  color:Colors.green,
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              )
            ),
              TextFormField(
              decoration: const  InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(
                  Icons.mail,
                  color:Colors.green,
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              )
            ),
              TextFormField(
              decoration: const  InputDecoration(
                label: Text('Phone'),
                prefixIcon: Icon(
                  Icons.phone,
                  color:Colors.green,
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              )
            )
          ],
        )
      )
    );
     

       
  }
}