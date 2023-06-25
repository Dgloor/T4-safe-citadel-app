import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authentication {
  Dio api= new Dio();
  String? accessToken;
  final _storage = new FlutterSecureStorage();
  String? refreshToken;
  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = APIAUTH + options.path;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
        // todo: will finish this
      return handler.next(error);
    }));
    
  }






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

        return token;
      } else {
        throw Exception('Credenciales inválidas. Inténtalo de nuevo.');
      }
  }
}


