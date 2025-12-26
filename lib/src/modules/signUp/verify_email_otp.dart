import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/phone_verification.dart';

class VerifyEmailOtp extends StatefulWidget {
  const VerifyEmailOtp({super.key});

  @override
  State<VerifyEmailOtp> createState() => _VerifyEmailOtpState();
}

class _VerifyEmailOtpState extends State<VerifyEmailOtp> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 24,
          vertical: 100,
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),

            Text('Verify OTP', style: Theme.of(context).textTheme.displaySmall),

            const SizedBox(height: 6),

            // style: Theme.of(context).textTheme.bodyLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '''we have sent OTP to abc@gmail.com''',
                  textAlign: TextAlign.center,

                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: blackColor),
                ),
                SizedBox(width: 5),
                Icon(Icons.edit, size: 16, color: blackColor),
              ],
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 50,
                  height: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
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

            const SizedBox(height: 24),

            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Expect OTP in',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' 29 seconds',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: onboardingTitleColor,
                  foregroundColor: whiteColor,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                             Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    //EnterSecurePin()
                    OtpVerificationScreen()
                    ),
                  );
                },
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
  }
}
