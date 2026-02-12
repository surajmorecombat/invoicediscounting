import 'package:invoicediscounting/src/network/api/user_api.dart';

class UserRepository {
  final UserApi userApi = UserApi();

  Future<dynamic> userLogin(jsonData) async {
    return await userApi.userLogin(jsonData);
  }

  
   Future<dynamic> verifyOtp(jsonData) async {
    return await userApi.verifyOtp(jsonData);
  }
}
