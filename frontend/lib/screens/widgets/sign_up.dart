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
    return Expanded(
      flex:1,
      // padding: EdgeInsets.only(top: 30.0),
        child:Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                color: Colors.white,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  height: 480.00,
                  child: Column(
                    children: <Widget>[ 
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusName,
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "SignikaSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Enter name",
                              hintStyle: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 18.0)),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusEmail,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "SignikaSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Enter email",
                              hintStyle: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 18.0)),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusPassword,
                          controller: passwordController,
                          style: TextStyle(
                              fontFamily: "SignikaSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Enter password",
                              hintStyle: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 18.0)),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusPassword,
                          controller: passwordController,
                          style: TextStyle(
                              fontFamily: "SignikaSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Confirm password",
                              hintStyle: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 18.0)),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppColours.colorStart,
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 20.0),
                              BoxShadow(
                                  color: AppColours.colorEnd,
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 20.0),
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  AppColours.colorEnd,
                                  AppColours.colorStart
                                ],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.1, 1.0],
                                tileMode: TileMode.clamp)),
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: AppColours.colorEnd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  color: Colors.white,
                                  fontSize: 22.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.white10,
                    Colors.white,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: 100.0,
            height: 1.0,
          ),
        
         
    
        ],
      ),
     ) ;
  }
}