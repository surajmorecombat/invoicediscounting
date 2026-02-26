import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/modules/signUp/create_email.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class EnterMobileNumber extends StatefulWidget {
  const EnterMobileNumber({super.key});

  @override
  State<EnterMobileNumber> createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isMobileOtpComplete => mobileOtpController.text.trim().length == 4;
  final TextEditingController mobileOtpController = TextEditingController();
  final FocusNode mobileOtpFocusNode = FocusNode();
  final ValueNotifier<int> _mobileRemainingSecondsNotifier = ValueNotifier(0);
  final ValueNotifier<bool> _isMobileResendActiveNotifier = ValueNotifier(true);
  Timer? _mobileCountdownTimer;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: onboardingTitleColor),
    ),
  );

  @override
  void dispose() {
    _mobileController.dispose();
    mobileOtpController.dispose();
    mobileOtpFocusNode.dispose();
    _mobileCountdownTimer?.cancel();
    _mobileRemainingSecondsNotifier.dispose();
    _isMobileResendActiveNotifier.dispose();
    super.dispose();
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  Future<void> _submitMobileNumber() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      mobileOtpController.clear();
    });

    BlocProvider.of<UserBloc>(
      context,
    ).add(UserPhoneOtpRequested(_mobileController.text.trim(), "investor"));

    if (mounted) {
      // Wait for bloc to emit state change before opening bottom sheet
      await Future.delayed(Duration(milliseconds: 100));
      
      _startMobileCountdownTimer();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return _buildOtpBottomSheet(setState);
            },
          );
        },
      ).whenComplete(() {
        _mobileCountdownTimer?.cancel();
        mobileOtpController.clear();
        _mobileRemainingSecondsNotifier.value = 0;
        _isMobileResendActiveNotifier.value = true;
      });
    }

    setState(() => _isLoading = false);
  }

  void _verifyOtp() async {
    if (mobileOtpController.text.length != 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter 4-digit OTP')));
      return;
    }

    final sessionId = await storage.read(key: 'sessionId');

    BlocProvider.of<UserBloc>(
      context,
    ).add(UserPhoneOtpVerified(mobileOtpController.text.trim(), sessionId!));
  }

  void _startMobileCountdownTimer() {
    _mobileCountdownTimer?.cancel();

    _mobileRemainingSecondsNotifier.value = 60;
    _isMobileResendActiveNotifier.value = false;

    _mobileCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_mobileRemainingSecondsNotifier.value > 0) {
        _mobileRemainingSecondsNotifier.value--;
      } else {
        _isMobileResendActiveNotifier.value = true;
        timer.cancel();
      }
    });
  }

  void _resendMobileOtp() {
    if (_isMobileResendActiveNotifier.value) {
      mobileOtpController.clear();

      _startMobileCountdownTimer();
      final bloc = BlocProvider.of<UserBloc>(context);
      bloc.add(
        UserPhoneOtpRequested(_mobileController.text.trim(), "investor"),
      );
    }
  }

  Widget _buildOtpBottomSheet(StateSetter setState) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Enter OTP', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '''Sent to ${91}${_mobileController.text}''',
                textAlign: TextAlign.center,

                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: blackColor),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => CreateProfile(),
                //   ),
                // ),
                child: Icon(Icons.edit, size: 20, color: onboardingTitleColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              separatorBuilder: (index) => const SizedBox(width: 8),
              defaultPinTheme: defaultPinTheme,
              controller: mobileOtpController,
              focusNode: mobileOtpFocusNode,
              validator: (value) {
                if (value == null || value.length < 4) {
                  return 'Please enter a valid 4-digit OTP';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: onboardingTitleColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Verify OTP',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _isMobileResendActiveNotifier,
                builder:
                    (context, isActive, _) => ValueListenableBuilder<int>(
                      valueListenable: _mobileRemainingSecondsNotifier,
                      builder:
                          (context, seconds, _) => Text(
                            isActive
                                ? 'Didn\'t receive OTP?'
                                : 'Resend OTP in ${seconds}s',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                    ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isMobileResendActiveNotifier,
                builder:
                    (context, isActive, _) =>
                        isActive
                            ? Row(
                              children: [
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () => _resendMobileOtp(),
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: onboardingTitleColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    bool isMobileValid =
        _mobileController.text.length == 10 &&
        RegExp(r'^[6-9]\d{9}$').hasMatch(_mobileController.text);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
        // title: Text(
        //   'Create Profile',
        //   style: Theme.of(context).textTheme.headlineMedium,
        // ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.mobileOtpSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: onboardingTitleColor,
                duration: Duration(milliseconds: 500),
                content: Text(
                  state.errorMessage.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          if (state.status == UserStatus.otpVerified) {
            _mobileCountdownTimer?.cancel();
            mobileOtpController.clear();
            _mobileRemainingSecondsNotifier.value = 0;
            _isMobileResendActiveNotifier.value = true;

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: onboardingTitleColor,
                duration: Duration(milliseconds: 500),
                content: Text(
                  state.errorMessage.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EnterEmail()),
            );
          }
          if (state.status == UserStatus.otperror) {
            _mobileCountdownTimer?.cancel();
            mobileOtpController.clear();
            _mobileRemainingSecondsNotifier.value = 0;
            _isMobileResendActiveNotifier.value = true;

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 500),
                content: Text(
                  state.errorMessage ?? 'OTP Error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          if (state.status == UserStatus.unauthenticated) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 500),
                content: Text(
                  state.errorMessage ?? 'Otp verification failed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 32),
                  Text(
                    'Enter your mobile number',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We will send you a 4-digit OTP to verify your number',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.bodyLarge,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter 10-digit mobile number',
                      //prefixIcon: const Icon(Icons.phone),
                      hintStyle: Theme.of(context).textTheme.bodySmall,

                      prefixText: '+91 ',
                      prefixStyle: Theme.of(context).textTheme.bodyLarge,
                      labelStyle: const TextStyle(color: Colors.grey),

                      floatingLabelStyle: TextStyle(
                        color: onboardingTitleColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: onboardingTitleColor,
                          width: 1.6,
                        ),
                      ),
                    ),
                    validator: _validateMobileNumber,
                    onChanged: (value) => setState(() {}),
                    onFieldSubmitted: (_) => _submitMobileNumber(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          (isMobileValid && !_isLoading)
                              ? _submitMobileNumber
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: onboardingTitleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                'Send OTP',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
