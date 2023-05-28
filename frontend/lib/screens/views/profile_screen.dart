import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/model/user.dart';
import 'package:prueba/screens/widgets/button_widget.dart';
import 'package:prueba/screens/widgets/numbers_widget.dart';
import 'package:prueba/screens/widgets/picture_widget.dart';
import 'package:prueba/screens/widgets/appbar_widget.dart';
import 'package:prueba/screens/util/user_preferences.dart';
import 'package:prueba/screens/widgets/sign_up.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      // appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          PictureWidget(
                    imagePath: user.imagePath,
                    onClicked: () async {},
          ),
          const SizedBox(height: 24),
          // buildName(user),
          // const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          // const SizedBox(height: 24),
          // NumbersWidget(),
          // const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: SignUpWidget(),
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}