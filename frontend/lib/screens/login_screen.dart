import 'package:flutter/material.dart';
import 'screensResidente/home_screenResidente.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key : key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _Divider extends StatelessWidget{
  const _Divider({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
  return Divider(
                  height: 30.0,
                  color: Color.fromARGB(255, 250, 248, 248), 
                );
  }
}

class _BtnSubmit extends StatelessWidget{
  const _BtnSubmit({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
  return SizedBox(
                  child: TextButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Cambiar el color del botón
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreenResidente()),
                      );
                    },
                    child: Text('Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                  ),
                );
  }
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
                _Divider(),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Usuario',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                  ),
                  onSubmitted: (valor){
                    _usuario = valor;
                    
                  }),
                _Divider(),
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
                _Divider(),
                _BtnSubmit(),
              ],
            )
          ],
        ),
    );
  }
}