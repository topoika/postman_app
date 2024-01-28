import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../models/address.dart';
import 'constants.dart';

class Helper {
  late BuildContext context;

  Helper.of(BuildContext cxt) {
    context = cxt;
  }
  static OverlayEntry overlayLoader() {
    OverlayEntry loader = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: double.infinity,
            width: getWidth(context, 100),
            color: Theme.of(context).primaryColor.withOpacity(.4),
            child: Center(
              child: Image.asset(
                "assets/images/loading.gif",
                width: 90,
                height: getHeight(context, 8),
              ),
            ),
          ),
        );
      },
    );
    return loader;
  }

  static OverlayEntry overlayNotification() {
    OverlayEntry loader = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: double.infinity,
            width: getWidth(context, 100),
            color: Theme.of(context).primaryColor.withOpacity(.4),
            child: Center(
              child: Image.asset(
                "assets/images/loading.gif",
                width: 90,
                height: getHeight(context, 8),
              ),
            ),
          ),
        );
      },
    );
    return loader;
  }
}

// DATE TIME FORMATES

// appbar data
String appBarDate() => DateFormat("dd MMM yyyy, EEEE").format(DateTime.now());

// date only
String dateOnLy(dateTime) {
  if (dateTime.toString().isEmpty) {
    return "";
  }
  return DateFormat("D-MM-yyyy").format(DateTime.parse(dateTime));
}

String timeOnly(dateTime) {
  if (dateTime.toString().isEmpty) {
    return "";
  }
  return DateFormat.jm().format(DateTime.parse(dateTime));
}

String dateAndTIme(dateTime) {
  if (dateTime.toString().isEmpty) {
    return "";
  }

  return DateFormat('MMM d, hh:mma').format(DateTime.parse(dateTime));
}

// calculate distances of users and postman coodinates

double calculateDistance(Address postManAddress) {
  const double earthRadius = 6371;

  double userLatRad = radians(activeUser.value.address!.latitude!);
  double userLongRad = radians(activeUser.value.address!.longitude!);
  double postmanLatRad = radians(postManAddress.latitude!);
  double postmanLongRad = radians(postManAddress.longitude!);

  // Calculate the change in coordinates
  double deltaLat = postmanLatRad - userLatRad;
  double deltaLong = postmanLongRad - userLongRad;

  // Haversine formula
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(userLatRad) *
          cos(postmanLatRad) *
          sin(deltaLong / 2) *
          sin(deltaLong / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance in kilometers
  double distance = earthRadius * c;

  return distance;
}

double radians(double degrees) {
  return degrees * (pi / 180);
}

void toastShow(context, String txt, String errorText) {
  Color backgroundColor;
  Color textColor;
  if (errorText == "err") {
    backgroundColor = Colors.red;
    textColor = Colors.white;
  } else if (errorText == "chc") {
    backgroundColor = Colors.blue;
    textColor = Colors.white;
  } else if (errorText == "nor") {
    backgroundColor = Colors.grey;
    textColor = Colors.black;
  } else if (errorText == "suc") {
    backgroundColor = Colors.green;
    textColor = Colors.white;
  } else {
    backgroundColor = Colors.black;
    textColor = Colors.black;
  }
  showToast(
    txt,
    context: context,
    duration: const Duration(seconds: 4),
    alignment: Alignment.topCenter,
    position: StyledToastPosition.top,
    isHideKeyboard: true,
    backgroundColor: backgroundColor,
    textStyle: TextStyle(
      fontSize: 14 / MediaQuery.of(context).textScaleFactor,
      color: textColor,
    ),
    animation: StyledToastAnimation.size,
  );
}
