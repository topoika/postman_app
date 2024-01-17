import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/views/components/buttons.dart';

void showSuccessDialog(BuildContext context, txt, String next) {
  String route = "/";
  if (next == "Back to login") {
    route = "/Login";
  } else {
    route = "/OTPVerification";
  }
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: primaryShadow(context)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/done.png',
                gaplessPlayback: false,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              Text(
                txt,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              buttonBlack(next, () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, route);
              })
            ],
          ),
        ),
      );
    },
  );
}

void showSuccessDialogBox(BuildContext context, txt, desc, route, String next) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: primaryShadow(context)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/done.png',
                gaplessPlayback: false,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              Text(
                txt,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                desc,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              buttonBlack(next, () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, route);
              })
            ],
          ),
        ),
      );
    },
  );
}
