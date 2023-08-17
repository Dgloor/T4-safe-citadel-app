import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safecitadel/constants.dart';
import 'package:riverpod/riverpod.dart';
import 'package:safecitadel/models/User.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

class ApiClient {
  late final Dio _dio;
  late final FlutterSecureStorage _secureStorage;

  ApiClient() {
    _dio = Dio();
    _secureStorage = const FlutterSecureStorage();
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await _loadAccessToken();
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            // Token expired, refresh it and retry the request
            final newAccessToken = await _refreshAccessToken();
            final options = response.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';
            final refreshedResponse =
                await _dio.request(options.path, options: options.data);
            return handler.resolve(refreshedResponse);
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<String> _loadAccessToken() async {
    // Check if the access token is stored locally
    final localAccessToken = await _secureStorage.read(key: 'access_token');

    if (localAccessToken != null) {
      return localAccessToken;
    }

    // Request a new access token
    final newAccessToken = await _refreshAccessToken();

    return newAccessToken;
  }

  Future<String> _refreshAccessToken() async {
    // Get the refresh token from cache or local storage
    final refreshToken = await _secureStorage.read(key: 'refresh_token');

    // Send a request to the token refresh endpoint to get a new access token
    const url = 'http://localhost:8000/api/refresh';
    final queryParams = {
      'token': refreshToken,
    };
    final basicAuth = 'Basic ${base64Encode(utf8.encode('admin:password'))}';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        }),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);
        final newAccessToken = responseData['access_token'];
        final tokenType = responseData['token_type'];

        // Store the new access token locally
        await _secureStorage.write(key: 'access_token', value: newAccessToken);

        return newAccessToken;
      }
    } catch (e) {
      throw Exception('Failed to refresh access token');
    }

    throw Exception('Failed to refresh access token');
  }

  Future<String> authenticate(
    String? username, String? password, BuildContext context) async {
    final url = Uri.parse(APIAUTH);
    final requestBody = jsonEncode({
      'username': username,
      'password': password,
    });
    final basicAuth = 'Basic ${base64Encode(utf8.encode('admin:password'))}';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['token'];
      final refreshToken = responseData['refresh_token'];

      // Store the access token and refresh token locally
      await _secureStorage.write(key: 'access_token', value: accessToken);
      await _secureStorage.write(key: 'refresh_token', value: refreshToken);

      return accessToken;
    } else if (response.statusCode == 401) {
      throw AuthException('Credenciales incorrectas.');
    } else if (response.statusCode == 500) {
      throw ServerException('Error interno del servidor.');
    } else {
      throw ServerException('Error desconocido.');
    }
  }
  Future setUserName(String username) async {
    await _secureStorage.write(key: '_username', value: username);
  }
  Future setResidentName(String name) async {
    await _secureStorage.write(key: 'name_residente', value: name);
  }
  Future getName() async{
    return await _secureStorage.read(key: 'name_residente');    
  }
  Future saveUser(String username, String password) async{
    await setUserName(username);
    await setPassWord(password);  
  }
  Future<String?> getUserName() async {
    return await _secureStorage.read(key: '_username');
  }
  Future setRole(String role) async{
    return _secureStorage.write(key: 'role', value: role);
  }
  Future<String?> getRole() async{
    return await _secureStorage.read(key: 'role');
  }
  Future<bool> isGuard() async{
    String role =  await getRole() ?? '';
    return role == "GUARD";
  }
  Future setPassWord(String password) async {
    await _secureStorage.write(key: '_password', value: password);
  }

  Future<String?> getPassWord() async {
    return await _secureStorage.read(key: '_password');
  }
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future widgetLoading(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<User> getUserData() async {
    final url = Uri.parse(APIUSER);
    String token = await _loadAccessToken();
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes obtener la respuesta
      var responseData = jsonDecode(response.body);
      setResidentName(responseData['user']['name']);
      setRole(responseData['user']['role']);
      return User.fromJson(responseData['user']);
    } else if (response.statusCode == 401) {
      throw AuthException('No autorizado. Token inválido o expirado.');
    } else if (response.statusCode == 500) {
      throw ServerException('Error interno del servidor.');
    } else {
      throw ServerException('Error desconocido.');
    }
  }

  Future<dynamic> getVisits() async {
    var uri = Uri.parse(APIGETVISITS);
    String token = await _loadAccessToken();
    var header = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('No es posible consultar visitas.');
    }
  }
  Future<Map<String, List<dynamic>>> fillVisits() async {
  try {
    var jsonResponse = await getVisits();
    List<dynamic> arrayPending = jsonResponse['visits']['PENDING'] ?? [];
    List<dynamic> arrayRegistered = jsonResponse['visits']['REGISTERED'] ?? [];
    List<dynamic> arrayCancelled = jsonResponse['visits']['CANCELLED'] ?? [];

    return {
      'pending': arrayPending,
      'registered': arrayRegistered,
      'cancelled': arrayCancelled,
    };
  } catch (error) {
    throw Exception("Error al obtener visitas");
  }
}

  Future<dynamic> getVisitbyID(String visitID) async {
    var uri = Uri.parse(APIGETVISIT + visitID);
    String token = await _loadAccessToken();
    var header = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('No es posible consultar visita.');
    }
  }


  Future<dynamic> postVisit(
      Map<String, dynamic> reqParams, BuildContext context) async {
    var uri = Uri.parse(APIPOSTVISIT);
    String token = await _loadAccessToken();
    var response = await http.post((uri).replace(queryParameters: reqParams),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['qr_id'];
    } else {
      throw Exception('No es posible registrar visita.');
    }
  }

  Future<dynamic> getVisitByQRCode(String qrCode) async {
    final url = Uri.parse(APIQR + qrCode);
    String token = await _loadAccessToken();
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('No es posible obtener la información de la visita.');
    }
  }

  Future<bool> cancelVisit(String qrCode) async {
    final url = Uri.parse(APICANCEL + qrCode);
    String token = await _loadAccessToken();
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.patch(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
        throw Exception('No es posible cancelar la visita.');
    }
  }

  Future<bool> registerVisit(String qrCode) async {
    final url = Uri.parse(APIREGISTER + qrCode);
    String token = await _loadAccessToken();
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('No es POSIBLE registrar la visita.');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() => message;
}
