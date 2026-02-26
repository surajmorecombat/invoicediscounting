import 'package:invoicediscounting/src/network/api/api.dart';

class DigiApi extends Api {
  Future<dynamic> getDigiSession({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    try {
      final response = await requestPostDecentro(
        path: 'v2/kyc/digilocker/initiate_session',
        clientId: clientId,
        clientSecret: clientSecret,
        moduleSecret: moduleSecret,
        parameters: jsonData,
      );
      print('digi Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> getDigiUIStream({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    try {
      final response = await requestPostDecentro(
        path: 'v2/common/uistream/session',
        clientId: clientId,
        clientSecret: clientSecret,
        moduleSecret: moduleSecret,
        parameters: jsonData,
      );
      print('digi Response ui stream: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> panVerification({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    try {
      final response = await requestPostDecentro(
        path: 'kyc/public_registry/validate',
        clientId: clientId,
        clientSecret: clientSecret,
        moduleSecret: moduleSecret,
        parameters: jsonData,
      );
      print('digi Response pan verification: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }
}
