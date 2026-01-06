import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class LoginWith extends StatelessWidget {
  const LoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => OnboardingScreen()),
            // );
          },
          child: Image.asset('assets/icons/back.png'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              Text(
                'Continue Your Journey',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),

              const SizedBox(height: 8),

              Text(
                'Login safely using your phone or email.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/trending_up.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    foregroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MobileNumberScreen(),
                    //   ),
                    // );
                  },
                  icon: Image.asset(
                    'assets/icons/phone.png',
                    width: 20,
                    height: 20,
                  ),

                  label: Text(
                    'Continue with Phone',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: onboardingTitleColor,
                    side: BorderSide(color: onboardingTitleColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EmailAddressScreen(),
                    //   ),
                    // );
                  },
                  icon: Image.asset(
                    'assets/icons/email.png',
                    width: 20,
                    height: 20,
                  ),
                  label: Text(
                    'Continue with Email',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(color: onboardingTitleColor),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: onboardingTitleColor),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
