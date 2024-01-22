import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../views/components/auth/success.dialog.dart';
import '../helper/helper.dart';
import '../models/trip.dart';
import 'app.controller.dart';

class TripController extends AppController {
  Trip trip = Trip();
  String? error;

  setError(val) => setState(() => error = val);

  Future<void> addTrip(Trip trip, File? ticket) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    if (ticket != null) {
      trip.ticketUrl = await uploadImageToFirebase(ticket, "trips/images");
    }
    trip.traveller = activeUser.value;
    trip.travellersId = activeUser.value.id;
    trip.travelledAt = trip.departureDetails!.date;
    try {
      await db.collection(tripsCol).add(trip.toMap()).then((value) async {
        await value.update({"id": value.id});
      });
      loader.remove();
      showSuccessDialogBox(
          scaffoldKey.currentContext!,
          "Your itinerary has been posted!",
          "Your will receive order alerts for  packages going your way",
          "/",
          "View your itinerary");
    } catch (e) {
      loader.remove();
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }

  Future<Trip> getOneTrip(String id) async {
    try {
      final doc = await db.collection(tripsCol).doc(id).get();
      return Trip.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
