import 'package:flutter/material.dart';
import 'package:safecitadel/components/coustom_bottom_nav_bar.dart';
import 'package:safecitadel/enums.dart';

import '../../size_config.dart';
import 'components/body.dart';
class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
