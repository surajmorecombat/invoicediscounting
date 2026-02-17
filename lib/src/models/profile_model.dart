class CreateProfileModel {
  final bool success;
  final String message;
  final List<String> currentProgress;
  final InvestorProfileModel profile;

  const CreateProfileModel({
    required this.success,
    required this.message,
    required this.currentProgress,
    required this.profile,
  });

  factory CreateProfileModel.fromJson(Map<String, dynamic> json) {
    return CreateProfileModel(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? '',
      currentProgress:
          (json['currentProgress'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      profile: InvestorProfileModel.fromJson(json['profile'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'currentProgress': currentProgress,
      'profile': profile.toJson(),
    };
  }

  static const empty = CreateProfileModel(
    success: false,
    message: '',
    currentProgress: [],
    profile: InvestorProfileModel.empty,
  );
}

class InvestorProfileModel {
  final String id;
  final String fullName;
  final String gender;
  final String kycMode;
  final String aadharFrontImageId;
  final String aadharBackImageId;
  final String selfieId;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String usersId;
  final String kycApplicationsId;

  final FileModel aadharFrontImage;
  final FileModel aadharBackImage;
  final FileModel selfie;
  final InvestorPanCardModel investorPanCards;
  final UserMiniModel users;
  final KycApplicationMiniModel kycApplications;

  const InvestorProfileModel({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.kycMode,
    required this.aadharFrontImageId,
    required this.aadharBackImageId,
    required this.selfieId,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.usersId,
    required this.kycApplicationsId,
    required this.aadharFrontImage,
    required this.aadharBackImage,
    required this.selfie,
    required this.investorPanCards,
    required this.users,
    required this.kycApplications,
  });

  factory InvestorProfileModel.fromJson(Map<String, dynamic> json) {
    return InvestorProfileModel(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      kycMode: json['kycMode']?.toString() ?? '',
      aadharFrontImageId: json['aadharFrontImageId']?.toString() ?? '',
      aadharBackImageId: json['aadharBackImageId']?.toString() ?? '',
      selfieId: json['selfieId']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      usersId: json['usersId']?.toString() ?? '',
      kycApplicationsId: json['kycApplicationsId']?.toString() ?? '',
      aadharFrontImage: FileModel.fromJson(json['aadharFrontImage'] ?? {}),
      aadharBackImage: FileModel.fromJson(json['aadharBackImage'] ?? {}),
      selfie: FileModel.fromJson(json['selfie'] ?? {}),
      investorPanCards: InvestorPanCardModel.fromJson(
        json['investorPanCards'] ?? {},
      ),
      users: UserMiniModel.fromJson(json['users'] ?? {}),
      kycApplications: KycApplicationMiniModel.fromJson(
        json['kycApplications'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'kycMode': kycMode,
      'aadharFrontImageId': aadharFrontImageId,
      'aadharBackImageId': aadharBackImageId,
      'selfieId': selfieId,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'usersId': usersId,
      'kycApplicationsId': kycApplicationsId,
      'aadharFrontImage': aadharFrontImage.toJson(),
      'aadharBackImage': aadharBackImage.toJson(),
      'selfie': selfie.toJson(),
      'investorPanCards': investorPanCards.toJson(),
      'users': users.toJson(),
      'kycApplications': kycApplications.toJson(),
    };
  }

  static const empty = InvestorProfileModel(
    id: '',
    fullName: '',
    gender: '',
    kycMode: '',
    aadharFrontImageId: '',
    aadharBackImageId: '',
    selfieId: '',
    isActive: false,
    isDeleted: false,
    createdAt: '',
    updatedAt: '',
    usersId: '',
    kycApplicationsId: '',
    aadharFrontImage: FileModel.empty,
    aadharBackImage: FileModel.empty,
    selfie: FileModel.empty,
    investorPanCards: InvestorPanCardModel.empty,
    users: UserMiniModel.empty,
    kycApplications: KycApplicationMiniModel.empty,
  );
}

class FileModel {
  final String id;
  final String fileOriginalName;
  final String fileUrl;
  final String fileType;

  const FileModel({
    required this.id,
    required this.fileOriginalName,
    required this.fileUrl,
    required this.fileType,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id']?.toString() ?? '',
      fileOriginalName: json['fileOriginalName']?.toString() ?? '',
      fileUrl: json['fileUrl']?.toString() ?? '',
      fileType: json['fileType']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileOriginalName': fileOriginalName,
      'fileUrl': fileUrl,
      'fileType': fileType,
    };
  }

  static const empty = FileModel(
    id: '',
    fileOriginalName: '',
    fileUrl: '',
    fileType: '',
  );
}

class InvestorPanCardModel {
  final String id;
  final String submittedPanNumber;
  final String submittedInvestorName;
  final String submittedDateOfBirth;
  final int status;
  final int mode;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String panCardDocumentId;
  final FileModel panCardDocument;

  const InvestorPanCardModel({
    required this.id,
    required this.submittedPanNumber,
    required this.submittedInvestorName,
    required this.submittedDateOfBirth,
    required this.status,
    required this.mode,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.panCardDocumentId,
    required this.panCardDocument,
  });

  factory InvestorPanCardModel.fromJson(Map<String, dynamic> json) {
    return InvestorPanCardModel(
      id: json['id']?.toString() ?? '',
      submittedPanNumber: json['submittedPanNumber']?.toString() ?? '',
      submittedInvestorName: json['submittedInvestorName']?.toString() ?? '',
      submittedDateOfBirth: json['submittedDateOfBirth']?.toString() ?? '',
      status: json['status'] ?? 0,
      mode: json['mode'] ?? 0,
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      panCardDocumentId: json['panCardDocumentId']?.toString() ?? '',
      panCardDocument: FileModel.fromJson(json['panCardDocument'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'submittedPanNumber': submittedPanNumber,
      'submittedInvestorName': submittedInvestorName,
      'submittedDateOfBirth': submittedDateOfBirth,
      'status': status,
      'mode': mode,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'panCardDocumentId': panCardDocumentId,
      'panCardDocument': panCardDocument.toJson(),
    };
  }

  static const empty = InvestorPanCardModel(
    id: '',
    submittedPanNumber: '',
    submittedInvestorName: '',
    submittedDateOfBirth: '',
    status: 0,
    mode: 0,
    isActive: false,
    isDeleted: false,
    createdAt: '',
    updatedAt: '',
    panCardDocumentId: '',
    panCardDocument: FileModel.empty,
  );
}

class UserMiniModel {
  final String id;
  final String email;
  final String phone;

  const UserMiniModel({
    required this.id,
    required this.email,
    required this.phone,
  });

  factory UserMiniModel.fromJson(Map<String, dynamic> json) {
    return UserMiniModel(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'phone': phone};
  }

  static const empty = UserMiniModel(id: '', email: '', phone: '');
}

class KycApplicationMiniModel {
  final String id;
  final int status;

  const KycApplicationMiniModel({required this.id, required this.status});

  factory KycApplicationMiniModel.fromJson(Map<String, dynamic> json) {
    return KycApplicationMiniModel(
      id: json['id']?.toString() ?? '',
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'status': status};
  }

  static const empty = KycApplicationMiniModel(id: '', status: 0);
}
