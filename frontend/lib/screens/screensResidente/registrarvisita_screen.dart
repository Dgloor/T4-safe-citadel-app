import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/screens/screensResidente/TimePicker.dart';
import 'package:prueba/screens/screensResidente/bottom_nav.dart';

class RegistrarVisita extends StatefulWidget {
  const RegistrarVisita({super.key});

  @override
  State<RegistrarVisita> createState() => _RegistrarVisitaState();
}

class _RegistrarVisitaState extends State<RegistrarVisita> {
  final _formKey = GlobalKey<FormState>();
  String ?_name;
  String ?_email;
  bool _showConfirmation = false;
  int _value = 0;
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nueva Visita',
                style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,),
                  SizedBox(height: 30.0),
                TextField(
                  
                  decoration: InputDecoration(
                    hintText: 'Nombre del visitante',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                  ),
                   style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30.0),
                /**Elección de día de visita */
                Text('Día de visita',
                style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,), 
                Row(children: [Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value){
                    setState(() {
                      _value = value as int;
                    });
                  },
                ),
                Text('Hoy')
                ],),
                Row(children: [Radio(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value){
                    setState(() {
                      _value = value as int;
                    });
                  },
                ),
                Text('Mañana')
                ],),
                Text('Elegir hora',
                style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,), 
                  /**Selección de hora */
                CupertinoButton(
                  child: Text('${dateTime.hour}:${dateTime.minute}'), 
                  onPressed: (){
                    showCupertinoModalPopup(context: context,
                     builder: (BuildContext context) => SizedBox(
                      height: 250,
                      child: SizedBox(
                        child: CupertinoDatePicker(
                          initialDateTime: dateTime,
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (dateTime) =>
                          setState(() {
                            this.dateTime = dateTime;
                          }),
                                          ),
                      ),
                     ));
                  }
                ),
                SizedBox(height: 16.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
                    onPressed: () {  },
                    child: Text('Aceptar'),
                     style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Cambiar el color del botón
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                
                if (_showConfirmation)
                  Text(
                    'Gracias por enviar el formulario, $_name ($_email)',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
    
  }
