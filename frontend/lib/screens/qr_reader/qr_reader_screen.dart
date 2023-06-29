import 'package:flutter/material.dart';
import 'package:safecitadel/components/coustom_bottom_nav_bar.dart';
import 'package:safecitadel/enums.dart';

import 'components/body.dart';

class QRScreen extends StatelessWidget {
  static String routeName = "/qr_reader";

  const QRScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}