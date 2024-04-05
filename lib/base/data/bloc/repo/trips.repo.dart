import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controllers/app.controller.dart';
import '../../models/trip.dart';

class TripsRepo {
  // fetch all the trips
  static Future<List<Trip>> fetchMyTrips() async {
    try {
      CollectionReference tripsColl =
          FirebaseFirestore.instance.collection('trips');
      QuerySnapshot querySnapshot = await tripsColl
          .where("travellersId", isEqualTo: activeUser.value.id)
          .orderBy("travelledAt", descending: true)
          .get()
          .onError(
              (error, stackTrace) => throw Exception('Failed to load trips'));
      // Convert documents to Trip objects
      List<Trip> trips = querySnapshot.docs
          .map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return trips;
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch all the route trips
  static Future<List<Trip>> fetchRouteTrips(String startCity, destCity) async {
    try {
      CollectionReference tripsColl =
          FirebaseFirestore.instance.collection('trips');
      QuerySnapshot querySnapshot = await tripsColl
          .where("city", isEqualTo: startCity)
          .where("destCity", isEqualTo: destCity)
          .where("available", isEqualTo: true)
          .orderBy("createdAt", descending: true)
          .get()
          .onError((error, stackTrace) =>
              throw Exception('Failed to load trips${error.toString()}'));

      log("Trips ${querySnapshot.docs.length}");
      List<Trip> trips = querySnapshot.docs
          .map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>))
          .where((trip) => trip.travellersId != activeUser.value.id)
          .toList();

      return trips;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  // fetch all my trips
}
