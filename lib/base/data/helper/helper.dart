import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

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
}

// DATE TIME FORMATES

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
