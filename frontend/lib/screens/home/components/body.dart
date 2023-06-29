import 'package:flutter/material.dart';

import '../../visitors/visitor_screen.dart';
import '/models/User.dart';
class Body extends StatefulWidget {
  const Body({super.key});


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
    return const SafeArea(
      child: VisitaScreen()
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: getProportionateScreenHeight(20)),
      //       HomeHeader(),
      //       SizedBox(height: getProportionateScreenWidth(10)),
      //       WelcomeBanner(),
      //       //Categories(),
      //       //SpecialOffers(),
      //       SizedBox(height: getProportionateScreenWidth(30)),
      //       SizedBox(height: getProportionateScreenWidth(30)),
      //     ],
      //   ),
      // ),
    );
  }
}
