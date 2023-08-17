import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/Persistence.dart';
import '../../../utils/widgetQR.dart';
import '../../home/home_screen.dart';

class ContainerVisitaPendiente extends StatefulWidget {
  final List<dynamic> visitasPendientes;
  const ContainerVisitaPendiente({Key? key,required this.visitasPendientes}) : super(key: key);

  @override
  State<ContainerVisitaPendiente> createState() => ContainerVisitaPendienteState();
}
enum _MenuOptions { verQR, anular }
class ContainerVisitaPendienteState extends State<ContainerVisitaPendiente> {
  final apiClient = ApiGlobal.api;
  bool isGuard = false;
  
  String  qr_id = "";

  @override
  void initState() {
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 5,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        
        Expanded(
          child: ListView.builder(
            itemCount: widget.visitasPendientes.length,
            itemBuilder: (BuildContext context, int index) {
              final visita = widget.visitasPendientes[index]; 
              final nombreVisita = visita['visitor']['name'];
              final visitID = visita['id'];
              return ListTile(
                  title: Text(nombreVisita), 
                  leading: const Icon(Icons.person),
                  trailing: !isGuard ? PopupMenuButton<_MenuOptions>(
                   itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
                  const PopupMenuItem(
                    value: _MenuOptions.verQR,
                    child: Text('Ver QR')
                  ),
                  const PopupMenuItem(
                    value: _MenuOptions.anular,
                    key: Key("anularVisitbutton"),
                    child: Text('Anular'),
                  ),
                ],
                onSelected: (value) {
                  switch(value){
                    case _MenuOptions.verQR:
                      _widgetQRCode(context,visitID);
                      break;
                    case _MenuOptions.anular:
                      _showDialog(context,visitID);
                      
                      break;
                  }
                }
                  ) : null);
            },
          ),
        )],
      ),
    );
  }
}

_widgetQRCode(BuildContext context, String visitID) async{
  var visitData = await ApiGlobal.api.getVisitbyID(visitID);
  var qr_id = visitData['visit']['qr_id'];
  String nameVisit = visitData['visitor']['name'];;
  String dateString = visitData['visit']['date'];
  DateTime dateVisit = DateTime.parse(dateString);
  try{
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
          return QRCodeModal(visitID: qr_id, nombreVisita: nameVisit, fechaVisita: dateVisit);
          
        });
  } catch(error){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error interno del servidor.')));
  }
}

void _showDialog (BuildContext context, String visitID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Anular visita"),
        content: const Text("¿Está seguro que desea anular la visita?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              try{
                await cancelarVisita(context,visitID);
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, HomeScreen.routeName);
                successDelete(context);                 
              }catch(error){
                Navigator.of(context).pop();
                errorAnular(context);
              }    
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}

cancelarVisita(BuildContext context, String visitID) async {
  try{
    var visitData = await ApiGlobal.api.getVisitbyID(visitID);
    var qr_id = visitData['visit']['qr_id'];
    await ApiGlobal.api.cancelVisit(qr_id);
  }catch(error){
    throw Exception("Error al anular visita");
  }
 
}

void successDelete(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Visita anulada'),
                      backgroundColor: Colors.green,
                    ),
                  );
}

void errorAnular(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No se pudo anular visita."),
                      backgroundColor: Colors.red,
                    ),
                  );
}
