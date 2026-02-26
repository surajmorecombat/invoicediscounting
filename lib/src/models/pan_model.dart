class PanKycResultModel {
  final String idNumber;
  final String idStatus;
  final String panStatus;
  final String panType;
  final String category;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String idHolderTitle;
  final String fatherName;
  final String idLastUpdated;
  final String aadhaarSeedingStatus;
  final String maskedAadhaar;

  const PanKycResultModel({
    required this.idNumber,
    required this.idStatus,
    required this.panStatus,
    required this.panType,
    required this.category,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.idHolderTitle,
    required this.fatherName,
    required this.idLastUpdated,
    required this.aadhaarSeedingStatus,
    required this.maskedAadhaar,
  });

  factory PanKycResultModel.fromJson(Map<String, dynamic> json) {
    return PanKycResultModel(
      idNumber: json['idNumber']?.toString() ?? '',
      idStatus: json['idStatus']?.toString() ?? '',
      panStatus: json['panStatus']?.toString() ?? '',
      panType: json['panType']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      middleName: json['middleName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      idHolderTitle: json['idHolderTitle']?.toString() ?? '',
      fatherName: json['fatherName']?.toString() ?? '',
      idLastUpdated: json['idLastUpdated']?.toString() ?? '',
      aadhaarSeedingStatus:
          json['aadhaarSeedingStatus']?.toString() ?? '',
      maskedAadhaar: json['maskedAadhaar']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNumber': idNumber,
      'idStatus': idStatus,
      'panStatus': panStatus,
      'panType': panType,
      'category': category,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'fullName': fullName,
      'idHolderTitle': idHolderTitle,
      'fatherName': fatherName,
      'idLastUpdated': idLastUpdated,
      'aadhaarSeedingStatus': aadhaarSeedingStatus,
      'maskedAadhaar': maskedAadhaar,
    };
  }

  static const empty = PanKycResultModel(
    idNumber: '',
    idStatus: '',
    panStatus: '',
    panType: '',
    category: '',
    firstName: '',
    middleName: '',
    lastName: '',
    fullName: '',
    idHolderTitle: '',
    fatherName: '',
    idLastUpdated: '',
    aadhaarSeedingStatus: '',
    maskedAadhaar: '',
  );
}