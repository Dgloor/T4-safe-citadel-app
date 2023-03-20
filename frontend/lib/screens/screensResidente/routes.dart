import 'package:flutter/material.dart';
import 'package:prueba/screens/screensResidente/home_screenResidente.dart';
import 'package:prueba/screens/screensResidente/perfil_screen.dart';
import 'package:prueba/screens/screensResidente/registrarvisita_screen.dart';
import 'package:prueba/screens/screensResidente/visitas_screen.dart';
 
 class Routes extends StatelessWidget {
  final int index;
   const Routes({Key? key, required this.index}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
    List<Widget> myList = [
      const VisitaScreenResidente(),
      const RegistrarVisita(),
      const PerfilResidente()
    ];
     return myList[index];
   }
 }