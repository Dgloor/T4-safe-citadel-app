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

class _RegistrarVisitaState extends State<RegistrarVisita> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  bool _showConfirmation = false;
  int _value = 0;
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
                      hintText: 'Nombre del visitante',
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
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value as int;
                        });
                      },
                    ),
                    Text('Hoy')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value as int;
                        });
                      },
                    ),
                    Text('Mañana')
                  ],
                ),
                Text(
                  'Elegir hora',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                /**Selección de hora */
                CupertinoButton(
                    child: Text('${dateTime.hour}:${dateTime.minute}'),
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
                SizedBox(height: 16.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ingrese nombre de visita')));
                      } else {
                        print("Nombre de visita: ${controller.text}");
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
