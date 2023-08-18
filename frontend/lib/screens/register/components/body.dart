import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/User.dart';
import '../../../utils/Persistence.dart';
import '../../../utils/Persistencia.dart';
import '../../../utils/widgetQR.dart';

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
  TimeOfDay visitTime = TimeOfDay.now();
  final List<bool> _selectedDay = <bool>[true, false];
  final apiClient = ApiGlobal.api;
  bool isGuard = false;
  bool _isButtonDisabled = false; 
  String _textButton = "Registrar Visita";

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
    _loadisGuard();
  }
  Future<void> _loadisGuard() async {
    try {
      bool guard = await apiClient.isGuard();
      setState(() {
        isGuard = guard;
      });
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }
  void _showTimePicker() {
    showTimePicker(context: context, initialTime: visitTime)
        .then((value) => setState(() {
              visitTime = value!;
            }));
  }

  Function? _registerButtonPressed(){
    if(_isButtonDisabled){
      return null;
    }else{
       setState(() {
      fechaVisita = visitDateTime(visitTime, _value);
    });
      _widgetQRCode(context);
    }
  }
  _widgetQRCode(BuildContext context) async {
  setState((){
    _isButtonDisabled = true;
    _textButton = "Registrando...";
  });
  var nombreVisitaRegistro = nombreVisitacontroller.text;
  try{
    String qrData = await getTokenAndPostVisit(context);
    if(qrData=="")   {  ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Guardado exitosamente.'),
          backgroundColor: Colors.green,));;
          return;
    }
    showModalBottomSheet(
        backgroundColor: const Color.fromARGB(255, 251, 250, 239),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        context: context,
        builder: (context) {
          //Navigator.of(context).pop();
          return QRCodeModal(visitID: qrData, nombreVisita: nombreVisitaRegistro, fechaVisita: fechaVisita);
          
        });
    setState((){
    _isButtonDisabled = false;
    _textButton = "Registrar Visita";
    nombreVisitacontroller.text = "";
    
  });
  } catch(error){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error interno del servidor.')));
  }
}

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
                  'Información de la visita',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  key: const Key("visitorNameField"),
                  controller: nombreVisitacontroller,
                  decoration: InputDecoration(
                      hintText: 'Nombre y apellido',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 30.0),
                if (!isGuard) ...[
                /**Elección de día de visita */
                Text(
                  'Día de visita',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                ToggleButtons(
                    key: const Key("selectedDay"),
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
                    children: opcionesDias),
                const SizedBox(height: 30.0),
                
                  Text(
                    'Seleccionar hora esperada',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left,
                  ),
                  Center(
                    child: MaterialButton(
                      color: Colors.green,
                      child: Text(
                        '${visitTime.hour.toString().padLeft(2, "0")}:${visitTime.minute.toString().padLeft(2, "0")}',style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: _showTimePicker,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
                const SizedBox(height: 30.0),
                Visibility(
                  visible: isGuard,
                  child: Column(
                    children: [
                      Text(
                        'Detalles',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ingresar detalles de visita',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Center(
                  child: TextButton(
                    child: Text(_textButton),
                    key: const Key("registerVisitButton"),
                    onPressed: () {
                      if (nombreVisitacontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Ingrese nombre de la visita.')));
                      }else if(!validateNameVisitor(nombreVisitacontroller.text)){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Ingresar nombre y apellido.')));
                      } else if (_value == 0 &&
                          (!validateTimeVisit(visitTime))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Hora de visita no válida.')));
                      }else {
                         _registerButtonPressed();
                      }
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(250, 50)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 56, 114, 58)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    
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

Future getTokenAndPostVisit(BuildContext context) async {
  final apiClient = ApiGlobal.api;
  var reqParams = {
    "name": nombreVisitacontroller.text,
    "date": fechaVisita.toString(),
  };
  try {
    var qriID = await apiClient.postVisit(reqParams, context);
    await Future.delayed(const Duration(seconds: 2));
    if(qriID==null) return "";
    return qriID;
  } catch (error) {
     throw Exception('Error interno del servidor.');
  }
}



