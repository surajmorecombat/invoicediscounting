import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
class ConnectionService {
  late final InternetConnection _connection;

  ConnectionService() {
    _connection = InternetConnection.createInstance(
      customConnectivityCheck: (option) async {
        try {
          final dio = Dio();
          final response = await dio.head(
            option.uri.toString(),
            options: Options(
              headers: option.headers,
              receiveTimeout: option.timeout,
              validateStatus: (_) => true,
            ),
          );

          return InternetCheckResult(
            option: option,
            isSuccess: response.statusCode == 200,
          );
        } catch (_) {
          return InternetCheckResult(
            option: option,
            isSuccess: false,
          );
        }
      },
    );
  }

  Stream<InternetStatus> get onStatusChange =>
      _connection.onStatusChange;

  Future<bool> get hasInternet =>
      _connection.hasInternetAccess;

    
}
