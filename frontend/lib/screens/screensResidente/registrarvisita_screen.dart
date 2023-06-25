import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'environment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RegistrarVisita extends StatefulWidget {
  const RegistrarVisita({super.key});

  @override
  State<RegistrarVisita> createState() => _RegistrarVisitaState();
}
///Variables
String nombreVisita = "";
TextEditingController nombreVisitacontroller = TextEditingController();
const List<Widget> opcionesDias = <Widget>[Text('Hoy'), Text('Mañana')];
DateTime fechaVisita = DateTime.now();
String qrID = "";
class _RegistrarVisitaState extends State<RegistrarVisita> {
  final _formKey = GlobalKey<FormState>();
  int _value = 0;

  final List<bool> _selectedDay = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 248),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
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
                const SizedBox(height: 30.0),
                TextField(
                  controller: nombreVisitacontroller,
                  decoration: InputDecoration(
                      hintText: 'Nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 30.0),
                /**Elección de día de visita */ 
                Text(
                  'Día de visita',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                ToggleButtons(
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
                  'Hora de llegada',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                /**Selección de hora */
                CupertinoButton(
                    color: Colors.green,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                                height: 250,
                                child: SizedBox(
                                  child: CupertinoDatePicker(
                                    initialDateTime: fechaVisita,
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (dateTimeChanged) =>
                                        setState(() {
                                      fechaVisita = dateTimeChanged;
                                    }),
                                  ),
                                ),
                              ));
                    },
                    child: Text('${fechaVisita.hour}:${fechaVisita.minute}'),
                    ),
                const SizedBox(height: 50.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
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
                        print("Nombre de visita: ${nombreVisitacontroller.text}");
                        print("Dia" + _value.toString());
                        DateTime fechaVisita = DateTime.now();
                        DateTime fechaCreacion = DateTime.now();
                        
                       setState(() {
                            var newDate = DateTime(
                                fechaVisita.year,
                                fechaVisita.month,
                                fechaVisita.day,
                                fechaVisita.hour,
                                fechaVisita.minute);

                            if (_value == 0) {
                              // No se realiza ningún cambio en la fecha
                            } else if (_value == 1) {
                              newDate = newDate.add(Duration(days: 1));
                            }
                            nombreVisita = nombreVisitacontroller.text;
                            fechaVisita = newDate;
                          });
                        print("Fecha visita: " + fechaVisita.toString());
                        print("Fecha creacion: " + fechaCreacion.toString());
                        setState(() {
                          //nombreVisita = nombreVisitacontroller.text;
                        });
                        _widgetQRCode(context);
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 75, 130, 77)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Text('Registrar Visita')
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_widgetQRCode(BuildContext context) async {
  String qrData = await registrarVisita();
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
            height: 650, // Establece la altura deseada aquí
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

Future getToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? "N.A";
  return token;
}

Future registrarVisita() async{
  String token = await getToken();
  var reqParams = {
    "name": nombreVisitacontroller.text,
    "date": fechaVisita.toString(),
  };
  var response = await http.post(Uri.parse(postVisit)
  .replace(queryParameters: reqParams),headers: {"Content-Type": "application/json",
                    "Authorization": 'Bearer $token'
          });
  if(response.statusCode == 200){
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['qr_id'];
  }else{
    print("Error al registrar visita");
  }
}