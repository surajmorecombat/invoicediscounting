import 'package:equatable/equatable.dart';
import 'package:invoicediscounting/src/models/bank_add_model.dart';
import 'package:invoicediscounting/src/models/ifsc_model.dart';
import 'package:invoicediscounting/src/models/profile_model.dart';

enum KycDocType { pan, aadhaarFront, aadhaarBack, selfie ,bankPassbook,bankCheque}

enum UserStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  sendingOtp,
  otpSent,
  otperror,
  resendingOtp,
  resendedOtp,
  mobileOtpSent,
  otpVerified,
  emailOtpSent,
  emailOtpVerified,
  success,
  failed,
  kycProgressLoaded,
  kycRegistered,
  kycNotRegistered,
  sendingData,
  ifscfetched,
  ifscfetchError,
  bankAdded,
  bankAddFailed,
  kycProgessed,
  kycProgressError,
}

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;
  final String? uploadedImageUrl;
  final String? panImageUrl;
  final String? aadhaarFrontImageUrl;
  final String? aadhaarBackImageUrl;
  final String? selfieImageUrl;
  final String? bankPassbookImageUrl;
  final String? bankChequeImageUrl;




   final String? panDocId;
  final String? aadhaarFrontDocId;
  final String? aadhaarBackDocId;
  final String? selfieDocId;
  final String? bankPassbookDocId;
  final String? bankChequeDocId;
    final IfscBankDetailsModel? ifscBankDetails;
    final CreateBankAccountModel? createBankAccountResponse;
    final CreateProfileModel? createProfileResponse;

  const UserState({
    this.status = UserStatus.initial,
    this.errorMessage,
    this.uploadedImageUrl,
    this.panImageUrl,
    this.aadhaarFrontImageUrl,
    this.aadhaarBackImageUrl,
    this.panDocId,
    this.aadhaarFrontDocId,
    this.aadhaarBackDocId,
    this.selfieImageUrl,
    this.selfieDocId,
    this.bankPassbookImageUrl,
    this.bankChequeImageUrl,
    this.bankPassbookDocId,
    this.bankChequeDocId,
    this.ifscBankDetails,
    this.createBankAccountResponse = CreateBankAccountModel.empty,
    this.createProfileResponse = CreateProfileModel.empty,
  });

  UserState copyWith({
    UserStatus? status,
    String? errorMessage,
    String? uploadedImageUrl,
    String? panImageUrl,
    String? aadhaarFrontImageUrl,
    String? aadhaarBackImageUrl,
    String? panDocId,
    String? aadhaarFrontDocId,
    String? aadhaarBackDocId,
    String? selfieImageUrl,
    String? selfieDocId,
    String? bankPassbookImageUrl,
    String? bankChequeImageUrl,
    String? bankPassbookDocId,
    String? bankChequeDocId,
    IfscBankDetailsModel? ifscBankDetails,
    CreateBankAccountModel? createBankAccountResponse,
    CreateProfileModel? createProfileResponse,
  }) {
    return UserState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      uploadedImageUrl: uploadedImageUrl ?? this.uploadedImageUrl,
      panImageUrl: panImageUrl ?? this.panImageUrl,
      aadhaarFrontImageUrl: aadhaarFrontImageUrl ?? this.aadhaarFrontImageUrl,
      aadhaarBackImageUrl: aadhaarBackImageUrl ?? this.aadhaarBackImageUrl,
      panDocId: panDocId ?? this.panDocId,
      aadhaarFrontDocId: aadhaarFrontDocId ?? this.aadhaarFrontDocId,
      aadhaarBackDocId: aadhaarBackDocId ?? this.aadhaarBackDocId,
      selfieImageUrl: selfieImageUrl ?? this.selfieImageUrl,
      selfieDocId: selfieDocId ?? this.selfieDocId,
      bankPassbookImageUrl: bankPassbookImageUrl ?? this.bankPassbookImageUrl,
      bankChequeImageUrl: bankChequeImageUrl ?? this.bankChequeImageUrl,
      bankPassbookDocId: bankPassbookDocId ?? this.bankPassbookDocId,
      bankChequeDocId: bankChequeDocId ?? this.bankChequeDocId,
      ifscBankDetails: ifscBankDetails ?? this.ifscBankDetails,
      createBankAccountResponse: createBankAccountResponse ?? this.createBankAccountResponse,
      createProfileResponse: createProfileResponse ?? this.createProfileResponse,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    uploadedImageUrl,
    panImageUrl,
    aadhaarFrontImageUrl,
    aadhaarBackImageUrl,
    panDocId,
    aadhaarFrontDocId,
    aadhaarBackDocId,
    selfieImageUrl,
    selfieDocId,
    bankPassbookImageUrl,
    bankChequeImageUrl,
    bankPassbookDocId,
    bankChequeDocId,
    ifscBankDetails,
    createBankAccountResponse,
    createProfileResponse,
  ];
}
