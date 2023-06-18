import 'dart:convert';

class Visita {
  String nombre;
  DateTime fechaVisita;
  DateTime fechaCreacion;
  String residente;

  Visita({
    required this.nombre,
    required this.fechaVisita,
    required this.fechaCreacion,
    required this.residente,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'fechaVisita': fechaVisita.toString(),
      'fechaCreacion': fechaCreacion.toString(),
      'residente': residente,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
