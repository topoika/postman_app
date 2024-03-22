import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/bloc/providers/payment/payment.providers.dart';
import 'package:postman_app/base/data/controllers/order.controller.dart';
import 'package:postman_app/base/views/components/buttons.dart';

import '../../../data/controllers/app.controller.dart';

class CardInputForm extends StatefulWidget {
  final Function payNow;
  final double amount;
  const CardInputForm({super.key, required this.payNow, required this.amount});

  @override
  _CardInputFormState createState() => _CardInputFormState();
}

class _CardInputFormState extends StateMVC<CardInputForm> {
  late OrderController con;
  _CardInputFormState() : super(OrderController()) {
    con = controller as OrderController;
  }

  var paymentBloc = PaymentBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        listener: (context, state) {},
        builder: (context, state) {
          CardEditController controller =
              CardEditController(initialDetails: state.cardFieldInputDetails);
          if (state.status == PaymentStatus.initial) {
            return Form(
              key: con.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   onSaved: (val) => payment.cardNumber = val,
                  //   initialValue: payment.cardNumber ?? "",
                  //   validator: (value) {
                  //     String? error;
                  //     error = value!.trim().length < 5
                  //         ? "Enter a valid card number"
                  //         : null;
                  //     addError(error);
                  //     errors = errors.toSet().toList();
                  //     return error;
                  //   },
                  //   decoration: decoration("Card Number", context, "Card No."),
                  //   keyboardType: TextInputType.number,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.black,
                  //     fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.digitsOnly,
                  //     LengthLimitingTextInputFormatter(16),
                  //     MaskTextInputFormatter(
                  //       mask: '#### #### #### ####',
                  //     ),
                  //   ],
                  // ),
                  CardField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      errorStyle: const TextStyle(fontSize: 0),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  buttonOne("Pay Now", true, () async {
                    paymentBloc.add(PaymentCreateIntent(
                        BillingDetails(email: activeUser.value.email),
                        widget.amount));
                  }),
                ],
              ),
            );
          } else if (state.status == PaymentStatus.failure) {
            return Column(
              children: <Widget>[
                const Text(
                  "Payment has failed",
                  style: TextStyle(color: Colors.redAccent),
                ),
                buttonOne("Try Again", true, () {
                  paymentBloc
                      // ignore: invalid_use_of_visible_for_testing_member
                      .emit(const PaymentState(status: PaymentStatus.initial));
                }),
              ],
            );
          } else if (state.status == PaymentStatus.success) {
            return Column(
              children: <Widget>[
                const Text(
                  "Payment was successfull",
                  style: TextStyle(color: Colors.green),
                ),
                buttonOne("Complete Order", true, () {
                  widget.payNow(state.payment);
                }),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
