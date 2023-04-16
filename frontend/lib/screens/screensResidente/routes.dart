import 'package:flutter/material.dart';
import 'package:prueba/screens/screensResidente/home_screenResidente.dart';
import 'package:prueba/screens/screensResidente/perfil_screen.dart';
import 'package:prueba/screens/screensResidente/registrarvisita_screen.dart';
import 'package:prueba/screens/screensResidente/visitas_screen.dart';
 /**Se definen las rutas utilizadas en el home_screenResidente mediante una lista de widgets*/
 class Routes extends StatelessWidget {
  final String nombre;
  final int index;
  const Routes({Key? key, required this.index, required this.nombre}): super(key: key); 
   @override
   Widget build(BuildContext context) {
    List<Widget> myList = [
      const VisitaScreenResidente(nombre:nombre), //ojo, corregir
      const RegistrarVisita(),
      const PerfilResidente()
    ];
     return myList[index];
   }
 }