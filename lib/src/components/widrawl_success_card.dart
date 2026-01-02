import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:lottie/lottie.dart';

class WidrawalSuccessCard extends StatelessWidget {
  const WidrawalSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 20,
          vertical: 16,
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,

            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/lottie/success-check.json',
                    width: 130,
                    height: 130,
                  ),

                  Text(
                    'Withdrawal Completed',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall?.copyWith(color: successText),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'The funds have been sent to your bank account.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: onboardingTitleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => TrainsationAll(),
                            ),
                          );
                        },
                        child: Text(
                          "Done",
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
