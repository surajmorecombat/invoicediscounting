import 'package:flutter/material.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:invoicediscounting/src/modules/signUp/login_with.dart';
import 'package:lottie/lottie.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;

  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginWith()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _logoSlide,
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: Image.asset(
                    'assets/images/app-icon.png',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),

              SlideTransition(
                position: _textSlide,
                child: FadeTransition(
                  opacity: _textOpacity,
                  child: Image.asset(
                    'assets/images/app-name.png',
                    width: 120,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
