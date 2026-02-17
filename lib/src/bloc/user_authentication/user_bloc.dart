import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/repos_constant.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/models/bank_add_model.dart';
import 'package:invoicediscounting/src/models/ifsc_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserLoginRequested>(_onUserLoginRequested);
    on<UserVerifyOtpRequested>(_onUserVerifyOtpRequested);
    on<UserResendOtpRequested>(_onUserResendOtpRequested);
    on<UserPhoneOtpRequested>(_onUserPhoneOtpRequested);
    on<UserPhoneOtpVerified>(_onUserPhoneOtpVerified);
    on<UserEmailOtpRequested>(_onUserEmailOtpRequested);
    on<UserEmailOtpVerified>(_onUserEmailOtpVerified);
    on<UserKycProgressRequested>(_onUserKycProgressRequested);
    on<UserFileUploadRequested>(_onUserFileUploadRequested);
    on<UserImageCleared>(_onUserImageCleared);
    on<InvestorRegistrationRequested>(_onInvestorRegistrationRequested);
    on<IfscDetailsRequested>(_onIfscDetailsRequested);
    on<InvestorBankAddRequested>(_onInvestorBankAddRequested);
  }

  void _onUserImageCleared(UserImageCleared event, Emitter<UserState> emit) {
    switch (event.docType) {
      case KycDocType.pan:
        emit(state.copyWith(panImageUrl: null));
        break;

      case KycDocType.aadhaarFront:
        emit(state.copyWith(aadhaarFrontImageUrl: null));
        break;

      case KycDocType.aadhaarBack:
        emit(state.copyWith(aadhaarBackImageUrl: null));
        break;
      case KycDocType.selfie:
        emit(state.copyWith(selfieImageUrl: null, selfieDocId: null));
        break;

      case KycDocType.bankPassbook:
        emit(
          state.copyWith(bankPassbookImageUrl: null, bankPassbookDocId: null),
        );
        break;
      case KycDocType.bankCheque:
        emit(state.copyWith(bankChequeImageUrl: null, bankChequeDocId: null));
        break;
    }
  }

  FutureOr<void> _onUserLoginRequested(
    UserLoginRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.sendingOtp));
    try {
      Map<String, Object> jsonData = {
        "emailOrPhone": event.emailOrPhoneNumber,
        "rememberMe": event.rememberMe,
      };
      print('login formdata $jsonData');
      final result = await userRepository.userLogin(jsonData);
      print('login result $result');

      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.otpSent));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.otperror,
            errorMessage: result['message'] ?? 'Login failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserResendOtpRequested(
    UserResendOtpRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.resendingOtp));
    try {
      Map<String, Object> jsonData = {
        "emailOrPhone": event.emailOrPhoneNumber,
        "rememberMe": event.rememberMe,
      };
      print('login formdata $jsonData');
      final result = await userRepository.userLogin(jsonData);
      print('login result $result');

      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.resendedOtp));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.otperror,
            errorMessage: result['message'] ?? 'Login failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserVerifyOtpRequested(
    UserVerifyOtpRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      Map<String, Object> jsonData = {
        "emailOrPhone": event.emailOrPhoneNumber,
        "otp": event.otp,
        "rememberMe": event.rememberMe,
      };
      print('verify otp formdata $jsonData');
      final result = await userRepository.verifyOtp(jsonData);
      print('verify otp result $result');

      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.authenticated));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.unauthenticated,
            errorMessage: result['message'] ?? 'OTP verification failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserPhoneOtpRequested(
    UserPhoneOtpRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.sendingOtp));
    try {
      Map<String, Object> jsonData = {
        "phone": event.phoneNumber,
        "role": event.role,
      };
      print('send phone otp formdata $jsonData');
      final result = await userRepository.sendPhoneOtp(jsonData);
      print('send phone otp result $result');

      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.mobileOtpSent));
        await storage.write(
          key: 'sessionId',
          value: result['sessionId']?.toString() ?? '',
        );
      } else {
        emit(
          state.copyWith(
            status: UserStatus.otperror,
            errorMessage: result['message'] ?? 'Failed to send OTP',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserPhoneOtpVerified(
    UserPhoneOtpVerified event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      String? sessionId = await storage.read(key: 'sessionId');
      Map<String, Object> jsonData = {
        "otp": event.otp,
        "sessionId": sessionId ?? '',
      };
      final result = await userRepository.verifyPhoneOtp(jsonData);
      print('verify phone otp result $result');
      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.otpVerified));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.unauthenticated,
            errorMessage: result['message'] ?? 'OTP verification failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserEmailOtpRequested(
    UserEmailOtpRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.sendingOtp));
    try {
      Map<String, Object> jsonData = {
        "email": event.email,
        "sessionId": event.sessionId,
      };
      print('send email otp formdata $jsonData');
      final result = await userRepository.sendEmailOtp(jsonData);
      print('send email otp result $result');

      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.emailOtpSent));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.otperror,
            errorMessage: result['message'] ?? 'Failed to send OTP',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserEmailOtpVerified(
    UserEmailOtpVerified event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      String? sessionId = await storage.read(key: 'sessionId');
      Map<String, Object> jsonData = {
        "otp": event.otp,
        "sessionId": sessionId ?? event.sessionId,
      };
      final result = await userRepository.verifyEmailOtp(jsonData);
      print('verify email otp result $result');
      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.emailOtpVerified));
      } else {
        emit(
          state.copyWith(
            status: UserStatus.unauthenticated,
            errorMessage: result['message'] ?? 'OTP verification failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserKycProgressRequested(
    UserKycProgressRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      String? sessionId = await storage.read(key: 'sessionId');
      Map<String, Object> jsonData = {
        "sessionId": sessionId ?? event.sessionId,
      };
      final result = await userRepository.getKycProgess(jsonData);
      print('get kyc progress result $result');
      final success = result['success'] ?? false;
      if (success) {
        emit(
          state.copyWith(
            status: UserStatus.success,
            // kycProgress: result['kycProgress'] ?? 0,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UserStatus.error,
            errorMessage: result['message'] ?? 'Failed to load KYC progress',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onUserFileUploadRequested(
    UserFileUploadRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final result = await userRepository.fileUpload(event.filePath);

      final files = result['files'] as List?;
      if (files == null || files.isEmpty) {
        emit(
          state.copyWith(
            status: UserStatus.failed,
            errorMessage: 'Invalid upload response',
          ),
        );
        return;
      }

      final String uploadedUrl = files.first['fileUrl'];
      final String uploadedDocId = files.first['id'];
      print('File uploaded Doc ID: $uploadedDocId');

      switch (event.docType) {
        case KycDocType.pan:
          print('File uploaded Pan Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              panImageUrl: uploadedUrl,
              status: UserStatus.success,
              panDocId: uploadedDocId,
            ),
          );
          break;

        case KycDocType.aadhaarFront:
          print('File uploaded Adhar Front Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              aadhaarFrontImageUrl: uploadedUrl,
              status: UserStatus.success,
              aadhaarFrontDocId: uploadedDocId,
            ),
          );
          break;

        case KycDocType.aadhaarBack:
          print('File uploaded Adhar Back Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              aadhaarBackImageUrl: uploadedUrl,
              status: UserStatus.success,
              aadhaarBackDocId: uploadedDocId,
            ),
          );
          break;
        case KycDocType.selfie:
          print('File uploaded Selfie Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              selfieImageUrl: uploadedUrl,
              status: UserStatus.success,
              selfieDocId: uploadedDocId,
            ),
          );
          break;
        case KycDocType.bankPassbook:
          print('File uploaded Bank Passbook Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              bankPassbookImageUrl: uploadedUrl,
              status: UserStatus.success,
              bankPassbookDocId: uploadedDocId,
            ),
          );
          break;
        case KycDocType.bankCheque:
          print('File uploaded Bank Cheque Doc ID: $uploadedDocId');
          emit(
            state.copyWith(
              bankChequeImageUrl: uploadedUrl,
              status: UserStatus.success,
              bankChequeDocId: uploadedDocId,
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onInvestorRegistrationRequested(
    InvestorRegistrationRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.sendingData));

    try {
      final result = await userRepository.investorRegistration(event.formData);
      final success = result['success'] ?? false;

      if (success) {
        emit(state.copyWith(status: UserStatus.kycRegistered));
        await storage.write(
          key: 'usersId',
          value: result['usersId']?.toString() ?? '',
        );
      } else {
        emit(
          state.copyWith(
            status: UserStatus.kycNotRegistered,
            errorMessage: result['message'] ?? 'Registration failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onIfscDetailsRequested(
    IfscDetailsRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final result = await userRepository.getIfsc(event.ifscCode);

      final success = result['success'] ?? false;

      final ifscData = IfscBankDetailsModel.fromJson(
        result['bankDetails'] ?? {},
      );

      if (success) {
        emit(
          state.copyWith(
            status: UserStatus.ifscfetched,
            ifscBankDetails: ifscData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UserStatus.ifscfetchError,
            ifscBankDetails: IfscBankDetailsModel.empty,
            errorMessage: result['message'] ?? 'Failed to fetch IFSC details',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onInvestorBankAddRequested(
    InvestorBankAddRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.sendingData));

    try {
      final result = await userRepository.kycBankAdd(event.formData);
      final success = result['success'] ?? false;

      if (success) {
        emit(
          state.copyWith(
            status: UserStatus.bankAdded,
            createBankAccountResponse: CreateBankAccountModel.fromJson(result),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UserStatus.bankAddFailed,
            createBankAccountResponse: CreateBankAccountModel.empty,
            errorMessage: result['message'] ?? 'Bank details submission failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
