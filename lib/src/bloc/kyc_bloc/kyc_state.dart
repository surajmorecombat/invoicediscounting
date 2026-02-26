import 'package:equatable/equatable.dart';
import 'package:invoicediscounting/src/models/pan_model.dart';

enum KycStatus { initial, loading, error, success }

class KycState extends Equatable {
  final KycStatus status;
   final String? sessionUrl;
   final PanKycResultModel? panKycResult;
     final String? errorMessage;

  const KycState({this.status = KycStatus.initial, this.sessionUrl, this.panKycResult, this.errorMessage});

  KycState copyWith({KycStatus? status, String? sessionUrl, PanKycResultModel? panKycResult, String? errorMessage}) {
    return KycState(status: status ?? this.status, sessionUrl: sessionUrl ?? this.sessionUrl, panKycResult: panKycResult ?? this.panKycResult, errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, sessionUrl, panKycResult, errorMessage];
}
