import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:postman_app/base/views/components/buttons.dart';

import 'universal.widget.dart';

class CardInputForm extends StatefulWidget {
  final Function payNow;
  const CardInputForm({super.key, required this.payNow});

  @override
  _CardInputFormState createState() => _CardInputFormState();
}

class _CardInputFormState extends State<CardInputForm> {
  final TextEditingController name = TextEditingController();
  final _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final _expiryDateController = MaskedTextController(mask: '00/00');
  final _cvvController = MaskedTextController(mask: '000');

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: name,
            decoration:
                decoration("Cardholder's Name", context, "Holder's Name"),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14 / MediaQuery.of(context).textScaleFactor,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.singleLineFormatter,
            ],
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _cardNumberController,
            decoration: decoration("Card Number", context, "Card No."),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14 / MediaQuery.of(context).textScaleFactor,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryDateController,
                  decoration: decoration("Expiry Date", context, "Expiry Date"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  decoration: decoration("CVC", context, "CVC"),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                  ),
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          buttonOne("Pay Now", true, () {
            //  Validate the form before making a payment
            widget.payNow();
          }),
        ],
      ),
    );
  }
}
