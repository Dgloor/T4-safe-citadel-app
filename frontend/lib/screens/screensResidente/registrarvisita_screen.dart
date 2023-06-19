import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/screens/screensResidente/TimePicker.dart';
import 'package:prueba/screens/screensResidente/bottom_nav.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:prueba/model/visita.dart';
import 'package:prueba/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';

class RegistrarVisita extends StatefulWidget {
  const RegistrarVisita({super.key});

  @override
  State<RegistrarVisita> createState() => _RegistrarVisitaState();
}

String residente = nombreResidente;
String nombreVisita = "";
const List<Widget> opcionesDias = <Widget>[Text('Hoy'), Text('Mañana')];

class _RegistrarVisitaState extends State<RegistrarVisita> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  bool _showConfirmation = false;
  int _value = 0;

  final List<bool> _selectedDay = <bool>[true, false];
  DateTime dateTime = DateTime.now();
  TextEditingController controller = TextEditingController();
  _cargarData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      residente = prefs.getString("nombre") ?? "N.A";
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Nombre en registrar: ${residente}");

    Visita visita;
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
                  controller: controller,
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

                ///
                ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedDay.length; i++) {
                          _selectedDay[i] = i == index;
                        }
                        _value = index;
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Color.fromARGB(255, 31, 89, 42),
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
                SizedBox(height: 30.0),
                Text(
                  'Hora de llegada',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                /**Selección de hora */
                CupertinoButton(
                    child: Text('${dateTime.hour}:${dateTime.minute}'),
                    color: Colors.green,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
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
                    }),
                SizedBox(height: 50.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ingrese nombre de visita')));
                      } else {
                        print("Nombre de visita: ${controller.text}");
                        print("Dia" + _value.toString());
                        DateTime fechaVisita = DateTime.now();
                        if(_value == 0){
                          fechaVisita = new DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day, dateTime.hour, dateTime.minute);                      
                        }else if(_value == 1){
                          fechaVisita = new DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day+1, dateTime.hour, dateTime.minute);
                        }
                        print("Fecha visita: " + fechaVisita.toString());
                        setState(() {
                          nombreVisita = controller.text;
                        });
                        Visita visita = crearVisita();
                        _widgetQRCode(context, visita);
                      }
                    },
                    child: Text('Registrar Visita'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromARGB(255, 75, 130, 77)),
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

_widgetQRCode(BuildContext context, Visita visita) {
  var uuid = Uuid();
  String qrData = uuid.v4();
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 251, 250, 239),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Container(
            height: 650, // Establece la altura deseada aquí
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 300.0,
                    )),
                Text(
                  'Enviar código QR al visitante',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    //Share.share('');
                  },
                  child: Text('Compartir'),
                ),
              ],
            ));
      });
}

Visita crearVisita() {
  Visita miVisita = Visita(
    nombre: nombreVisita,
    fechaVisita: DateTime.now(),
    fechaCreacion: DateTime.now(),
    residente: residente,
  );
  return miVisita;
}
