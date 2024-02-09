import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../helper/helper.dart';
import '../models/request.dart';
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
      showSuccessDialog(
          "Your itinerary has been posted!", "", "View your trip", "/");
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

  Future<bool> requestAllreadySend(Trip trip) async {
    return await db
        .collection(requestColl)
        .where("tripId", isEqualTo: trip.id)
        .where("recieverId", isEqualTo: trip.travellersId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    });
  }

  Future<void> updatePostmanStatus(String id, value) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await db.collection(tripsCol).doc(id).update({"available": value});
      loader.remove();
      toastShow(
          scaffoldKey.currentContext!, "Status Updated Successfully", 'suc');
    } catch (e) {
      loader.remove();
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
      rethrow;
    }
  }

  Future<void> cancelTrip(String id) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await db.collection(tripsCol).doc(id).update({"status": "canceled"});
      loader.remove();
      toastShow(
          scaffoldKey.currentContext!, "Trip Canceled Successfully", 'suc');
    } catch (e) {
      loader.remove();
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
      rethrow;
    }
  }

  Future<void> sendRequest(Trip trip) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    await requestAllreadySend(trip).then((value) async {
      if (value) {
        loader.remove();
        toastShow(
            scaffoldKey.currentContext!, "Request was already send", 'suc');
        return null;
      } else {
        try {
          Request request = Request(
              senderId: activeUser.value.id,
              postFee: trip.postageFee,
              recieverId: trip.travellersId,
              trip: trip,
              travelledAt: trip.travelledAt,
              senderName: activeUser.value.username,
              createdAt: DateTime.now().toString(),
              packageId: activePackage.value.id,
              status: "pending");
          await db
              .collection(requestColl)
              .add(request.toMap())
              .then((value) async {
            request.id = value.id;
            value.update({"id": value.id});
          }).onError((error, stackTrace) {
            throw Error();
          });
          String? postManToken = await getUserFCM(trip.travellersId);
          await sendNotification(postManToken, "New Order Request", request,
                  type: "request")!
              .then((value) {
            if (value) {
              loader.remove();
              toastShow(scaffoldKey.currentContext!, "Request send succesfully",
                  'suc');
            } else {
              loader.remove();
              toastShow(scaffoldKey.currentContext!,
                  "Unable to send notification", 'err');
              throw Error();
            }
          }).onError((error, stackTrace) {
            throw Error();
          });
        } catch (e) {
          loader.remove();
          log(e.toString());
          toastShow(scaffoldKey.currentContext!,
              "An error occurred, please try again", 'err');
        }
      }
    });
  }
}
