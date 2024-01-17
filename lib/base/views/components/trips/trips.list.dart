
import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../../data/models/trip.dart';

Widget tripsItems(context, List<Trip> trips) {

  return ListView.builder(
    shrinkWrap: true,
    itemCount: trips.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final trip = trips[index];
      return InkWell(
        onTap: () => Navigator.pushNamed(context, "/TripDetailsPage"),
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.orangeAccent,
                          size: 15,
                        ),
                        Text(
                          'Starting city',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      trip.departureDetails!.address!.city ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: greenColor),
                    ),
                    const Text(
                      'Jan 29, 13:09',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 15,
                        ),
                        Text(
                          'Desination city',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      trip.destinationDetails!.address!.city ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: greenColor),
                    ),
                    const Text(
                      'Jan 29, 13:09',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trip.travelMethod!.name ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blackColor),
                    ),
                    Image.asset("assets/icons/${trip.travelMethod!.icon}",
                        height: 30)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
