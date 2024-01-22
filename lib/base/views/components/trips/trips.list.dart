import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/helper.dart';

import '../../../data/helper/constants.dart';
import '../../../data/models/trip.dart';

Widget tripsItems(context, List<Trip> trips) {
  return Container(
    height: getHeight(context, 95),
    padding: const EdgeInsets.only(bottom: 120),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: trips.length,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final trip = trips[index];
              return InkWell(
                onTap: () => Navigator.pushNamed(context, "/TripDetailsPage",
                    arguments: trip),
                splashColor: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: greyColor,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: trip.travelMethod!.color!.withOpacity(.12),
                        ),
                        child: Image.asset(
                            "assets/icons/${trip.travelMethod!.icon}",
                            color: trip.travelMethod!.color!,
                            height: 23),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trip.departureDetails!.address!.city!,
                              textScaleFactor: 1,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const Text(
                              'City',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              timeOnly(trip.departureDetails!.time!),
                              textScaleFactor: 1,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const Text(
                              'Departing Time',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: .4, color: Colors.grey)),
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black45,
                          size: 10,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
