class CreateBankAccountModel {
  final bool success;
  final String message;
  final BankAccountModel account;
  final List<String> currentProgress;

  const CreateBankAccountModel({
    required this.success,
    required this.message,
    required this.account,
    required this.currentProgress,
  });

        factory CreateBankAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateBankAccountModel(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? '',
      account: BankAccountModel.fromJson(json['account'] ?? {}),
      currentProgress:
          (json['currentProgress'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'account': account.toJson(),
      'currentProgress': currentProgress,
    };
  }

  static const empty = CreateBankAccountModel(
    success: false,
    message: '',
    account: BankAccountModel.empty,
    currentProgress: [],
  );
}

class BankAccountModel {
  final String id;
  final String bankName;
  final String bankShortCode;
  final String ifscCode;
  final String branchName;
  final String bankAddress;
  final int accountType;
  final String accountHolderName;
  final String accountNumber;
  final int bankAccountProofType;
  final String bankAccountProofId;
  final String usersId;
  final String roleValue;
  final int status;
  final int mode;
  final bool isPrimary;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const BankAccountModel({
    required this.id,
    required this.bankName,
    required this.bankShortCode,
    required this.ifscCode,
    required this.branchName,
    required this.bankAddress,
    required this.accountType,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankAccountProofType,
    required this.bankAccountProofId,
    required this.usersId,
    required this.roleValue,
    required this.status,
    required this.mode,
    required this.isPrimary,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id']?.toString() ?? '',
      bankName: json['bankName']?.toString() ?? '',
      bankShortCode: json['bankShortCode']?.toString() ?? '',
      ifscCode: json['ifscCode']?.toString() ?? '',
      branchName: json['branchName']?.toString() ?? '',
      bankAddress: json['bankAddress']?.toString() ?? '',
      accountType: json['accountType'] ?? 0,
      accountHolderName: json['accountHolderName']?.toString() ?? '',
      accountNumber: json['accountNumber']?.toString() ?? '',
      bankAccountProofType: json['bankAccountProofType'] ?? 0,
      bankAccountProofId: json['bankAccountProofId']?.toString() ?? '',
      usersId: json['usersId']?.toString() ?? '',
      roleValue: json['roleValue']?.toString() ?? '',
      status: json['status'] ?? 0,
      mode: json['mode'] ?? 0,
      isPrimary: json['isPrimary'] ?? false,
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankName': bankName,
      'bankShortCode': bankShortCode,
      'ifscCode': ifscCode,
      'branchName': branchName,
      'bankAddress': bankAddress,
      'accountType': accountType,
      'accountHolderName': accountHolderName,
      'accountNumber': accountNumber,
      'bankAccountProofType': bankAccountProofType,
      'bankAccountProofId': bankAccountProofId,
      'usersId': usersId,
      'roleValue': roleValue,
      'status': status,
      'mode': mode,
      'isPrimary': isPrimary,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static const empty = BankAccountModel(
    id: '',
    bankName: '',
    bankShortCode: '',
    ifscCode: '',
    branchName: '',
    bankAddress: '',
    accountType: 0,
    accountHolderName: '',
    accountNumber: '',
    bankAccountProofType: 0,
    bankAccountProofId: '',
    usersId: '',
    roleValue: '',
    status: 0,
    mode: 0,
    isPrimary: false,
    isActive: false,
    isDeleted: false,
    createdAt: '',
    updatedAt: '',
  );
}
