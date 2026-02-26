import 'package:invoicediscounting/src/network/api/digi_api.dart';

class DigiRepo {
  final DigiApi _digiApi = DigiApi();

  Future<dynamic> getDigiSession({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    return await _digiApi.getDigiSession(
      clientId: clientId,
      clientSecret: clientSecret,
      moduleSecret: moduleSecret,
      jsonData: jsonData,
    );
  }

  //getDigiUIStream

  Future<dynamic> getDigiUIStream({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    return await _digiApi.getDigiUIStream(
      clientId: clientId,
      clientSecret: clientSecret,
      moduleSecret: moduleSecret,
      jsonData: jsonData,
    );
  }

  Future<dynamic> panVerification({
    required String clientId,
    required String clientSecret,
    required String moduleSecret,
    jsonData,
  }) async {
    return await _digiApi.panVerification(
      clientId: clientId,
      clientSecret: clientSecret,
      moduleSecret: moduleSecret,
      jsonData: jsonData,
    );
  }
}
