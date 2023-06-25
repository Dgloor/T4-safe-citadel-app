import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba/screens/home/home_screen.dart';
import 'package:prueba/screens/profile/profile_screen.dart';
import 'package:prueba/screens/qr_reader/qr_reader_screen.dart';

import '../constants.dart';
import '../enums.dart';
import '../screens/register/register_screen.dart';
import 'package:prueba/models/User.dart'; 
class CustomBottomNavBar extends StatelessWidget {

  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              Visibility(
                visible: UserSingleton.isGUARD(),
                child: IconButton(
                icon: Icon(Icons.qr_code_scanner_rounded),
                onPressed:() =>
                    Navigator.pushNamed(context, QRScreen.routeName),
              ),)
              ,
              IconButton(
                icon: Icon(Icons.app_registration),
                onPressed:() =>
                    Navigator.pushNamed(context, RegisterScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
