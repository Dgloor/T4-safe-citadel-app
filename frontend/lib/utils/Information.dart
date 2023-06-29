import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safecitadel/constants.dart';
import 'package:safecitadel/models/User.dart';

class Api {
  static Future<User> getUserData(String token) async {
    var url = Uri.parse(APIUSER);
    var headers = {"Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes obtener la respuesta
      var responseData = jsonDecode( response.body);
      
      return User.fromJson(responseData['user']);
    } else {
      // Ocurrió un error en la solicitud
      throw Exception('No es posible cargar los datos del usuario.');
    }
  }

}
