part of 'payment.providers.dart';

class PaymentRepo {
  static Future<Map<String, dynamic>> callEndpointIntent(
      {required paymentIntentId}) async {
    final Uri url = Uri.parse("${URL}StripePayEndpointIntentId");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "paymentIntentId": paymentIntentId,
          "return_url": "${URL}StripePayEndpointIntentId"
        },
      ),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> callPayEndpointMethodId(
      {required bool useStripeSdk,
      required String paymentMethodId,
      required String currency,
      required double amount}) async {
    final Uri url = Uri.parse("${URL}StripePayEndpointMethodId");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "useStripeSdk": useStripeSdk,
          "paymentMethodId": paymentMethodId,
          "currency": currency,
          "amount": amount,
          "return_url": "${URL}StripePayEndpointIntentId"
        },
      ),
    );
    return json.decode(response.body);
  }
}
