import 'package:flutter/material.dart';
import 'package:prueba/screens/screensResidente/bottom_nav.dart';
import 'package:prueba/screens/screensResidente/routes.dart';
/**Pantalla principal de la aplicación, 
 * para permitir que los usuarios naveguen entre diferentes 
 * páginas. */
class HomeResidente extends StatefulWidget {
  const HomeResidente({super.key});

  @override
  State<HomeResidente> createState() => _HomeResidenteState();
}

class _HomeResidenteState extends State<HomeResidente> {
  int index = 0;
  BNavigator ?myBN;
  @override
  void initState() {
    myBN = BNavigator(currentIndex: (i){
      setState(() {
        index = i;
      });
    });

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBN,
      body: Routes(index:index),
    );
  }
}