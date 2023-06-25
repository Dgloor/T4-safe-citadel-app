import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba/constants.dart';
class Authentication {
  static Future<String> authenticate(
    String? username,
    String? password,
  ) async {
    var url = Uri.parse(APIAUTH);
    print(username);
    print(password);
    var requestBody = jsonEncode({
      "username": username,
      "password": password,
    });
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:password'));

    var headers = {'Content-Type': 'application/json', 'authorization': basicAuth};
      var response = await http.post(url, headers: headers,body: requestBody);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var token = responseData['token'];
        var refreshToken = responseData['refresh_token'];
        // Aquí puedes realizar acciones con los datos recibidos
        print('Token: $token');
        print('Refresh Token: $refreshToken');
        return token;
      } else {
        print(response.body);
        throw Exception('Credenciales inválidas. Inténtalo de nuevo.');
      }

  }
}