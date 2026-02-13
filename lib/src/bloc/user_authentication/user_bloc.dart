import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/repos_constant.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserLoginRequested>(_onUserLoginRequested);
    on<UserVerifyOtpRequested>(_onUserVerifyOtpRequested);
    on<UserResendOtpRequested>(_onUserResendOtpRequested);
    on<UserPhoneOtpRequested>(_onUserPhoneOtpRequested);
    on<UserPhoneOtpVerified>(_onUserPhoneOtpVerified);
    on<UserEmailOtpRequested>(_onUserEmailOtpRequested);
    on<UserEmailOtpVerified>(_onUserEmailOtpVerified);
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
        emit(state.copyWith(status: UserStatus.mobileOtpSent,
       
        ));
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
}
