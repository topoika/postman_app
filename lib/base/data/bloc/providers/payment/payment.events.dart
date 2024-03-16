part of 'payment.providers.dart';

class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object> get props => [];
}

class PaymentStart extends PaymentEvent {}

class PaymentCreateIntent extends PaymentEvent {
  final BillingDetails billingDetails;
  final double amount;

  const PaymentCreateIntent(this.billingDetails, this.amount);
  @override
  List<Object> get props => [billingDetails, amount];
}

class PaymentConfirmIntent extends PaymentEvent {
  final String clientSecret;

  const PaymentConfirmIntent(this.clientSecret);
  @override
  List<Object> get props => [clientSecret];
}
