import 'package:flutter/material.dart';
import 'package:prueba/screens/sign_in/sign_in_screen.dart';
import 'package:prueba/utils/Persistence.dart';

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
