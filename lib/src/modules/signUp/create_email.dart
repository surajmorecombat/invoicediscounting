import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';
import 'package:invoicediscounting/src/modules/kyc/kyc_opt.dart';
import 'package:pinput/pinput.dart';

class EnterEmail extends StatefulWidget {
  const EnterEmail({super.key});

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  // final TextEditingController _emailController = TextEditingController();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _isLoading = false;

  // final TextEditingController emailOtpController = TextEditingController();
  // final FocusNode emailOtpFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isEmailOtpComplete => emailOtpController.text.trim().length == 4;
  final TextEditingController emailOtpController = TextEditingController();
  final FocusNode emailOtpFocusNode = FocusNode();
  final ValueNotifier<int> _emailRemainingSecondsNotifier = ValueNotifier(0);
  final ValueNotifier<bool> _isEmailResendActiveNotifier = ValueNotifier(true);
  Timer? _emailCountdownTimer;
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
    _emailController.dispose();
    emailOtpController.dispose();
    emailOtpFocusNode.dispose();
    _emailCountdownTimer?.cancel();
    _emailRemainingSecondsNotifier.dispose();
    _isEmailResendActiveNotifier.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _submitEmail() async {
    String? sessionId = await storage.read(key: 'sessionId');
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      emailOtpController.clear();
    });
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(
      UserEmailOtpRequested(_emailController.text.trim(), sessionId.toString()),
    );

    if (mounted) {
      _startEmailCountdownTimer();

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
        _emailCountdownTimer?.cancel();
        emailOtpController.clear();
        _emailRemainingSecondsNotifier.value = 0;
        _isEmailResendActiveNotifier.value = true;
      });
    }

    setState(() => _isLoading = false);
  }

  void _resendEmailOtp() async {
    String? sessionId = await storage.read(key: 'sessionId');
    if (_isEmailResendActiveNotifier.value) {
      emailOtpController.clear();

      _startEmailCountdownTimer();
      final bloc = BlocProvider.of<UserBloc>(context);
      bloc.add(
        UserEmailOtpRequested(
          _emailController.text.trim(),
          sessionId.toString(),
        ),
      );
    }
  }

  void _startEmailCountdownTimer() {
    _emailCountdownTimer?.cancel();

    _emailRemainingSecondsNotifier.value = 60;
    _isEmailResendActiveNotifier.value = false;

    _emailCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_emailRemainingSecondsNotifier.value > 0) {
        _emailRemainingSecondsNotifier.value--;
      } else {
        _isEmailResendActiveNotifier.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOtp() async {
    String? sessionId = await storage.read(key: 'sessionId');
    if (emailOtpController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(
      UserEmailOtpVerified(
        emailOtpController.text.trim(),
        sessionId.toString(),
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    // final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(UserKycProgressRequested(sessionId.toString()));

    // // Assume success
    // Navigator.of(context).pop();
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(const SnackBar(content: Text('OTP verified successfully')));
    // // TODO: Navigate to next screen
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
                '''Sent to ${_emailController.text}''',
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
              controller: emailOtpController,
              focusNode: emailOtpFocusNode,
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
                valueListenable: _isEmailResendActiveNotifier,
                builder:
                    (context, isActive, _) => ValueListenableBuilder<int>(
                      valueListenable: _emailRemainingSecondsNotifier,
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
                valueListenable: _isEmailResendActiveNotifier,
                builder:
                    (context, isActive, _) =>
                        isActive
                            ? Row(
                              children: [
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () => _resendEmailOtp(),
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
    bool isEmailValid = RegExp(
      r'^[^@]+@[^@]+\.[^@]+$',
    ).hasMatch(_emailController.text);
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
          if (state.status == UserStatus.emailOtpSent) {
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

          if (state.status == UserStatus.emailOtpVerified) {
            _emailCountdownTimer?.cancel();
            emailOtpController.clear();
            _emailRemainingSecondsNotifier.value = 0;
            _isEmailResendActiveNotifier.value = true;

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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const KycOpt()),
            // );
            // if (isMobileOtpComplete) {
            //   _mobileCountdownTimer!.cancel();
            //   setState(() {
            //     // mobileVerified = true;
            //     // showEmailField = true;
            //     _isMobileResendActive = false;
            //   });
            // }
          }
          if (state.status == UserStatus.unauthenticated) {
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
          if (state.status == UserStatus.kycProgessed) {
            final progress = state.createProfileResponse!.currentProgress;
            if (progress.isEmpty) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => KycOpt()),
              );
            } else if (progress.contains('investor_kyc')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => BankVerification()),
              );
            }
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (c) => KycOpt()),
            // );
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
                    'Enter your email',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We will send you a 4-digit OTP to verify your email',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      prefixIcon: Icon(
                        Icons.email,
                        color: onboardingTitleColor,
                      ),
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
                    validator: _validateEmail,
                    onChanged: (value) => setState(() {}),
                    onFieldSubmitted: (_) => _submitEmail(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          (isEmailValid && !_isLoading) ? _submitEmail : null,
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
                              : const Text(
                                'Send OTP',
                                style: TextStyle(fontSize: 16),
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
