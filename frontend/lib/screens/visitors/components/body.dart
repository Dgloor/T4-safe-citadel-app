import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prueba/utils/Persistence.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:prueba/utils/Information.dart';
import '../../../utils/Persistencia.dart';
import '../../../size_config.dart';
import '../../home/components/discount_banner.dart';
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

_widgetQRCode(BuildContext context, String visitID) async{
  //_getVisitID(visitID);
  print("visita seleccionada: "+visitID);
  print("Este es el QRid: " + qr_id);
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
                      data: qr_id,
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
}


///Widget   principal
class _Body extends State<Body>
    with TickerProviderStateMixin {
  final apiClient = ApiGlobal.api;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    apiClient.getVisits().then((jsonResponse) {
      setState(() {
        visitasPendientes = jsonResponse['visits']['PENDING'] ?? [];
        visitasIngresadas = jsonResponse['visits']['REGISTERED'] ?? [];
        visitasAnuladas = jsonResponse['visits']['CANCELLED'] ?? [];
      });
    }).catchError((error) {
      _errorMessage = error.toString();
    });
  }
//   void getTokenAndGetVisits() async {
//   SharedPreferencesUtil prefs = await SharedPreferencesUtil.getInstance();
//   String token = prefs.getToken();
//   try {
//     var jsonResponse = await Api.getVisits(token);
//     setState(() {
//         visitasPendientes = jsonResponse['visits']['PENDING'] ?? [];
//         visitasIngresadas = jsonResponse['visits']['REGISTERED'] ?? [];
//         visitasAnuladas = jsonResponse['visits']['CANCELLED'] ?? [];
//       });
//   } catch (error) {
//     print('Error al obtener las visitas: $error');
//   }
// }

  String usuario = "";
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            width: getProportionateScreenWidth(450),
            //height: getProportionateScreenHeight(200),
            child: Column(
              children: [
               WelcomeBanner(),
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
                Container(
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
