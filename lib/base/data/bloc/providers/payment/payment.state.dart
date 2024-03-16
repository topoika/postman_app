part of 'payment.providers.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final CardFieldInputDetails? cardFieldInputDetails;
  final Payment? payment;

  const PaymentState(
      {this.status = PaymentStatus.initial,
      this.payment,
      this.cardFieldInputDetails =
          const CardFieldInputDetails(complete: false)});

  PaymentState copyWith({
    PaymentStatus? status,
    Payment? payment,
    CardFieldInputDetails? cardFieldInputDetails,
  }) {
    return PaymentState(
      status: status ?? this.status,
      cardFieldInputDetails:
          cardFieldInputDetails ?? this.cardFieldInputDetails,
    );
  }

  @override
  List<Object> get props => [status, cardFieldInputDetails!];
}
