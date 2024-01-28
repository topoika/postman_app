import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/order.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({super.key});

  @override
  _ShipmentsPageState createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends StateMVC<ShipmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          appBarDate(),
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // init();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            const Text(
              'My Shipments',
              style: TextStyle(
                fontSize: 22,
                color: greenColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                                  'Departing City',
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
                                        child: Divider(
                                            color: Color(0xffF95959),
                                            thickness: 1),
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 15,
                                        color: Color(0xffF95959),
                                      ),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: Divider(
                                            color: Color(0xffF95959),
                                            thickness: 1),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Final destination',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        // shipment.package!.shipmentAddress!
                                        //     .address!.city!,
                                        "Nairobi",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Departing Time',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        // dateAndTImshipment.package!.createAt!),
                                        dateAndTIme(DateTime.now().toString()),

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
                                      const Text(
                                        // shipment.package!.destinationAddress!
                                        //     .address!.city!,
                                        "Kampala",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Arriving time',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        // dateAndTIme(shipment.packageDeliverdAt),
                                        timeOnly(DateTime.now().toString()),
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget myShipmentItems(context, List<Order> shipments) => ListView.builder(
      shrinkWrap: true,
      itemCount: shipments.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final shipment = shipments[index];
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
                                  child: Divider(
                                      color: Color(0xffF95959), thickness: 1),
                                ),
                                SizedBox(width: 3),
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 15,
                                  color: Color(0xffF95959),
                                ),
                                SizedBox(width: 3),
                                Expanded(
                                  child: Divider(
                                      color: Color(0xffF95959), thickness: 1),
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
                                  shipment
                                      .package!.shipmentAddress!.address!.city!,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  dateAndTIme(shipment.package!.createAt!),
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
                                  shipment.package!.destinationAddress!.address!
                                      .city!,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  dateAndTIme(shipment.packageDeliverdAt),
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
      },
    );
