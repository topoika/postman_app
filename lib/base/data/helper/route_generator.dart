import 'package:flutter/material.dart';

import '../../views/pages/conversation.dart';
import '../../views/pages/dashboard.dart';
import '../../views/pages/input/new.package.dart';
import '../../views/pages/input/new.trip.dart';
import '../../views/pages/onboading.dart';
import '../../views/pages/rate.transaction.dart';
import '../../views/pages/splash.dart';
import '../../views/pages/trip.details.dart';
import '../../views/pages/user/forget.password.dart';
import '../../views/pages/user/login.dart';
import '../../views/pages/user/otp.verification.dart';
import '../../views/pages/user/password.reset.dart';
import '../../views/pages/user/register.dart';
import '../models/user.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/Onboading':
        return MaterialPageRoute(builder: (_) => const Onboading());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case '/Login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/ForgotPassword':
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case '/OTPVerification':
        return MaterialPageRoute(builder: (_) => const OTPVerification());
      case '/PasswordReset':
        return MaterialPageRoute(builder: (_) => const PasswordReset());
      case '/Register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/ConversationPage':
        return MaterialPageRoute(
            builder: (_) => ConversationPage(user: args as User));
      case '/RateTransaction':
        return MaterialPageRoute(
            builder: (_) => RateTransaction(id: args as String));
      case '/TripDetailsPage':
        return MaterialPageRoute(builder: (_) => const TripDetailsPage());
      case '/NewPackagePage':
        return MaterialPageRoute(builder: (_) => const NewPackagePage());
      case '/NewTripPage':
        return MaterialPageRoute(builder: (_) => const NewTripPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
