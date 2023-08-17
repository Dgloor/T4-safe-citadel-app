import 'package:flutter/material.dart';

class ContainerVisitaIngresada extends StatefulWidget {
  final List<dynamic> visitasIngresadas;
   const ContainerVisitaIngresada({Key? key,required this.visitasIngresadas}) : super(key: key);

  @override
  State<ContainerVisitaIngresada> createState() => _ContainerVisitaIngresadaState();
}

class _ContainerVisitaIngresadaState extends State<ContainerVisitaIngresada> {
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
              itemCount: widget.visitasIngresadas.length,
              itemBuilder: (BuildContext context, int index) {
              final visita = widget.visitasIngresadas[index]; 
              // final nombreVisita = visita['visitor']['name'] ?? '';;
              final nombreVisita = visita != null && visita['visitor'] != null ? visita['visitor']['name'] ?? '' : '';
                return ListTile(
                    title: Text(nombreVisita), leading: const Icon(Icons.person));
              },
            ),
          ),
        ]));
  }
}