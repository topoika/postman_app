import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/constants.dart';

import '../../../data/models/request.dart';
import '../trips/trips.list.dart';

Widget requestItems(context, List<Request> requests, {bool mine = false}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: requests.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final request = requests[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/NewOrderPage",
              arguments: request.packageId),
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
                Row(
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
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
