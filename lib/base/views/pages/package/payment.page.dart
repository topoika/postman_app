import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/data/helper/helper.dart';
import 'package:postman_app/base/views/components/buttons.dart';

import '../../../data/controllers/package.controller.dart';
import '../../../data/models/package.dart';
import '../../../data/models/request.dart';
import '../../components/input/card.input.dart';
import '../../components/input/universal.widget.dart';
import '../../components/universal.widgets.dart';
import '../input/new.package.dart';

class PaymentPage extends StatefulWidget {
  final Request request;

  const PaymentPage({super.key, required this.request});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends StateMVC<PaymentPage> {
  late PackageController con;
  _PaymentPageState() : super(PackageController()) {
    con = controller as PackageController;
  }
  String option = "Visa";
  int active = 0;

  Package? package;
  @override
  void initState() {
    super.initState();
    setPackage();
  }

  void setPackage() async {
    await con.getOnePackage(widget.request.packageId!).then((value) {
      setState(() => package = value);
    }).onError((error, stackTrace) {
      // log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: const Text(
          "Payment Method",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: package == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: mainHeading(context, "Payment Options"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Row(
                              children: [
                                Icon(Icons.add, color: greenColor, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Add New Card',
                                  style: TextStyle(
                                      color: greenColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: greenColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          radioItem("Visa", option, "Visa",
                              (val) => setState(() => option = val),
                              flex: 2),
                          radioItem("Mastercard", option, "Mastercard",
                              (val) => setState(() => option = val),
                              flex: 2),
                          radioItem("Paypal", option, "Paypal",
                              (val) => setState(() => option = val),
                              flex: 2),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [1, 2].map((e) {
                                    bool one = active == e;
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () => setState(() => active = e),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.3),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Image.asset(
                                                  "assets/icons/card.png",
                                                  height: 28),
                                            ),
                                            const SizedBox(width: 10),
                                            const Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Master Card',
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    '**** **** **** 6789',
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: Colors.black38),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Visibility(
                                              visible: one,
                                              child: const Icon(
                                                Icons.verified,
                                                color: greenColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Visibility(
                                  visible: option != "Paypal",
                                  child: CardInputForm(
                                    payNow: () {
                                      // save card info save it to the card object,
                                      con.createOrder(widget.request, package!);
                                      // call the pay for request function
                                    },
                                  )),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: option == "Paypal",
                                child: buttonOne("Pay on Paypal", true, () {
                                  // TODO: redirect to paypal
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      mainHeading(context, "Other Wallers"),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: wallets.map((e) {
                          return InkWell(
                            onTap: () {
                              //TODO: take user to the expected links
                              toastShow(context, "Comming soon...", "nor");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(40),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 1.3),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                        "assets/icons/${e['icon']}",
                                        height: 28),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      e['name'],
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

List wallets = [
  {"name": "Add Gpay Waller", "icon": "google-pay.png", "link": "/"},
  {"name": "Add Paypal Wallet", "icon": "paypal.png", "link": "/"},
  {"name": "Pay Stack", "icon": "apple-pay.png", "link": "/"},
];
