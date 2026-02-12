import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:invoicediscounting/src/constant/api_constant.dart';

class Api {
  final _protocol = ApiConst.baseUrl;

  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> requestPost({
    required String? path,
    dynamic parameters,
  }) async {
    print('================================');
    print('API Request - POST');
    print('Base URL: $_protocol');
    print('Path: $path');
    print('Full URL: $_protocol$path');
    print('Request Headers: $_defaultHeaders');
    print('Request Body: ${jsonEncode(parameters)}');
    print('================================');

    final dio = Dio(
      BaseOptions(
        baseUrl: _protocol,
        headers: _defaultHeaders,
        responseType: ResponseType.json,
        contentType: 'application/json',
      ),
    );

    try {
      final response = await dio.post(path!, data: parameters);

      print('================================');
      print('API Response - Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('================================');

      if (response.data != null) {
        return response.data;
      }

      return {};
    } on DioError catch (e) {
      print('================================');
      print('API Error - ${e.type}');
      print('Error Message: ${e.message}');
      print('Error Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      print('================================');

      if (e.response?.data != null) return e.response?.data;
      return {'error': true, 'message': e.message};
    }
  }
}
