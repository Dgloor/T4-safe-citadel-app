import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key : key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  String _usuario = "";
  String _password= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 248, 248),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 90.0
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img/logo.png'),
                Divider(
                  height: 30.0,
                  color: Color.fromARGB(255, 250, 248, 248), 
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Usuario',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                  ),
                  onSubmitted: (valor){
                    _usuario = valor;
                    
                  },
                ),
                Divider(
                  height: 18.0,
                  color: Color.fromARGB(255, 250, 248, 248), 
                ),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                  ),
                  onSubmitted: (valor){
                    _password = valor;
                  },
                ),
                Divider(
                  height: 35.0,
                  color: Color.fromARGB(255, 250, 248, 248), 
                ),
                SizedBox(
                  child: TextButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Cambiar el color del botón
                    ),
                    onPressed: (){},
                    child: Text('Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}