import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:prueba/model/visita.dart';
import 'package:prueba/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print("Nombre en registrar: $residente");
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
                  controller: controller,
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
                                    initialDateTime: dateTime,
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (dateTime) =>
                                        setState(() {
                                      this.dateTime = dateTime;
                                    }),
                                  ),
                                ),
                              ));
                    },
                    child: Text('${dateTime.hour}:${dateTime.minute}'),
                    ),
                const SizedBox(height: 50.0),
                /**Botón para enviar el registro de la visita */
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ingrese nombre de visita')));
                      }
                      else if(_value == 0 
                              && (dateTime.hour < DateTime.now().hour 
                              && dateTime.minute < DateTime.now().minute)){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Hora de visita no válida')));
                      } 
                      else {
                        print("Nombre de visita: ${controller.text}");
                        print("Dia" + _value.toString());
                        DateTime fechaVisita = DateTime.now();
                        DateTime fechaCreacion = DateTime.now();
                        
                        if(_value == 0){
                          fechaVisita = DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day, dateTime.hour, dateTime.minute);                      
                        }else if(_value == 1){
                          fechaVisita = DateTime(fechaVisita.year, fechaVisita.month, fechaVisita.day+1, dateTime.hour, dateTime.minute);
                        }
                        print("Fecha visita: " + fechaVisita.toString());
                        print("Fecha creacion: " + fechaCreacion.toString());
                        setState(() {
                          nombreVisita = controller.text;
                        });
                        Visita visita = crearVisita();
                        _widgetQRCode(context, visita);
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

_widgetQRCode(BuildContext context, Visita visita) {
  String qrData = "";
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
                Text(
                  'Enviar código QR al visitante',
                  style: const TextStyle(
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
