import 'package:flutter/material.dart';
import 'package:safecitadel/utils/Persistence.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../size_config.dart';
import '../../home/components/discount_banner.dart';
import '../../home/home_screen.dart';
import '../visitor_screen.dart';
import './widgetQR.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _Body();
}

List<dynamic> visitasIngresadas = [];
List<dynamic> visitasPendientes = [];
List<dynamic> visitasAnuladas = [];

class _ContainerVisitaIngresada extends StatelessWidget {
   const _ContainerVisitaIngresada({Key? key}) : super(key: key);
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
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 5),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ListView.builder(
              itemCount: visitasIngresadas.length,
              itemBuilder: (BuildContext context, int index) {
              final visita = visitasIngresadas[index]; 
              final nombreVisita = visita['visitor']['name'];
                return ListTile(
                    title: Text(nombreVisita), leading: const Icon(Icons.person));
              },
            ),
          ),
        ]));
  }
}

class _ContainerVisitaAnulada extends StatelessWidget {
  const _ContainerVisitaAnulada({Key? key}) : super(key: key);
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
            itemCount: visitasAnuladas.length,
            itemBuilder: (BuildContext context, int index) {
              final visita = visitasAnuladas[index]; 
              final nombreVisita = visita['visitor']['name'];
              return ListTile(
                  title: Text(nombreVisita), leading: const Icon(Icons.person));
            },
          ),
        ),
      ]),
    );
  }
}

class _ContainerVisitaPendiente extends StatelessWidget {
  const _ContainerVisitaPendiente({Key? key}) : super(key: key);
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
            itemCount: visitasPendientes.length,
            itemBuilder: (BuildContext context, int index) {
              final visita = visitasPendientes[index]; 
              final nombreVisita = visita['visitor']['name'];
              final visitID = visita['id'];
              return ListTile(
                  title: Text(nombreVisita), 
                  leading: const Icon(Icons.person),
                  trailing: PopupMenuButton<_MenuOptions>(
                   itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
                  const PopupMenuItem(
                    value: _MenuOptions.verQR,
                    child: Text('Ver QR')
                  ),
                  const PopupMenuItem(
                    value: _MenuOptions.anular,
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
                  ));
            },
          ),
        ),
      ]),
    );
  }
}


enum _MenuOptions { verQR, anular }
String  qr_id = "";

cancelarVisita(BuildContext context, String visitID) async {
  try{
    var visitData = await ApiGlobal.api.getVisitbyID(visitID);
    var qr_id = visitData["qr_id"];
    bool success = await ApiGlobal.api.cancelVisit(qr_id);
  }catch(error){
    throw Exception("Error al anular visita");
  }
 
}

void successDelete(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Visita anulada'),
                      backgroundColor: Colors.green,
                    ),
                  );
}

void errorAnular(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("No se pudo anular visita."),
                      backgroundColor: Colors.red,
                    ),
                  );
}
void errorGetVisits(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Problemas para obtener visitas."),
                      backgroundColor: Colors.red,
                    ),
                  );
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
                Navigator.pushNamed(context, HomeScreen.routeName);
                successDelete(context);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                 
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

_widgetQRCode(BuildContext context, String visitID) async{
  var visitData = await ApiGlobal.api.getVisitbyID(visitID);
  var qr_id = visitData['qr_id'];
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
          return QRCodeModal(visitID: qr_id);
          
        });
  } catch(error){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error interno del servidor.')));
  }
}

getVisits() async {
  try {
    var jsonResponse = await ApiGlobal.api.getVisits();
    visitasPendientes = jsonResponse['visits']['PENDING'] ?? [];
    visitasIngresadas = jsonResponse['visits']['REGISTERED'] ?? [];
    visitasAnuladas = jsonResponse['visits']['CANCELLED'] ?? [];
  } catch (error) {
    throw Exception("Error al obtener visitas");
  }
}
///Widget   principal
class _Body extends State<Body>
    with TickerProviderStateMixin {
  final apiClient = ApiGlobal.api;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    try{
      getVisits();
    }catch(error){
      errorGetVisits(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(
            width: getProportionateScreenWidth(450),
            //height: getProportionateScreenHeight(200),
            child: Column(
              children: [
               const WelcomeBanner(),
                const SizedBox(height: 25),
                Container(
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 33, 128, 72),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle:
                        const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    tabs: const [
                      Tab(text: "Ingresada"),
                      Tab(text: "Pendiente"),
                      Tab(text: "Anulada")
                    ],
                    labelColor: const Color.fromARGB(255, 214, 221, 214),
                    unselectedLabelColor: const Color.fromARGB(255, 81, 173, 85),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: getProportionateScreenWidth(500),
                  height: getProportionateScreenHeight(450),
                  child: SizedBox(
                    height: getProportionateScreenHeight(450),
                    child: TabBarView(controller: tabController, children:const [
                    _ContainerVisitaIngresada(),
                    _ContainerVisitaPendiente(),
                    _ContainerVisitaAnulada()
                  ])),
                ),
              ],
            ),
          )
                  ],
      )),
    );
  }
}
