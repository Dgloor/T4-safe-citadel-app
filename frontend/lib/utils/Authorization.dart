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
            final refreshedResponse= await _dio.request(options.path, options: options.data);
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

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return ApiClient.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }


    Future<String> authenticate(String? username, String? password, BuildContext context) async {
    widgetLoading(context);
    final url = Uri.parse(APIAUTH);
    final requestBody = jsonEncode({
      'username': username,
      'password': password,
    });
    final basicAuth = 'Basic ${base64Encode(utf8.encode('admin:password'))}';

    try {
      final response = await http. post(
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
      }
    } catch (e) {
      throw Exception('Failed to authenticate');
    }

    throw Exception('Failed to authenticate');
  }
  Future widgetLoading(BuildContext context) async{
    showDialog(
      context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());
      });
  }
   Future<User> getUserData() async {
    final url = Uri.parse(APIUSER);
    String token = await _loadAccessToken();
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
  Future<dynamic> getVisits() async {
    var uri = Uri.parse(APIGETVISITS);
    String token = await _loadAccessToken();
    var header =  {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      throw Exception('No es posible registrar visita.');
    }
  }
  Future<dynamic> postVisit(Map<String, dynamic> reqParams, BuildContext context) async {
    widgetLoading(context);
   var uri = Uri.parse(APIPOSTVISIT);
    String token = await _loadAccessToken();
    var response = await http.post((uri)
    .replace(queryParameters: reqParams),headers: {"Content-Type": "application/json",
                      "Authorization": 'Bearer $token'
            });
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['qr_id'];
    }else{
      throw Exception('No es posible registrar visita.');
    }
  }
}