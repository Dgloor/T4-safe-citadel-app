import 'package:flutter/material.dart';
import 'package:safecitadel/components/coustom_bottom_nav_bar.dart';
import 'package:safecitadel/enums.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";

  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Visitas"),
      ),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
