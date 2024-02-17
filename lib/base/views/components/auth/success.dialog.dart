// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/views/components/buttons.dart';

// void showSuccessDialog(BuildContext context, txt, String next) {
//   String route = "/";
//   if (next == "Back to login") {
//     route = "/Login";
//   } else {
//     route = "/OTPVerification";
//   }
//   showDialog(
//     context: context,
//     barrierColor: Colors.black26,
//     barrierDismissible: false,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         insetPadding: EdgeInsets.zero,
//         child: Container(
//           width: double.maxFinite,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//           margin: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: btnColor,
//             borderRadius: BorderRadius.circular(10),
//             // boxShadow: primaryShadow(context)
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Image.asset(
//                 'assets/images/done.png',
//                 gaplessPlayback: false,
//                 width: 60,
//                 height: 60,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 txt,
//                 textScaleFactor: 1,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 24,
//                 ),
//               ),
//               buttonBlack(next, () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacementNamed(context, route);
//               })
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

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
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 30),
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                        )),
                    Image.asset(
                      "assets/images/done.png",
                      height: 60,
                      color: greenColor,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      txt,
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      desc,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    ),
                    const SizedBox(height: 20),
                    buttonOne(next, true, () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, route);
                    }),
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

class SuccessDialog extends StatefulWidget {
  final String title;
  final String description;
  final String route;
  final dynamic args;
  final String btnText;

  const SuccessDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.route,
    this.args,
    required this.btnText,
  }) : super(key: key);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 30),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                      ),
                    )),
                Image.asset(
                  "assets/images/done.png",
                  height: 60,
                  color: greenColor,
                ),
                const SizedBox(height: 18),
                Text(
                  widget.title,
                  textScaleFactor: 1,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
                const SizedBox(height: 20),
                buttonOne(widget.btnText, true, () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, widget.route,
                      arguments: widget.args);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
