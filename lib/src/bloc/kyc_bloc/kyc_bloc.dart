import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_event.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_state.dart';
import 'package:invoicediscounting/src/constant/repos_constant.dart';
import 'package:invoicediscounting/src/models/pan_model.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc() : super(const KycState()) {
    on<GetDigiSessionRequested>(_onGetDigiSessionRequested);
    on<GetDigiUIStreamRequested>(_onGetDigiUIStreamRequested);
    on<PanVerificationRequested>(_onPanVerificationRequested);
  }

  final clientId = 'combatsolutions_staging';
  final clientSecret = '70uL3UhlWMEmyLT4tHT2rq21pCnEZ7Id';
  final moduleSecret = 'Mt4PPsHyIpLsyL8NgwshvdsZSZQVPcgm';
  Future<void> _onGetDigiSessionRequested(
    GetDigiSessionRequested event,
    Emitter<KycState> emit,
  ) async {
    emit(state.copyWith(status: KycStatus.loading));
    // Map<String, dynamic> jsonData = {
    //   "consent": event.consent,
    //   "consentPurpose": event.consentPurpose,
    //   "referenceId": event.referenceId,
    //   "redirectToSignup": event.redirectToSignup,
    //   "redirectUrl": event.redirectUrl,
    //   "documentConsent": event.documentConsent,
    // };
    Map<String, dynamic> jsonData = {
      "consent": true,
      "consent_purpose": "for banking purpose only",
      "reference_id": event.referenceId,
      "redirect_to_signup": true,
      "redirect_url": "https://decentro.tech",
      "documents_for_consent": ["ADHAR", "PANCR", "DRIVING_LICENSE"],
    };

    final result = await digiRepo.getDigiSession(
      clientId: clientId,
      clientSecret: clientSecret,
      moduleSecret: moduleSecret,
      jsonData: jsonData,
    );
    print('Digi Session Result: $result');
    print('Digi Session url: ${result['data']['authorizationUrl']}');

    if (result != null && result['status'] == 'SUCCESS') {
      final authUrl = result['data']['authorizationUrl'];
      print('Digi Session url: $authUrl');

      emit(state.copyWith(status: KycStatus.success, sessionUrl: authUrl));
    } else {
      print('DigiLocker init failed: ${result?['message']}');
      emit(state.copyWith(status: KycStatus.error));
    }
  }

  FutureOr<void> _onGetDigiUIStreamRequested(
    GetDigiUIStreamRequested event,
    Emitter<KycState> emit,
  ) async {
    emit(state.copyWith(status: KycStatus.loading));
    // Map<String, dynamic> jsonData = {
    //   "consent": event.consent,
    //   "consentPurpose": event.consentPurpose,
    //   "referenceId": event.referenceId,
    //   "redirectToSignup": event.redirectToSignup,
    //   "redirectUrl": event.redirectUrl,
    //   "documentConsent": event.documentConsent,
    // };
    Map<String, dynamic> jsonData = {
      "consent": true,
      "purpose": "To perform KYC of the user",
      "reference_id": event.referenceId,
      "uistream": event.uistream,
      "redirect_url": event.redirectUrl,
      "callback_url": event.callBackUrl,
    };

    final result = await digiRepo.getDigiUIStream(
      clientId: clientId,
      clientSecret: clientSecret,
      moduleSecret: moduleSecret,
      jsonData: jsonData,
    );
    print('Digi UIStream Result: $result');
    print('Digi UIStream url: ${result['data']['url']}');

    if (result != null && result['status'] == 'SUCCESS') {
      final authUrl = result['data']['url'];
      print('Digi UIStream url: $authUrl');

      emit(state.copyWith(status: KycStatus.success, sessionUrl: authUrl));
    } else {
      print('DigiLocker init failed: ${result?['message']}');
      emit(state.copyWith(status: KycStatus.error));
    }
  }

FutureOr<void> _onPanVerificationRequested(
  PanVerificationRequested event,
  Emitter<KycState> emit,
) async {
  emit(state.copyWith(
    status: KycStatus.loading,
    panKycResult: null,
    errorMessage: null,
  ));

  final Map<String, dynamic> jsonData = {
    "reference_id": event.referenceId,
    "document_type": event.documentType,
    "id_number": event.idNumber,
    "consent": event.consent,
    "consent_purpose": event.consentPurpose,
  };

  final result = await digiRepo.panVerification(
    clientId: clientId,
    clientSecret: clientSecret,
    moduleSecret: moduleSecret,
    jsonData: jsonData,
  );

  print('PAN Verification Result: $result');

  if (result == null) {
    emit(state.copyWith(
      status: KycStatus.error,
      errorMessage: 'Something went wrong. Please try again.',
    ));
    return;
  }

  /// ✅ Decentro-specific validation
  final String kycStatus = result['kycStatus'] ?? 'FAILURE';

  if (kycStatus != 'SUCCESS') {
    final error = result['error'];

    emit(state.copyWith(
      status: KycStatus.error,
      errorMessage: error?['message'] ?? 'Invalid PAN details',
      panKycResult: null,
    ));
    return;
  }

  /// ✅ Safe parsing
  final kycResult = result['kycResult'];
  if (kycResult == null || kycResult is! Map<String, dynamic>) {
    emit(state.copyWith(
      status: KycStatus.error,
      errorMessage: 'PAN data not available',
    ));
    return;
  }

  emit(
    state.copyWith(
      status: KycStatus.success,
      panKycResult: PanKycResultModel.fromJson(kycResult),
    ),
  );
}
}
