import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:lottie/lottie.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CreateProfile()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/vector-coin.json',
          width: 200,
          height: 200
        ),
      ),
    );
  }
}
