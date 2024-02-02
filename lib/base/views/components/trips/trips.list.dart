import 'package:flutter/material.dart';

import '../../../data/helper/helper.dart';
import '../../../data/models/trip.dart';

Widget tripsItems(context, List<Trip> trips) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: trips.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final trip = trips[index];
      return InkWell(
        onTap: () =>
            Navigator.pushNamed(context, "/TripDetailsPage", arguments: trip),
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          margin: const EdgeInsets.symmetric(vertical: 5),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: trip.travelMethod!.color!.withOpacity(.12),
                ),
                child: Image.asset("assets/icons/${trip.travelMethod!.icon}",
                    color: trip.travelMethod!.color!, height: 23),
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
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: .4, color: Colors.grey)),
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black45,
                  size: 13,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget tripDetailWidget(context, Trip trip, {bool end = false}) {
  return Row(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: trip.travelMethod!.color!.withOpacity(.12),
        ),
        child: Image.asset("assets/icons/${trip.travelMethod!.icon}",
            color: trip.travelMethod!.color!, height: 23),
      ),
      const SizedBox(width: 15),
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
                        child: Divider(color: Color(0xffF95959), thickness: 1),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.location_on_rounded,
                        size: 15,
                        color: Color(0xffF95959),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Divider(color: Color(0xffF95959), thickness: 1),
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
                        trip.departureDetails!.address!.city!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dateAndTIme(trip.departureDetails!.date),
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 12,
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
                        trip.destinationDetails!.address!.city!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dateAndTIme(trip.destinationDetails!.date),
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 12,
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
  );
}

Widget myTripsList(context, List<Trip> trips) => ListView.builder(
      shrinkWrap: true,
      itemCount: trips.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final trip = trips[index];
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: trip.travelMethod!.color!.withOpacity(.12),
                  ),
                  child: Image.asset("assets/icons/${trip.travelMethod!.icon}",
                      color: trip.travelMethod!.color!, height: 23),
                ),
                const SizedBox(width: 10),
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
                                  trip.departureDetails!.address!.city!,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  dateAndTIme(trip.departureDetails!.date),
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
                                  trip.destinationDetails!.address!.city!,
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  dateAndTIme(trip.destinationDetails!.date),
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
