import 'package:flutter/material.dart';

import 'components/body.dart';

class VisitaScreen extends StatelessWidget {
  const VisitaScreen({super.key});

  //static String routeName = "/register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Visitas"),
      ),
      body: const Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
