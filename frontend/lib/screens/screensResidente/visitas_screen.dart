import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav.dart';
import 'package:uuid/uuid.dart';
import 'package:prueba/utils/globals.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitaScreenResidente extends StatefulWidget {
  const VisitaScreenResidente({Key? key}) : super(key: key);

  @override
  State<VisitaScreenResidente> createState() => _VisitaScreenResidente();
}

List<String> visitasIngresadas = [
  "María Solís",
  "Anthony Cruz",
  "Xavier Mendoza",
  "José Mendoza",
  "Franklin Cevallos",
  "Andy Gutierrez",
  "Jonathan Zavala",
];
List<String> visitasPendientes = [
  "Alberto Suarez",
  "Ana Perez",
  "Jaime Rodriguez",
  "Carlos Freire"
];
List<String> visitasAnuladas = [
  "José Hurtado",
];

class _InputBuscarVisita extends StatelessWidget {
  _InputBuscarVisita({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Buscar visita',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 73, 70, 70).withOpacity(0.5)),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContainerVisitaIngresada extends StatefulWidget {
  const _ContainerVisitaIngresada({Key? key}) : super(key: key);
  @override
  State<_ContainerVisitaIngresada> createState() =>
      _ContainerVisitaIngresadaState();
}

class _ContainerVisitaIngresadaState extends State<_ContainerVisitaIngresada> {
  void fetchUser() async {
    const url = 'https://randomuser.me/api/?results=5';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
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
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 5),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _InputBuscarVisita(),
          Expanded(
            child: ListView.builder(
              itemCount: visitasIngresadas.length,
              itemBuilder: (BuildContext context, int index) {
                final nombreVisita = visitasIngresadas[index];
                return ListTile(
                    title: Text(nombreVisita), leading: Icon(Icons.person));
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
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 5,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _InputBuscarVisita(),
        Expanded(
          child: ListView.builder(
            itemCount: visitasAnuladas.length,
            itemBuilder: (BuildContext context, int index) {
              final nombreVisita = visitasAnuladas[index];
              return ListTile(
                  title: Text(nombreVisita), leading: Icon(Icons.person));
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
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 5,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _InputBuscarVisita(),
        Expanded(
          child: ListView.builder(
            itemCount: visitasPendientes.length,
            itemBuilder: (BuildContext context, int index) {
              final nombreVisita = visitasPendientes[index];
              return ListTile(
                  title: Text(nombreVisita), 
                  leading: Icon(Icons.person),
                  trailing: PopupMenuButton<_MenuOptions>(
                   itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
                  const PopupMenuItem(
                    child: Text('Ver QR'),
                    value: _MenuOptions.verQR
                  ),
                  const PopupMenuItem(
                    child: Text('Anular'),
                    value: _MenuOptions.anular
                  ),
                ],
                onSelected: (value) {
                  switch(value){
                    case _MenuOptions.verQR:
                      _widgetQRCode(context);
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
_widgetQRCode(BuildContext context) {
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
class _ListView extends StatelessWidget {
  const _ListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text('List 1'),
        Text('List 2'),
        Text('List 3'),
      ],
    );
  }
}

/***********Widget   principal ***********/
class _VisitaScreenResidente extends State<VisitaScreenResidente>
    with TickerProviderStateMixin {
  String nombre = "";
  @override
  void initState() {
    super.initState();
    _cargarData();
  }

  /**Cargar variables de almacenamiento interno, en este caso obtengo el nombre del usuario */
  void _cargarData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = nombreResidente;
    });
  }

  String usuario = "";
  @override
  Widget build(BuildContext context) {
    print("Nombre: ${nombre}");
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                  'Hola, ${nombre}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 25),
                Container(
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(255, 33, 128, 72),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle:
                        TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    tabs: [
                      Tab(text: "Ingresada"),
                      Tab(text: "Pendiente"),
                      Tab(text: "Anulada")
                    ],
                    labelColor: Color.fromARGB(255, 214, 221, 214),
                    unselectedLabelColor: Color.fromARGB(255, 81, 173, 85),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: double.maxFinite,
                  height: 450,
                  child: TabBarView(controller: _tabController, children: [
                    _ContainerVisitaIngresada(),
                    _ContainerVisitaPendiente(),
                    _ContainerVisitaAnulada()
                  ]),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
