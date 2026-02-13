import 'package:equatable/equatable.dart';

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
