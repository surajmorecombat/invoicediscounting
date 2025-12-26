import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/invest.dart';
import 'package:lottie/lottie.dart';

class VerificationProcessing extends StatefulWidget {
  const VerificationProcessing({super.key});

  @override
  State<VerificationProcessing> createState() => _VerificationProcessingState();
}

class _VerificationProcessingState extends State<VerificationProcessing> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Invest()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
          child: Center(
            child: Card(
              elevation: 5,

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/lottie/hourglass.json',
                      width: 150,
                      height: 150,
                    ),
                    // Image.asset(
                    //   'assets/images/hourglass.png',
                    //   width: 80,
                    //   height: 150,
                    // ),
                    Text(
                      'Verification in progress…',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: 10),

                    Text(
                      '''We're reviewing your details. This usually takes 2-3 business days.''',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
