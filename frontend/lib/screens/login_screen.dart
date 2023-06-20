import 'package:flutter/material.dart';
import 'screensResidente/home_screenResidente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba/utils/globals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///Variables globales
String _usuario = "";
String _password = "";

///Widget para espaciado
class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 30.0,
      color: Color.fromARGB(255, 250, 248, 248),
    );
  }
}

///Widget de botón para iniciar sesión con validación de campos
class _BtnSubmit extends StatelessWidget {
  const _BtnSubmit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.green), // Cambiar el color del botón
        ),
        onPressed: () {
          if (_usuario.isEmpty || _password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ingrese usuario y contraseña')));
          } else {
            _guardarData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeResidente()),
            );
          }
        },
        child:const Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

TextEditingController _textController = TextEditingController(text: "");
/**Controlador para guardar data de input usuario */

///Guardar el nombre de usuario en almacenamiento interno */
_guardarData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (_textController.text.isNotEmpty) {
    prefs.setString("nombre", _textController.text);
    nombreResidente = _textController.text;
  }
}

///WIDGET PRINCIPAL *****/
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 248),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/logo.png'),
              const _Divider(),
              /**Input de usuario */
              TextField(
                  controller: _textController,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Usuario',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      suffixIcon:const Icon(Icons.person)),
                  style: const TextStyle(fontSize: 14),
                  onSubmitted: (valor) {
                    _usuario = valor;
                  }),
              const _Divider(),
              /**Input de contraseña */
              TextField(
                enableInteractiveSelection: false,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                style:const TextStyle(fontSize: 14),
                onSubmitted: (valor) {
                  _password = valor;
                },
              ),
              _Divider(),
              _BtnSubmit(),
            ],
          )
        ],
      ),
    );
  }
}
