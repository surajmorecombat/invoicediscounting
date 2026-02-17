// class BankDetailsResponseModel {
//   final bool success;
//   final String message;
//   final BankDetailsModel bankDetails;

//   const BankDetailsResponseModel({
//     required this.success,
//     required this.message,
//     required this.bankDetails,
//   });

//   factory BankDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     return BankDetailsResponseModel(
//       success: json['success'] ?? false,
//       message: json['message']?.toString() ?? '',
//       bankDetails: BankDetailsModel.fromJson(
//         json['bankDetails'] ?? {},
//       ),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'message': message,
//       'bankDetails': bankDetails.toJson(),
//     };
//   }

//   static const empty = BankDetailsResponseModel(
//     success: false,
//     message: '',
//     bankDetails: BankDetailsModel.empty,
//   );
// }


class IfscBankDetailsModel {
  final String bankName;
  final String branchName;
  final String bankShortCode;
  final String ifscCode;
  final String bankAddress;
  final String state;
  final String district;
  final String city;

  const IfscBankDetailsModel({
    required this.bankName,
    required this.branchName,
    required this.bankShortCode,
    required this.ifscCode,
    required this.bankAddress,
    required this.state,
    required this.district,
    required this.city,
  });

  factory IfscBankDetailsModel.fromJson(Map<String, dynamic> json) {
    return IfscBankDetailsModel(
      bankName: json['bankName']?.toString() ?? '',
      branchName: json['branchName']?.toString() ?? '',
      bankShortCode: json['bankShortCode']?.toString() ?? '',
      ifscCode: json['ifscCode']?.toString() ?? '',
      bankAddress: json['bankAddress']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'branchName': branchName,
      'bankShortCode': bankShortCode,
      'ifscCode': ifscCode,
      'bankAddress': bankAddress,
      'state': state,
      'district': district,
      'city': city,
    };
  }

  static const empty = IfscBankDetailsModel(
    bankName: '',
    branchName: '',
    bankShortCode: '',
    ifscCode: '',
    bankAddress: '',
    state: '',
    district: '',
    city: '',
  );
}
