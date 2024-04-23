import 'package:flutter/material.dart';
import 'package:postman_app/base/data/models/package.dart';

import '../../views/pages/available.order.dart';
import '../../views/pages/available.trips.dart';
import '../../views/pages/conversation.dart';
import '../../views/pages/dashboard.dart';
import '../../views/pages/input/new.package.dart';
import '../../views/pages/input/new.trip.dart';
import '../../views/pages/input/reciever.details.dart';
import '../../views/pages/more/faq.page.dart';
import '../../views/pages/more/help.and.support.dart';
import '../../views/pages/more/more.screen.dart';
import '../../views/pages/more/new.feeds.dart';
import '../../views/pages/more/order.requests.dart';
import '../../views/pages/more/my.packages.dart';
import '../../views/pages/more/shipment.management.dart';
import '../../views/pages/more/trip.orders.dart';
import '../../views/pages/onboading.dart';
import '../../views/pages/package/package.details.dart';
import '../../views/pages/package/payment.page.dart';
import '../../views/pages/package/request.details.dart';
import '../../views/pages/package/requests.page.dart';
import '../../views/pages/rate.transaction.dart';
import '../../views/pages/splash.dart';
import '../../views/pages/trip.details.dart';
import '../../views/pages/user/edit.profile.dart';
import '../../views/pages/user/forget.password.dart';
import '../../views/pages/user/login.dart';
import '../../views/pages/user/otp.verification.dart';
import '../../views/pages/user/password.reset.dart';
import '../../views/pages/user/register.dart';
import '../models/request.dart';
import '../models/trip.dart';
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
        return MaterialPageRoute(
            builder: (_) => Dashboard(active: (args ?? 0) as int));
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
      case '/EditProfilePage':
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case '/ConversationPage':
        return MaterialPageRoute(
            builder: (_) => ConversationPage(user: args as User));
      case '/RateTransaction':
        return MaterialPageRoute(
            builder: (_) => RateTransaction(id: args as String));
      case '/TripDetailsPage':
        return MaterialPageRoute(
            builder: (_) => TripDetailsPage(trip: args as Trip));
      case '/NewPackagePage':
        return MaterialPageRoute(
            builder: (_) => NewPackagePage(package: args as Package));
      case '/AvailableOrdersPage':
        return MaterialPageRoute(builder: (_) => const AvailableOrdersPage());
      case '/MyPackagesPage':
        return MaterialPageRoute(builder: (_) => const MyPackagesPage());
      case '/AvailableTripsPage':
        return MaterialPageRoute(
            builder: (_) => AvailableTripsPage(package: args as Package));
      case '/NewOrderPage':
        return MaterialPageRoute(
            builder: (_) => NewOrderPage(request: args as Request));
      case '/PackageRequests':
        return MaterialPageRoute(
            builder: (_) => PackageRequests(id: args as String));
      case '/TripOrders':
        return MaterialPageRoute(
            builder: (_) => TripOrders(id: args as String));
      case '/ShipmentDetails':
        return MaterialPageRoute(
            builder: (_) => ShipmentDetails(id: args as String));
      case '/RequestDetails':
        return MaterialPageRoute(
            builder: (_) => RequestDetails(request: args as Request));
      case '/PaymentPage':
        return MaterialPageRoute(
            builder: (_) => PaymentPage(request: args as Request));
      case '/ReceiverDetailsPage':
        return MaterialPageRoute(
            builder: (_) => ReceiverDetailsPage(data: args));
      case '/NewTripPage':
        return MaterialPageRoute(
            builder: (_) => NewTripPage(trip: args as Trip));
      case '/MorePage':
        return MaterialPageRoute(builder: (_) => const MorePage());
      case '/HelpAndSupport':
        return MaterialPageRoute(builder: (_) => const HelpAndSupport());
      case '/FAQsPage':
        return MaterialPageRoute(builder: (_) => const FAQsPage());
      case '/NewsFeedPage':
        return MaterialPageRoute(builder: (_) => const NewsFeedPage());
      case '/OrderRequestPage':
        return MaterialPageRoute(builder: (_) => const OrderRequestPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
