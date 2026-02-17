import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';



import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailOtp extends StatefulWidget {
  final String? emailOrPhoneNumber;
  const VerifyEmailOtp({this.emailOrPhoneNumber, super.key});

  @override
  State<VerifyEmailOtp> createState() => _VerifyEmailOtpState();
}

class _VerifyEmailOtpState extends State<VerifyEmailOtp> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  late Timer _countdownTimer;
  int _remainingSeconds = 60;
  bool _isResendActive = false;
  bool _isOtpFilled = false;

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
    pinController.addListener(_checkOtpCompleted);
  }

  void _startCountdownTimer() {
    setState(() {
      _remainingSeconds = 60;
      _isResendActive = false;
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _remainingSeconds = 0;
          _isResendActive = true;
          timer.cancel();
        }
      });
    });
  }

  void _checkOtpCompleted() {
    setState(() {
      _isOtpFilled = pinController.text.length == 4;
    });
  }

  void _resendOtp() {
    if (_isResendActive) {
      print('Resending OTP to ${widget.emailOrPhoneNumber}');

      // Clear the OTP field for fresh OTP entry
      pinController.clear();

      final bloc = context.read<UserBloc>();
      bloc.add(
        UserResendOtpRequested(widget.emailOrPhoneNumber.toString(), true),
      );

      // Show snackbar confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      _startCountdownTimer();
    }
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    pinController.removeListener(_checkOtpCompleted);
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

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
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
      ),

      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.authenticated) {
               ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Successful'),
              ),
            );
            Navigator.pushReplacementNamed(context, '/invest');
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CreateSecurePin(),
            //     // KycAddressScreen(),
            //   ),
            // );
          } else if (state.status == UserStatus.unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication failed'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 120 : 24,
                // vertical: 100,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),

                  const SizedBox(height: 6),

                  // style: Theme.of(context).textTheme.bodyLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''We have sent OTP to abc@gmail.com''',
                        textAlign: TextAlign.center,

                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateProfile(),
                              ),
                            ),
                        child: Icon(Icons.edit, size: 16, color: blackColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      separatorBuilder: (index) => const SizedBox(width: 8),

                      defaultPinTheme: defaultPinTheme,
                      controller: pinController,
                      focusNode: focusNode,
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a valid 4-digit OTP';
                        }
                        return null;
                      },
                    ),
                  ),

                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 60,
                        height: 60,
                        child: TextField(
                          cursorColor: onboardingTitleColor,
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          //  maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: onboardingTitleColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onChanged: (value) => _onOtpChanged(value, index),
                        ),
                      ),
                    ),
                  ),
                  */
                  const SizedBox(height: 24),

                  if (!_isResendActive)
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resend OTP in',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: ' $_remainingSeconds seconds',
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
                      onTap: _resendOtp,
                      child: Text(
                        'Resend OTP',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: onboardingTitleColor,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isOtpFilled ? onboardingTitleColor : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          _isOtpFilled
                              ? () {
                                final bloc = context.read<UserBloc>();
                                if (_formKey.currentState!.validate()) {
                                  bloc.add(
                                    UserVerifyOtpRequested(
                                      widget.emailOrPhoneNumber.toString(),
                                      pinController.text,
                                      true,
                                    ),
                                  );
                                }
                              }
                              : null,
                      child: Text(
                        'Verify OTP',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
