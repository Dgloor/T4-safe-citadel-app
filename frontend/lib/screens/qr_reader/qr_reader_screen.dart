import 'package:flutter/material.dart';
import 'package:prueba/components/coustom_bottom_nav_bar.dart';
import 'package:prueba/enums.dart';

import 'components/body.dart';

class QRScreen extends StatelessWidget {
  static String routeName = "/qr_reader";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}