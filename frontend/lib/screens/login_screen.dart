import 'package:flutter/material.dart';
import 'screensResidente/home_screenResidente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba/utils/environment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///Variables
String _usuario = "";
String _password = "";
TextEditingController _userController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
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

bool isLoading = false;
late SharedPreferences prefs;
void initSharedPref() async {
  prefs = await SharedPreferences.getInstance();
}

///Widget de botón para iniciar sesión con validación de campos
class _BtnSubmit extends StatelessWidget {
  _BtnSubmit({Key? key, required this.context}) : super(key: key);
  final BuildContext context;

  void _loginUser() async {
    if (_userController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      var reqBody = {
        "username": _userController.text,
        "password": _passwordController.text
      };
      var response = await http.post(Uri.parse(postLogin),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var token = jsonResponse['token'];
        var refreshToken = jsonResponse['refresh_token'];
        prefs.setString('token', token);
        prefs.setString('refresh_token', refreshToken);
        isLoading = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeResidente(token: token)));
      } else {
        print('Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.green), // Cambiar el color del botón
        ),
        onPressed: () {
          /*if (_usuario.isEmpty || _password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ingrese usuario y contraseña')));
          } else {*/
          initSharedPref();
          _loginUser();
          // }
        },
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
      ),
    );
  }
}



///WIDGET PRINCIPAL *****/
class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = false;
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
                controller: _userController,
                enableInteractiveSelection: false,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Usuario',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: const Icon(Icons.person)),
                style: const TextStyle(fontSize: 14),
              ),
              const _Divider(),
              /**Input de contraseña */
              TextField(
                controller: _passwordController,
                enableInteractiveSelection: false,
                obscureText: !passToggle,
                decoration: InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: const Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: (){
                        setState((){
                          passToggle = !passToggle;
                          setState((){
                            
                          });
                        });
                      },
                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                    )),
                    
                style: const TextStyle(fontSize: 14),
              ),
              _Divider(),
              _BtnSubmit(context: context),
            ],
          )
        ],
      ),
    );
  }
}
