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
                  // TextFormField(
                  //   onSaved: (val) => payment.holdersName = val,
                  //   initialValue: payment.holdersName ?? "",
                  //   validator: (value) {
                  //     String? error;
                  //     error = value!.isEmpty
                  //         ? "Name is required"
                  //         : !validName(value)
                  //             ? "Enter a valid name"
                  //             : null;
                  //     addError(error);
                  //     errors = errors..toSet().toList();

                  //     return error;
                  //   },
                  //   decoration: decoration(
                  //       "Cardholder's Name", context, "Holder's Name"),
                  //   keyboardType: TextInputType.text,
                  //   textCapitalization: TextCapitalization.words,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.black,
                  //     fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.singleLineFormatter,
                  //   ],
                  // ),
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
                  // const SizedBox(height: 16.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextFormField(
                  //         onSaved: (val) => payment.expiry = val,
                  //         initialValue: payment.expiry ?? "",
                  //         validator: (value) {
                  //           String? error;
                  //           error = validateExpiryDate(value!);

                  //           // error = value!.isEmpty
                  //           //     ? "Expiry date is Required"
                  //           //     : value.length < 5
                  //           //         ? "Enter a valid expiry date"
                  //           //         : null;
                  //           addError(error);
                  //           errors = errors.toSet().toList();
                  //           return error;
                  //         },
                  //         decoration:
                  //             decoration("Expiry Date", context, "Expiry Date"),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black,
                  //           fontSize:
                  //               14 / MediaQuery.of(context).textScaleFactor,
                  //         ),
                  //         keyboardType: TextInputType.number,
                  //         inputFormatters: [
                  //           FilteringTextInputFormatter.digitsOnly,
                  //           MaskTextInputFormatter(mask: '##/##')
                  //         ],
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16.0),
                  //     Expanded(
                  //       child: TextFormField(
                  //         onSaved: (val) => payment.cvc = val,
                  //         initialValue: payment.cvc ?? '',
                  //         validator: (value) {
                  //           String? error;
                  //           error = value!.isEmpty
                  //               ? "CVC is Required"
                  //               : value.length < 3
                  //                   ? "Enter a valid cvc"
                  //                   : null;
                  //           addError(error);
                  //           errors = errors.toSet().toList();
                  //           return error;
                  //         },
                  //         decoration: decoration("CVC", context, "CVC"),
                  //         keyboardType: TextInputType.number,
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black,
                  //           fontSize:
                  //               14 / MediaQuery.of(context).textScaleFactor,
                  //         ),
                  //         obscureText: true,
                  //         inputFormatters: [
                  //           FilteringTextInputFormatter.digitsOnly,
                  //           MaskTextInputFormatter(mask: '###'),
                  //           LengthLimitingTextInputFormatter(3)
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   onSaved: (val) => payment.billingAddress = val,
                  //   initialValue: payment.billingAddress ?? "",
                  //   validator: (value) {
                  //     String? error;
                  //     error = validateAddress(value!);
                  //     addError(error);
                  //     errors = errors.toSet().toList();
                  //     return error;
                  //   },
                  //   decoration: decoration(
                  //       "Billing Address", context, "Billing Address"),
                  //   keyboardType: TextInputType.text,
                  //   textCapitalization: TextCapitalization.words,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.black,
                  //     fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.singleLineFormatter,
                  //   ],
                  // ),
                  // const SizedBox(height: 16.0),

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

// String? validateExpiryDate(String expiryDate) {
//   if (expiryDate.isEmpty) {
//     return "Expiry date is empty";
//   }
//   if (expiryDate.length < 5) {
//     return "Enter a valid expiry date";
//   }
//   List<String> parts = expiryDate.split('/');
//   int month = int.tryParse(parts[0]) ?? 0;
//   int year = int.tryParse(parts[1]) ?? 0;

//   DateTime now = DateTime.now();
//   int currentYear = now.year % 100;
//   int currentMonth = now.month;

//   if (year < currentYear || (year == currentYear && month < currentMonth)) {
//     return 'Expired';
//   } else if (month < 1 || month > 12) {
//     return 'Invalid Month';
//   } else {
//     return null;
//   }
// }


