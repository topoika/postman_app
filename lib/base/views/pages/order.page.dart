import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/data/helper/helper.dart';

import '../../data/controllers/package.controller.dart';
import '../../data/models/package.dart';
import '../components/buttons.dart';
import '../components/packages/image.slider.dart';
import '../components/universal.widgets.dart';
import 'trip.details.dart';

class NewOrderPage extends StatefulWidget {
  final String? id;
  const NewOrderPage({super.key, required this.id});

  @override
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends StateMVC<NewOrderPage> {
  late PackageController con;
  _NewOrderPageState() : super(PackageController()) {
    con = controller as PackageController;
  }
  Package? package;
  @override
  void initState() {
    super.initState();
    setPackage();
  }

  void setPackage() async {
    await con.getOnePackage(widget.id!).then((value) {
      setState(() => package = value);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "New Order",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: package == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                SliderWithIndicators(images: package!.images),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              package!.name ?? "",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: greenColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Item# ${package!.id!.substring(0, 7)}",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "2.2 Kg",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Weight",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 2,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(radius)),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "${package!.dimLength!.ceil()}' ${package!.dimWidth!.ceil()}' ${package!.dimHeight!.ceil()}'",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    "Dimensions",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 2,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(radius)),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "\$${package!.value!.toStringAsFixed(2)}",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    "Value",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      subheading("Description"),
                      Text(
                        package!.description!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      subheading("Take off location"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem("Address",
                                package!.shipmentAddress!.address!.nameAddress),
                            detailsItem("Departure City",
                                package!.shipmentAddress!.address!.city),
                            detailsItem("Nearest Intersection",
                                package!.shipmentAddress!.intersection),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      subheading("Package Delivery Address"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem(
                                "Address",
                                package!
                                    .destinationAddress!.address!.nameAddress),
                            detailsItem("Desstination City",
                                package!.destinationAddress!.address!.city),
                            detailsItem("Nearest Intersection",
                                package!.destinationAddress!.intersection),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem("Date", dateOnLy(package!.date)),
                            detailsItem("Time", timeOnly(package!.date)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.06),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Shipper",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: greenColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                package!.senderName ?? "Shipper One",
                                textScaleFactor: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: greenColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          // TODO: Make a conversation for the two users
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset("assets/icons/chats.png",
                                height: 22, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text(
                              "Contact Shipper",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: greenColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios,
                                color: greenColor, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: postManButton("Decline", false,
                                  () => Navigator.pop(context))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: postManButton("Accept", true, () {
                            // TODO: make a convesation for the two users
                          })),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget subheading(txt) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
            color: greenColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
