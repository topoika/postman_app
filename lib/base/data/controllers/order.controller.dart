import 'dart:convert';

import '../../../env.dart';
import 'app.controller.dart';
import 'package:http/http.dart' as http;

class OrderController extends AppController {
  Future<void> createPaymentIntent() async {
    const url = 'https://api.stripe.com/v1/payment_intents';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $STRIPE_SECRET',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': '1000', // amount in cents
        'currency': 'usd',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final clientSecret = responseBody['client_secret'];

      // Use the clientSecret to confirm the payment on the client side
      // (This would typically be done in your Flutter app)
    } else {
      throw Exception('Failed to create payment intent');
    }
  }
}
