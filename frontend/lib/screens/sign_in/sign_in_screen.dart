import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:prueba/utils/Authorization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar Sesión"),
      ),
      body: Body(),
    );
  }
}
