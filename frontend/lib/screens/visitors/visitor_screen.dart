import 'package:flutter/material.dart';
import 'package:prueba/components/coustom_bottom_nav_bar.dart';
import 'package:prueba/enums.dart';

import 'components/body.dart';

class VisitaScreen extends StatelessWidget {
  //static String routeName = "/register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Visitas"),
      ),
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
