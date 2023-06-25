import 'package:flutter/material.dart';
import 'package:prueba/components/no_account_text.dart';
import 'package:prueba/components/socal_card.dart';
import 'package:prueba/screens/home/home_screen.dart';
import 'package:prueba/screens/screensResidente/home_screenResidente.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Bienvenido de nuevo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Inicia Sesión con tu correo y contraseña",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(
                  onLoginSuccess: () {
                    //Navigator.pushNamed(context, HomeScreen.routeName);
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeResidente()));
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}