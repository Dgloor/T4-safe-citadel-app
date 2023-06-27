import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:prueba/constants.dart';
import 'package:http/http.dart' as http;
import 'package:prueba/utils/Information.dart';
import '../../../utils/Persistence.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}


TextEditingController nombreVisitacontroller = TextEditingController();
DateTime fechaVisita = DateTime.now();
const List<Widget> opcionesDias = <Widget>[Text('Hoy'), Text('Mañana')];
class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  int _value = 0;
  
  final List<bool> _selectedDay = <bool>[true, false];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 60.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nueva Visita',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 30.0),
                TextField(
                  key : Key("visitorNameField"),
                  controller: nombreVisitacontroller,
                  decoration: InputDecoration(
                      hintText: 'Nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30.0),
                /**Elección de día de visita */
                Text(
                  'Día de visita',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
               ToggleButtons(
                key : Key("selectedDay"),
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedDay.length; i++) {
                      _selectedDay[i] = i == index;
                    }
                    _value = index;
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: const Color.fromARGB(255, 31, 89, 42),
                selectedColor: Colors.white,
                fillColor: Colors.green,
                color: Colors.black,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 160.0,
                ),
                isSelected: _selectedDay,
                children: opcionesDias
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Seleccionar hora esperada',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                /**Selección de hora */
                CupertinoButton(
                  color: Colors.green,
                  child: Text('${fechaVisita.hour}:${fechaVisita.minute}'),
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => SizedBox(
                              height: 250,
                              child: SizedBox(
                                child: CupertinoDatePicker(
                                  key : Key("selectedTime"),
                                  initialDateTime: fechaVisita,
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (dateTime) =>
                                      setState(() {
                                    fechaVisita = dateTime;
                                  }),
                                ),
                              ),
                            ));
                  }),
                SizedBox(height: 16.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
                    key : Key("registerVisitButton"),
                    onPressed: () {
                      if (nombreVisitacontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ingrese nombre de la visita')));
                      }
                      else if(_value == 0 
                              && (fechaVisita.hour < DateTime.now().hour 
                              && fechaVisita.minute < DateTime.now().minute)){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Hora de visita no válida')));
                      } 
                      else {
                        DateTime fechaVisita = DateTime.now();
                        if(_value == 0){
                          setState((){
                            fechaVisita = DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day, fechaVisita.hour, fechaVisita.minute);                      
                          });
                          
                        }else if(_value == 1){
                          setState((){
                             fechaVisita = DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day+1, fechaVisita.hour, fechaVisita.minute);
                          });

                        }
                        _widgetQRCode(context);
                      }
                    },
                    child: Text('Registrar Visita'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future getTokenAndPostVisit() async {
  final apiClient = ApiGlobal.api;
  String _errorMessage = "";
   var reqParams = {
    "name": nombreVisitacontroller.text,
    "date": fechaVisita.toString(),
  };
  try {
    var qriID = await apiClient.postVisit(reqParams);
    await Future.delayed(Duration( seconds: 2));
    return qriID;
  } catch (error) {
    print('Error al obtener los datos del usuario: $error');
  }
}


_widgetQRCode(BuildContext context) async {
  String qrData = await getTokenAndPostVisit();
  showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 251, 250, 239),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Container(
          key: Key("qrCode"),
            height: 650,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QrImageView(
                      data: qrData,
                      size: 300.0,
                    )),
                const Text(
                  'Enviar código QR al visitante',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    //Share.share('');
                  },
                  child: const Text('Compartir'),
                ),
              ],
            ));
      });
      nombreVisitacontroller.text = "";
}
