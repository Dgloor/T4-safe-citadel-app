import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import '/models/User.dart';
import 'package:prueba/utils/Information.dart';

class Body extends StatefulWidget {
  final String text;

  Body({required this.text});
  @override
  _Body createState() => _Body(text:text);
}

class _Body extends State<Body> {
  User? user;
  String text;
  _Body({required this.text});
  @override
  void initState() {
    super.initState();
    getTokenAndFetchUserData();
  }

  void getTokenAndFetchUserData() async {
  String token = text;
  print(token);
  try {
    User userData = await Api.getUserData(token);
    UserSingleton.user = userData;
    setState(() {
      user = userData;
    });
  } catch (error) {
    print('Error al obtener los datos del usuario: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            WelcomeBanner(),
            //Categories(),
            //SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
