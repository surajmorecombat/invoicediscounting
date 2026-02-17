import 'package:invoicediscounting/src/network/api/api.dart';

class UserApi extends Api {
  Future<dynamic> userLogin(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/investor-login/send-otp',
        parameters: jsonData,
      );
      print('Login Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> verifyOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/investor-login/verify-otp',
        parameters: jsonData,
      );
      print('Verify OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> sendPhoneOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/send-phone-otp',
        parameters: jsonData,
      );
      print('Send Phone OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> verifyPhoneOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/verify-phone-otp',
        parameters: jsonData,
      );
      print('Verify Phone OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> sendEmailOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/send-email-otp',
        parameters: jsonData,
      );
      print('Send Email OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> verifyEmailOtp(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/verify-email-otp',
        parameters: jsonData,
      );
      print('Verify Email OTP Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> getKycProgess(jsonData) async {
    try {
      final response = await requestGet(
        path: '/investor-profiles/kyc-progress/${jsonData['sessionId']}',
        parameters: jsonData,
      );
      print('KYC Progress Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> fileUpload(String filePath) async {
    try {
      final response = await requestPostFile(
        path: '/files',
        filePath: filePath,
      );
      print('File Upload Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

  Future<dynamic> investorRegistration(jsonData) async {
    try {
      final response = await requestPost(
        path: '/auth/investor-registration',
        parameters: jsonData,
      );
      print('Investor Registration Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }

Future<dynamic> getIfsc(String ifscCode) async {
  try {
    final response = await requestGet(
      path: '/bank-details/get-by-ifsc/$ifscCode',
    );
    print('IFSC Details Response: $response');
    return response;
  } catch (e) {
    print(e);
    print('error');
    return null;
  }
}


Future<dynamic> kycBankAdd(jsonData) async {
    try {
      final response = await requestPost(
        path:'/investor-profiles/kyc-bank-details',
        parameters: jsonData,
      );
      print('Investor Bank registration Response: $response');
      return response;
    } catch (e, _) {
      print(e);
      print('error');
    }
  }
}
