import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/repos_constant.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserLoginRequested>(_onUserLoginRequested);
    on<UserVerifyOtpRequested>(_onUserVerifyOtpRequested);
    on<UserResendOtpRequested>(_onUserResendOtpRequested);
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
}
