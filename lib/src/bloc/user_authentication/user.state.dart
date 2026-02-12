import 'package:equatable/equatable.dart';

enum UserStatus { initial, loading, authenticated, unauthenticated, error,sendingOtp, otpSent,otperror ,resendingOtp,resendedOtp}

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;

  const UserState({this.status = UserStatus.initial, this.errorMessage});

  UserState copyWith({UserStatus? status, String? errorMessage}) {
    return UserState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
