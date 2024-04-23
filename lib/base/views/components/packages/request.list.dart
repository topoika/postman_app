import 'package:flutter/material.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';
import 'package:postman_app/base/data/helper/constants.dart';

import '../../../data/helper/helper.dart';
import '../../../data/models/order.dart';
import '../../../data/models/request.dart';
import '../shipments/widget.dart';
import '../trips/trips.list.dart';
import '../universal.widgets.dart';

Widget requestItems(context, List<Request> requests, {bool mine = false}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: requests.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final request = requests[index];
        bool mine = request.senderId == activeUser.value.id;
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, mine ? "/RequestDetails" : "/NewOrderPage",
              arguments: request),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
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
            child: Column(
              children: <Widget>[
                tripDetailWidget(context, request.trip!),
                const Divider(
                  color: Colors.black12,
                  thickness: .9,
                  height: 40,
                ),
                Visibility(
                  visible: mine,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                request.trip!.traveller!.image != null
                                    ? showLargeImage(context,
                                        request.trip!.traveller!.image, null)
                                    : toastShow(
                                        context, "No profile picture", "nor");
                              },
                              child: Container(
                                height: getWidth(context, 8),
                                width: getWidth(context, 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.3),
                                  image: request.trip!.traveller!.image != null
                                      ? DecorationImage(
                                          image: cachedImage(
                                              request.trip!.traveller!.image ??
                                                  noUserImage),
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                ),
                                child: request.trip!.traveller!.image == null
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            const SizedBox(width: 28),
                            Text(
                              request.trip!.traveller!.username ?? "",
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: statusColor(request.status!),
                        ),
                        child: Text(
                          request.status!.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !mine,
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.person, color: greenColor, size: 26),
                      const SizedBox(width: 35),
                      Text(
                        request.senderName!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: statusColor(request.status!),
                        ),
                        child: Text(
                          request.status!.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget tripOrderList(context, List<Order> orders,con, {bool mine = false}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
              context, "/ShipmentDetails",
              arguments: order.id),
          child: shipmentItem(context, order, con),
        );
      });
}

Color statusColor(String status) {
  switch (status) {
    case 'pending':
      return oranfeColor;
    case 'accepted':
      return btnColor;
    case 'declined':
      return Colors.redAccent;
    default:
      return Colors.black;
  }
}
