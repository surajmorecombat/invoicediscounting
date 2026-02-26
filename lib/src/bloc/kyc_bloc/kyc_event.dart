import 'package:equatable/equatable.dart';

class KycEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDigiSessionRequested extends KycEvent {
  final bool consent;
  final String consentPurpose;
  final String referenceId;
  final bool redirectToSignup;
  final String redirectUrl;
  final List<String> documentConsent;

  GetDigiSessionRequested({
    required this.consent,
    required this.consentPurpose,
    required this.referenceId,
    required this.redirectToSignup,
    required this.redirectUrl,
    required this.documentConsent,
  });
}

class GetDigiUIStreamRequested extends KycEvent {
  final String referenceId;
  final bool consent;
  final String consentPurpose;
  final String uistream;
  final String callBackUrl;

  final String redirectUrl;

  GetDigiUIStreamRequested({
    required this.consent,
    required this.consentPurpose,
    required this.uistream,
    required this.referenceId,

    required this.redirectUrl,
    required this.callBackUrl,
  });
}

class PanVerificationRequested extends KycEvent {
  final String referenceId;
  final String documentType;
  final String idNumber;
  final String consent;
  final String consentPurpose;

  PanVerificationRequested({
    required this.referenceId,
    required this.consent,
    required this.consentPurpose,
    required this.documentType,
    required this.idNumber,
  });
}
