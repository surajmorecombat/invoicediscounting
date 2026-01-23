import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:invoicediscounting/src/modules/signUp/sign_up.dart';

class LoginWith extends StatelessWidget {
  const LoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
          child: Column(
            children: [
              const Spacer(flex: 3),

              Column(
                children: [
                  Image.asset(
                    'assets/images/app-icon.png',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 10),
                  Image.asset('assets/images/app-name.png', width: 130),
                ],
              ),

              const Spacer(flex: 2),

              _googleButton(context),
              const SizedBox(height: 16),
              _emailButton(context),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: '''Don't have account ?  ''',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: onboardingTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //      const SizedBox(height: 20),

              // Text.rich(
              //   TextSpan(
              //     text: 'By continuing, you agree to our ',
              //     style: Theme.of(context).textTheme.bodySmall,
              //     children: [
              //       TextSpan(
              //         text: 'Terms',
              //         style: TextStyle(color: onboardingTitleColor),
              //       ),
              //       const TextSpan(text: ' and '),
              //       TextSpan(
              //         text: 'Privacy Policy',
              //         style: TextStyle(color: onboardingTitleColor),
              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleButton(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 52,
    child: OutlinedButton.icon(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const LoginWith()),
        // );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: onboardingTitleColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Image.asset('assets/icons/google.png', width: 20),
      label: Text(
        'Continue with Google',
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: onboardingTitleColor),
      ),
    ),
  );

  Widget _emailButton(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: () {
        //CreateProfile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateProfile()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: onboardingTitleColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Continue with Phone/Email',
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: whiteColor),
      ),
    ),
  );
}
