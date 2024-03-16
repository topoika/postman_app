import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../../env.dart';
import '../../../models/order.dart';

part 'payment.events.dart';
part 'payment.state.dart';
part 'payment.repo.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStart>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);
  }

  void _onPaymentStart(PaymentStart event, Emitter<PaymentState> emit) {
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(
      PaymentCreateIntent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          options: const PaymentMethodOptions(
              setupFutureUsage: PaymentIntentsFutureUsage.OnSession),
          params: PaymentMethodParams.card(
              paymentMethodData:
                  PaymentMethodData(billingDetails: event.billingDetails)));
      final paymentIntentResults = await PaymentRepo.callPayEndpointMethodId(
          useStripeSdk: true,
          paymentMethodId: paymentMethod.id,
          currency: "usd",
          amount: event.amount);

      log(paymentIntentResults.toString());

      if (paymentIntentResults['error'] != null) {
        emit(state.copyWith(status: PaymentStatus.failure));
      }

      if (paymentIntentResults['status'] == "succeeded" &&
          paymentIntentResults['requiresAction'] == null) {
        emit(state.copyWith(
            status: PaymentStatus.success,
            payment: Payment(
              clientSecret: paymentIntentResults['clientSecret'],
              paymentId: paymentIntentResults['paymentId'],
              status: paymentIntentResults['status'],
              recieptUrl: paymentIntentResults['recieptUrl'],
              paymentMethod: paymentIntentResults['paymentMethod'],
            )));
      }
      if (paymentIntentResults['clientSecret'] != null &&
          paymentIntentResults['requiresAction'] == true) {
        final clientSecret = paymentIntentResults['clientSecret'];
        add(PaymentConfirmIntent(clientSecret));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: PaymentStatus.initial));
    }
  }

  // 4000 0025 0000 3155

  void _onPaymentConfirmIntent(
      PaymentConfirmIntent event, Emitter<PaymentState> emit) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(event.clientSecret);
      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        Map<String, dynamic> results = await PaymentRepo.callEndpointIntent(
            paymentIntentId: paymentIntent.id);
        log(results.toString());

        if (results['error'] != null) {
          emit(state.copyWith(status: PaymentStatus.failure));
        } else {
          emit(state.copyWith(
              status: PaymentStatus.success,
              payment: Payment(
                clientSecret: results['clientSecret'],
                paymentId: results['paymentId'],
                status: results['status'],
                recieptUrl: results['recieptUrl'],
                paymentMethod: results['paymentMethod'],
              )));
        }
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }
}
