import 'package:flutter/material.dart';
import 'perfil_screen.dart';
import 'registrarvisita_screen.dart';
import 'visitas_screen.dart';
 ///Se definen las rutas utilizadas en el home_screenResidente mediante una lista de widgets
 class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}): super(key: key); 
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