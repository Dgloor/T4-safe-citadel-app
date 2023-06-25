import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import '/models/User.dart';
import 'package:prueba/utils/Information.dart';
import '../../../utils/persistencia.dart';
class Body extends StatefulWidget {

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  User? user;
  _Body();
  @override
  void initState() {
    super.initState();
    getTokenAndFetchUserData();
  }

  void getTokenAndFetchUserData() async {
  SharedPreferencesUtil prefs = await SharedPreferencesUtil.getInstance();
  String token = prefs.getToken();
  print('Token: $token');
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
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
