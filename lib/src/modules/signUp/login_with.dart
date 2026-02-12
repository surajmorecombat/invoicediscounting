import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:invoicediscounting/src/modules/signUp/sign_up.dart';
import 'package:invoicediscounting/src/services/google_auth_service.dart';

import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
              ElevatedButton(
                onPressed: () async {
                  final auth = LocalAuthentication();
                  try {
                    final result = await auth.authenticate(
                      localizedReason: 'Final biometric test',
                      biometricOnly: false,
                    );
                    debugPrint('RESULT = $result');
                    if (result && context.mounted) {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/invest', (_) => false);
                    }
                  } on LocalAuthException catch (e) {
                    debugPrint('ERROR CODE = ${e.code}');
                    debugPrint('ERROR MESSAGE = ${e.description}');
                  }
                },
                child: const Text('Test Biometrics'),
              ),

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
      onPressed: () async {
        try {
          final authService = GoogleAuthService();
          final UserCredential? userCredential =
              await authService.signInWithGoogle();

          if (userCredential != null && context.mounted) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/invest', (_) => false);
          }
        } catch (e, stackTrace) {
          debugPrint('Google Sign-In Error: $e');
          await Sentry.captureException(e, stackTrace: stackTrace);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google sign-in failed')),
            );
          }
        }
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
