import 'package:flutter/material.dart';
import 'package:safecitadel/screens/sign_in/sign_in_screen.dart';
import 'package:safecitadel/screens/update_password/update_password_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/Persistence.dart';
import 'profile_menu.dart';


final apiClient = ApiGlobal.api;
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isGuard = false;
  @override
  void initState() {
    _loadisGuard();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Cambiar la contraseña",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, UpdatePasswordScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Manual de usuario",
            icon: "assets/icons/Question mark.svg",
            press: () {
              if(isGuard){
                _abrirManualUsuarioGuardia();
              }else{
                _abrirManualUsuarioResidente();
              }
            },
          ),
          ProfileMenu(
            text: "Cerrar Sesión",
            icon: "assets/icons/Log out.svg",
            press: () {
              final apiClient = ApiGlobal.api;
              apiClient.saveUser('', '');
              Navigator.pushNamed(context, SignInScreen.routeName);},
          ),
        ],
      ),
    );
  }


  Future<void> _loadisGuard() async {
    try {
      bool guard = await apiClient.isGuard();
      setState(() {
        isGuard = guard;
      });
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }
}

void _abrirManualUsuarioResidente() async {
  final Uri url = Uri.parse('https://drive.google.com/file/d/1dY-l6SIRUo4UhJQF13LLGf83Tfts8rFm/view?usp=sharing');
  if (!await launchUrl(url)) {
        throw Exception('No se pudo abrir');
  }
}
void _abrirManualUsuarioGuardia() async {
  final Uri url = Uri.parse('https://drive.google.com/file/d/1r_fpoMwHYh_fCkIE1YK_OQ29gTPEBc_i/view?usp=sharing');
  if (!await launchUrl(url)) {
        throw Exception('No se pudo abrir');
  }
}
