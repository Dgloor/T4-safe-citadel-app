
import 'package:flutter/material.dart';

class ContainerVisitaAnulada extends StatefulWidget {
  final List<dynamic> visitasAnuladas;
  const ContainerVisitaAnulada({Key? key,required this.visitasAnuladas}) : super(key: key);

  @override
  State<ContainerVisitaAnulada> createState() => ContainerVisitaAnuladaState();
}

class ContainerVisitaAnuladaState extends State<ContainerVisitaAnulada> {
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
            itemCount: widget.visitasAnuladas.length,
            itemBuilder: (BuildContext context, int index) {
              final visita = widget.visitasAnuladas[index]; 
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
