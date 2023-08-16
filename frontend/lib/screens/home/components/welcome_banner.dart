import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'package:safecitadel/models/User.dart';

import '../../../utils/Persistence.dart';
class WelcomeBanner extends StatefulWidget {
  const WelcomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeBanner> createState() => _WelcomeBannerState();
}

class _WelcomeBannerState extends State<WelcomeBanner> {
  String residentName = "";
  final apiClient = ApiGlobal.api;
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }
  Future<void> _loadUserName() async {
    try {
      String name = await apiClient.getName();
      setState(() {
        residentName = name;
      });
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF007F5F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            const TextSpan(text: "Bienvenido,\n"),
            TextSpan(
              text: residentName,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
