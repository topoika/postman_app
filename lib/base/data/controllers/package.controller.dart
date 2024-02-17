import 'dart:developer';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/helper.dart';
import '../models/order.dart';
import '../models/package.dart';
import '../models/request.dart';
import 'app.controller.dart';

class PackageController extends AppController {
  Package package = Package();
  String? error;

  setError(val) => setState(() => error = val);

  void addPackage(Package package, List<File> images) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      if (images.isNotEmpty) {
        package.images =
            await uploadImagesToFirebase(images, "packages/images");
      }
      package.senderId = activeUser.value.id!;
      package.createAt = serverTime;
      await db.collection(packageColl).add(package.toMap()).then((value) {
        package.id = value.id;
        value.update({'id': value.id});
        loader.remove();
        activePackage.value = package;
        showSuccessDialog("Your package has been posted!", "", "Find a Postman",
            "/AvailableTripsPage");
      });
    } catch (e) {
      loader.remove();
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }

  Future<Package> getOnePackage(String id) async {
    try {
      final doc = await db.collection(packageColl).doc(id).get();
      return Package.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // Create order from reqquest and package
  void createOrder(Request request, Package package) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    Order order = Order(
      package: package,
      createdAt: serverTime,
      postMan: request.trip!.traveller!,
      postManFee: request.postFee,
      tipAmount: 0.0,
      postmanId: request.recieverId,
      senderId: request.senderId,
      requestId: request.id,
      status: "pending",
      totalAmount: request.postFee,
      tripId: request.trip!.id,
      travelMethod: request.trip!.travelMethod,
      payment: Payment(
        status: "paid",
        cardNumber: "1234 1234 1234 1234",
        expiry: "12/34",
        holdersName: activeUser.value.username,
        cvc: "123",
      ),
    );
    try {
      await db.collection(orderCol).add(order.toMap()).then((value) {
        value.update({'id': value.id});
      });
      loader.remove();
      markPackageComplite(request, package);
      Navigator.pushReplacementNamed(scaffoldKey.currentContext!, "/Pages",
          arguments: 2);
      showSuccessDialog(
          "Your package has been posted!", "", "Find a Postman", "/");
      showSuccessDialog(
          "Order Succesfuly",
          "Wait / chat with the ${request.trip!.traveller!.username} to arrange on package pick up",
          "Message",
          "/");
    } catch (e) {
      loader.remove();
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }

  void markPackageComplite(Request request, Package package) async {
    await db.collection(requestColl).doc(request.id).update({"status": "done"});
    await db.collection(packageColl).doc(package.id).update({
      "ordered": true,
      "updatedAt": DateTime.now().toString(),
    });
  }

  void acceptRequest(id) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await db
          .collection(requestColl)
          .doc(id)
          .update({"status": "accepted"}).then((value) {
        loader.remove();
        toastShow(
            scaffoldKey.currentContext!, "Request update succesfully", "suc");
        Navigator.pop(scaffoldKey.currentContext!);
      });
    } catch (e) {
      loader.remove();
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
      rethrow;
    }
  }

  // Decline request
  void declineRequest(id) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      await db
          .collection(requestColl)
          .doc(id)
          .update({"status": "declined"}).then((value) {
        loader.remove();
        toastShow(
            scaffoldKey.currentContext!, "Request update succesfully", "suc");
        Navigator.pop(scaffoldKey.currentContext!);
      });
    } catch (e) {
      loader.remove();
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
      rethrow;
    }
  }
}
