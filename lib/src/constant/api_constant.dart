import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConst{
  static final String apiProtocol = dotenv.env['API_PROTOCOL'] ?? 'http';
  static final String host = dotenv.env['API_HOST'] ?? 'localhost';
  static String get baseUrl => '$apiProtocol://$host';

}