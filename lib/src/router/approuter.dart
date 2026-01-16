import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/modules/activity/activity.dart';
import 'package:invoicediscounting/src/modules/chat/birbal_chat.dart';
import 'package:invoicediscounting/src/modules/flash/flash_screen.dart';
import 'package:invoicediscounting/src/modules/invest/invest.dart';
import 'package:invoicediscounting/src/modules/portfolio/portfolio.dart';

import 'package:invoicediscounting/src/modules/signUp/create_profile.dart';
import 'package:invoicediscounting/src/modules/signUp/processing.dart';
import 'package:invoicediscounting/src/modules/signUp/verify_email_otp.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      case '/splashScreen':
        return MaterialPageRoute(builder: (_) => const FlashScreen());

      case '/createprofile':
        return MaterialPageRoute(builder: (_) => const CreateProfile());

      case '/createotpverify':
        return MaterialPageRoute(builder: (_) => const VerifyEmailOtp());

      case '/processing':
        return MaterialPageRoute(builder: (_) => VerificationProcessing());

      case '/invest':
        return MaterialPageRoute(builder: (_) => Invest());

      case '/activity':
        return MaterialPageRoute(builder: (_) => Activity());

      case '/portfolio':
        return MaterialPageRoute(builder: (_) => Portfolio());

       case '/chat':
        return MaterialPageRoute(builder: (_) => BirbalChat());


      default:
        return MaterialPageRoute(builder: (_) => FlashScreen());
    }
  }
}
