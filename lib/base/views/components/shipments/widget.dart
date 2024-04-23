import 'package:flutter/material.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/order.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/order.dart';
import '../buttons.dart';
import '../universal.widgets.dart';

Widget shipmentItem(context, Order shipment, OrderController con) {
  bool mine = shipment.postmanId != activeUser.value.id;
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey[200],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Order #${shipment.id!.substring(0, 7)}',
              textScaleFactor: 1,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: statusOrderColor(shipment.status ?? "pending"),
              ),
              child: Text(
                shipment.status!.toUpperCase(),
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Date: ${dateOnLy(shipment.createdAt)}',
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$${shipment.totalAmount!.toStringAsFixed(2)}',
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withOpacity(.12),
              ),
              child: const Icon(Icons.location_on_rounded,
                  color: Colors.redAccent, size: 18),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                "${shipment.package!.shipmentAddress!.address!.address} - ${shipment.package!.shipmentAddress!.intersection}",
                textScaleFactor: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          alignment: Alignment.centerLeft,
          height: 15,
          child: VerticalDivider(
            color: Colors.redAccent.withOpacity(.5),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withOpacity(.12),
              ),
              child: const Icon(Icons.location_on_rounded,
                  color: Colors.redAccent, size: 18),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                "${shipment.package!.destinationAddress!.address!.address} - ${shipment.package!.destinationAddress!.intersection}",
                textScaleFactor: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !mine && shipment.status != "completed",
          child: buttonOne(
            shipment.status == "pending" ? "Mark Collected" : "Mark Delivered",
            true,
            () async {
              if (shipment.status == "pending") {
                await con
                    .updateOrderStatus(shipment.id!, "active")
                    .then((value) {
                  con.initOrders(shipment.tripId);
                });
              } else {
                await con
                    .updateOrderStatus(shipment.id!, "completed")
                    .then((value) {
                  con.initOrders(shipment.tripId);
                });
              }
            },
          ),
        ),
        Visibility(
          visible: mine,
          child: Column(
            children: <Widget>[
              const Divider(
                height: 30,
                color: Colors.black12,
                thickness: .9,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            shipment.postMan!.image != null
                                ? showLargeImage(
                                    context, shipment.postMan!.image, null)
                                : toastShow(
                                    context, "No profile picture", "nor");
                          },
                          child: Container(
                            height: getWidth(context, 9),
                            width: getWidth(context, 9),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              image: shipment.postMan!.image != null
                                  ? DecorationImage(
                                      image: cachedImage(
                                          shipment.postMan!.image ??
                                              noUserImage),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.white),
                            ),
                            child: shipment.postMan!.image == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          shipment.postMan!.username ?? "",
                          textScaleFactor: 1,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: shipment.status == "complete",
                    child: Container(
                      child: Row(
                        children: [1, 2, 3, 4, 5]
                            .map((e) => const Icon(
                                  Icons.star,
                                  color: oranfeColor,
                                  size: 19,
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 30,
                color: Colors.black12,
                thickness: .9,
              ),
              const SizedBox(height: 5),
              Visibility(
                visible: shipment.tipAmount! > 0.0,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tip',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$5.00',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: mine && shipment.status == "completed",
                child: whiteButton(
                  "Rate Transaction",
                  () => Navigator.pushNamed(
                    context,
                    "/RateTransaction",
                    arguments: "12",
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Color statusOrderColor(String status) {
  switch (status) {
    case 'pending':
      return oranfeColor;
    case 'active':
      return Colors.blueAccent;
    case 'completed':
      return greenColor;
    case 'cancelled':
      return Colors.redAccent;
    default:
      return Colors.black;
  }
}

Widget shipmentItemOne(Order shipment) {
  return InkWell(
    // onTap: () =>
    //     Navigator.pushNamed(context, "/TripDetailsPage", arguments: trip),
    splashColor: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.09),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text(
                      'Starting City',
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Expanded(
                            child:
                                Divider(color: Color(0xffF95959), thickness: 1),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.location_on_rounded,
                            size: 15,
                            color: Color(0xffF95959),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child:
                                Divider(color: Color(0xffF95959), thickness: 1),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Text(
                      'Destination City',
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shipment.package!.shipmentAddress!.address!.city!,
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            timeOnly(shipment.createdAt!),
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            shipment
                                .package!.destinationAddress!.address!.city!,
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            // timeOnly(shipment.packageDeliverdAt),
                            "${shipment.packageDeliverdAt}",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
