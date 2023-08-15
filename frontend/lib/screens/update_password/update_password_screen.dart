import 'package:flutter/material.dart';

import 'components/body.dart';

class UpdatePasswordScreen extends StatelessWidget {
  static String routeName = "/update_password";

  const UpdatePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambiar la contraseña"),
      ),
      body: Body(),
    );
  }
}
