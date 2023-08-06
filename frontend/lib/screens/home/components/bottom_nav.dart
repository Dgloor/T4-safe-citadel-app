import 'package:flutter/material.dart';


class BNavigator extends StatefulWidget{
  final Function currentIndex;
  const BNavigator({Key? key, required this.currentIndex}) : super(key : key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BNavigator>{
  int index = 0;
  @override
  Widget build(BuildContext context) {
  return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i){
          setState(() {
            index = i;
            widget.currentIndex(i);
          });
        },
        selectedItemColor: Colors.green ,
        iconSize: 25.0,
        selectedFontSize: 14.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedFontSize: 12.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Visitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Registrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],
      );
  }
}