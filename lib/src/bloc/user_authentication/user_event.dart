import 'package:equatable/equatable.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';

class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginRequested extends UserEvent {
  final String emailOrPhoneNumber;
  final bool rememberMe;

  UserLoginRequested(this.emailOrPhoneNumber, this.rememberMe);

  @override
  List<Object?> get props => [emailOrPhoneNumber, rememberMe];
}

class UserResendOtpRequested extends UserEvent {
  final String emailOrPhoneNumber;
  final bool rememberMe;

  UserResendOtpRequested(this.emailOrPhoneNumber, this.rememberMe);

  @override
  List<Object?> get props => [emailOrPhoneNumber, rememberMe];
}

class UserVerifyOtpRequested extends UserEvent {
  final String emailOrPhoneNumber;
  final String otp;
  final bool rememberMe;

  UserVerifyOtpRequested(this.emailOrPhoneNumber, this.otp, this.rememberMe);

  @override
  List<Object?> get props => [emailOrPhoneNumber, otp, rememberMe];
}

class UserPhoneOtpRequested extends UserEvent {
  final String phoneNumber;
  final String role;

  UserPhoneOtpRequested(this.phoneNumber, this.role);

  @override
  List<Object?> get props => [phoneNumber, role];
}

class UserPhoneOtpVerified extends UserEvent {
  final String otp;
  final String sessionId;

  UserPhoneOtpVerified(this.otp, this.sessionId);

  @override
  List<Object?> get props => [otp, sessionId];
}

class UserEmailOtpRequested extends UserEvent {
  final String email;
  final String sessionId;

  UserEmailOtpRequested(this.email, this.sessionId);

  @override
  List<Object?> get props => [email, sessionId];
}

class UserEmailOtpVerified extends UserEvent {
  final String otp;
  final String sessionId;

  UserEmailOtpVerified(this.otp, this.sessionId);

  @override
  List<Object?> get props => [otp, sessionId];
}

class UserKycProgressRequested extends UserEvent {
  final String sessionId;

  UserKycProgressRequested(this.sessionId);

  @override
  List<Object?> get props => [sessionId];
}

class UserFileUploadRequested extends UserEvent {
  final String filePath;
  final KycDocType docType;

  UserFileUploadRequested({required this.filePath, required this.docType});

  @override
  List<Object?> get props => [filePath, docType];
}

class UserImageCleared extends UserEvent {
  final KycDocType docType;
  UserImageCleared(this.docType);

  @override
  List<Object?> get props => [docType];
}

class InvestorRegistrationRequested extends UserEvent {
  final Map<String, dynamic>? formData;

  InvestorRegistrationRequested({this.formData});

  @override
  List<Object?> get props => [formData];
}

class IfscDetailsRequested extends UserEvent {
  final String ifscCode;

  IfscDetailsRequested(this.ifscCode);

  @override
  List<Object?> get props => [ifscCode];
}

class InvestorBankAddRequested extends UserEvent {
  final Map<String, dynamic>? formData;

  InvestorBankAddRequested({this.formData});

  @override
  List<Object?> get props => [formData];
}

