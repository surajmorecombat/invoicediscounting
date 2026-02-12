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
