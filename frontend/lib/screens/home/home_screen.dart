import 'package:flutter/material.dart';
import 'package:prueba/components/coustom_bottom_nav_bar.dart';
import 'package:prueba/enums.dart';

import '../../size_config.dart';
import 'components/body.dart';
import '/models/User.dart';
import 'package:prueba/utils/Information.dart';
class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
   String token ;

  HomeScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    const String p="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODc2NTc5NzEsImlhdCI6MTY4NzY1NzY3MSwic3ViIjoiNTkzOTFkOWMtMDVhOC00MWQxLWFmNmUtNzAyODc1MTMzYzdkIn0.mdFb7A7TATf2uAujbWGSxWfbfD8Yrf0381hFxGZS4qs";
    print(token);
     SizeConfig().init(context);
    return Scaffold(
      body: Body(text:p),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
