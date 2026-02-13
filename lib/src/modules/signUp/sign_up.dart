import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/modules/kyc/kyc_adhar_pan.dart';
import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:invoicediscounting/src/utils/validators.dart';
import 'package:pinput/pinput.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode focusNode = FocusNode();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController mobileOtpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailOtpController = TextEditingController();
  final FocusNode mobileOtpFocusNode = FocusNode();
  final FocusNode emailOtpFocusNode = FocusNode();

  bool showMobileOtp = false;
  bool mobileVerified = false;
  bool showEmailField = false;
  bool showEmailOtp = false;
  bool emailVerified = false;

  @override
  void initState() {
    super.initState();
    mobileController.addListener(_onMobileChanged);
    mobileOtpController.addListener(() => setState(() {}));
    emailController.addListener(_onEmailChanged);
    emailOtpController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    mobileController.removeListener(_onMobileChanged);
    mobileController.dispose();
    mobileOtpController.dispose();
    emailController.removeListener(_onEmailChanged);
    emailController.dispose();
    emailOtpController.dispose();
    try {
      _mobileCountdownTimer.cancel();
    } catch (_) {}
    try {
      _emailCountdownTimer.cancel();
    } catch (_) {}
    super.dispose();
  }

  void _onMobileChanged() => setState(() {});
  void _onEmailChanged() => setState(() {});

  bool get isMobileValid => mobileController.text.trim().length >= 10;
  bool get isMobileOtpComplete => mobileOtpController.text.trim().length == 4;
  bool get isEmailValid {
    final email = emailController.text.trim();
    final regex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return regex.hasMatch(email);
  }

  late Timer _mobileCountdownTimer;
  int _mobileRemainingSeconds = 60;
  bool _isMobileResendActive = false;

  late Timer _emailCountdownTimer;
  int _emailRemainingSeconds = 60;
  bool _isEmailResendActive = false;

  bool get isEmailOtpComplete => emailOtpController.text.trim().length == 4;

  void _startMobileCountdownTimer() {
    setState(() {
      _mobileRemainingSeconds = 60;
      _isMobileResendActive = false;
    });

    _mobileCountdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_mobileRemainingSeconds > 0) {
          _mobileRemainingSeconds--;
        } else {
          _mobileRemainingSeconds = 0;
          _isMobileResendActive = true;
          timer.cancel();
        }
      });
    });
  }

  void _startEmailCountdownTimer() {
    setState(() {
      _emailRemainingSeconds = 60;
      _isEmailResendActive = false;
    });

    _emailCountdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_emailRemainingSeconds > 0) {
          _emailRemainingSeconds--;
        } else {
          _emailRemainingSeconds = 0;
          _isEmailResendActive = true;
          timer.cancel();
        }
      });
    });
  }

  void _onMobileContinue() {
    setState(() {
      showMobileOtp = true;
    });
    _startMobileCountdownTimer();
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(UserPhoneOtpRequested(mobileController.text.trim(), "investor"));
  }

  void _verifyMobileOtp() async {
    String? sessionId = await storage.read(key: 'sessionId');
    // if (isMobileOtpComplete) {
    //   _mobileCountdownTimer.cancel();
    //   setState(() {

    //     mobileVerified = true;
    //     showEmailField = true;
    //     _isMobileResendActive = false;

    //   });
    // }
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(
      UserPhoneOtpVerified(
        mobileOtpController.text.trim(),
        sessionId.toString(),
      ),
    );
    // if (bloc.state.status == UserStatus.otpVerified) {
    //   _mobileCountdownTimer.cancel();
    //   setState(() {
    //     mobileVerified = true;
    //     showEmailField = true;
    //     _isMobileResendActive = false;
    //   });
    // }
  }

  void _onEmailContinue() async {
    String? sessionId = await storage.read(key: 'sessionId');
    setState(() {
      showEmailOtp = true;
    });

    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(
      UserEmailOtpRequested(emailController.text.trim(), sessionId.toString()),
    );

    _startEmailCountdownTimer();
  }

  void _verifyEmailOtp() async {
    String? sessionId = await storage.read(key: 'sessionId');
    // if (isEmailOtpComplete) {
    //   _emailCountdownTimer.cancel();
    //   setState(() {
    //     emailVerified = true;
    //     _isEmailResendActive = false;
    //   });
    // }

    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(
      UserEmailOtpVerified(
        emailOtpController.text.trim(),
        sessionId.toString(),
      ),
    );
  }

  void _resendMobileOtp() {
    if (_isMobileResendActive) {
      mobileOtpController.clear();

      _startMobileCountdownTimer();
      final bloc = BlocProvider.of<UserBloc>(context);
      bloc.add(UserPhoneOtpRequested(mobileController.text.trim(), "investor"));
    }
  }

  void _resendEmailOtp() async {
    String? sessionId = await storage.read(key: 'sessionId');
    if (_isEmailResendActive) {
      emailOtpController.clear();

      _startEmailCountdownTimer();
      final bloc = BlocProvider.of<UserBloc>(context);
      bloc.add(
        UserEmailOtpRequested(
          emailController.text.trim(),
          sessionId.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Create Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.mobileOtpSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mobile OTP sent successfully')),
            );
          }

          if (state.status == UserStatus.otpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mobile OTP verified successfully')),
            );

            if (isMobileOtpComplete) {
              _mobileCountdownTimer.cancel();
              setState(() {
                mobileVerified = true;
                showEmailField = true;
                _isMobileResendActive = false;
              });
            }
          }
          if (state.status == UserStatus.emailOtpSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email OTP sent successfully')),
            );
          }
          if (state.status == UserStatus.emailOtpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email OTP verified successfully')),
            );

            if (isEmailOtpComplete) {
              _emailCountdownTimer.cancel();
              setState(() {
                emailVerified = true;
                _isEmailResendActive = false;
              });
            }
          }

          if (state.status == UserStatus.unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Otp verification failed'),
              ),
            );
          } else if (state.status == UserStatus.otperror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'OTP Error')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _InputField(
                    controller: mobileController,
                    label: 'Phone Number',
                    hint: 'Enter mobile number',
                    keyboardType: TextInputType.phone,
                    validator: CommonValidators.emailOrPhoneValidator,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onboardingTitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: isMobileValid ? _onMobileContinue : null,
                          child: Text(
                            'Continue',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (showMobileOtp) ...[
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

                    if (!mobileVerified) ...[
                      SizedBox(height: 8),
                      if (!_isMobileResendActive)
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Resend OTP in',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: ' $_mobileRemainingSeconds seconds',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: _resendMobileOtp,
                          child: Text(
                            'Resend OTP',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: onboardingTitleColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  ],
                  const SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          mobileVerified ? Colors.green : onboardingTitleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isMobileOtpComplete ? _verifyMobileOtp : null,
                    child: Text(
                      mobileVerified ? 'Verified' : 'Verify',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (showEmailField) ...[
                    _InputField(
                      controller: emailController,
                      label: 'Email',
                      hint: 'Enter email address',
                      keyboardType: TextInputType.emailAddress,
                      validator: CommonValidators.emailValidator,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: onboardingTitleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: isEmailValid ? _onEmailContinue : null,
                            child: Text(
                              'Continue',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (showEmailOtp) ...[
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

                      if (!emailVerified) ...[
                        const SizedBox(height: 8),
                        if (!_isEmailResendActive)
                          Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Resend OTP in',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: ' $_emailRemainingSeconds seconds',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: _resendEmailOtp,
                            child: Text(
                              'Resend OTP',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: onboardingTitleColor,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                      ],
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              emailVerified
                                  ? Colors.green
                                  : onboardingTitleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: isEmailOtpComplete ? _verifyEmailOtp : null,
                        child: Text(
                          emailVerified ? 'Verified' : 'Verify',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  (mobileVerified && emailVerified)
                      ? onboardingTitleColor
                      : Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: 
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => KycAddressScreen()),
                
              );
            },
            // (mobileVerified && emailVerified)
            //     ? () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (c) => CreateProfile()),
            // );
            //     }
            //     : null,
            child: Text(
              'Continue',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),

        const SizedBox(height: 8),

        TextFormField(
          cursorColor: onboardingTitleColor,
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodySmall,

            labelStyle: const TextStyle(color: Colors.grey),

            floatingLabelStyle: TextStyle(color: onboardingTitleColor),

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
              borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }
}
