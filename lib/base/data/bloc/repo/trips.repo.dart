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
  static Future<List<Trip>> fetchRouteTrips() async {
    try {
      CollectionReference tripsColl =
          FirebaseFirestore.instance.collection('trips');
      QuerySnapshot querySnapshot = await tripsColl
          // TODO: Uncomment this line for production
          // .where("travelledAt", isGreaterThan: DateTime.now().toString())
          .where("city",
              isEqualTo: activePackage.value.shipmentAddress!.address!.city)
          .where("destCity",
              isEqualTo: activePackage.value.destinationAddress!.address!.city)
          .orderBy("createdAt", descending: true)
          .get()
          .onError((error, stackTrace) =>
              throw Exception('Failed to load trips${error.toString()}'));
      // Convert documents to Trip objects
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
