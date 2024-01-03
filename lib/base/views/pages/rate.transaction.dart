import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/views/components/buttons.dart';

import '../../data/controllers/order.controller.dart';
import '../../data/helper/constants.dart';
import '../../data/helper/helper.dart';
import '../components/auth/universal.widgets.dart';

class RateTransaction extends StatefulWidget {
  final String id;
  const RateTransaction({super.key, required this.id});

  @override
  _RateTransactionState createState() => _RateTransactionState();
}

class _RateTransactionState extends StateMVC<RateTransaction> {
  late OrderController con;
  _RateTransactionState() : super(OrderController()) {
    con = controller as OrderController;
  }
  int rating = 0;
  int tip = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
        leadingWidth: 64,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset("assets/icons/back.png")),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Rate Now",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  topColumnText(context, "Rate your experience",
                      "Let us know how good was your experience with the postman."),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 4, 5].map((e) {
                      bool checked = (rating >= e);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => rating = e);
                          },
                          child: Icon(
                            Icons.star,
                            color: checked
                                ? oranfeColor
                                : Colors.grey.withOpacity(.5),
                            size: 44,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                      color: Colors.grey.withOpacity(.5),
                      thickness: .8,
                      height: 10),
                  const SizedBox(height: 20),
                  topColumnText(
                      context, "Choose your\nappreciation by giving tip", ""),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [0, 10, 15, 20].map((e) {
                      bool checked = (tip == e);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => tip = e);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: checked
                                    ? greenColor
                                    : Colors.grey.withOpacity(.5)),
                            child: Text(
                              '\$$e',
                              textScaleFactor: 1,
                              style: TextStyle(
                                fontSize: 14,
                                color: checked ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            buttonOne("Done", rating != 0, () {
              if (rating == 0) {
                toastShow(context, "Select a rating for your postman", 'nor');
              } else {
                toastShow(context, "Rating posted successfully", 'suc');
              }
            })
          ],
        ),
      ),
    );
  }
}
