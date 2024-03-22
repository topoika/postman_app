import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../../data/helper/strings.dart';
import '../../../data/models/request.dart';
import '../buttons.dart';

Widget statsItem(context, txt, stat) {
  return Expanded(
    flex: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          stat,
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 22, color: greenColor, fontWeight: FontWeight.w800),
        )
      ],
    ),
  );
}

showLearnMoreDialog(context) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: true,
    builder: (context) {
      return const Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: MyDialog());
    },
  );
}

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 190, 233, 192),
            Color.fromARGB(255, 163, 228, 201),
            Color.fromARGB(255, 213, 236, 227),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/earn.png",
              height: 110,
              opacity: const AlwaysStoppedAnimation(.8),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "You can make money\nanywhere you go",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  you_can_make_desc,
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewOrderDialog extends StatefulWidget {
  final Request request;
  const NewOrderDialog({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<NewOrderDialog> createState() => _NewOrderDialogState();
}

class _NewOrderDialogState extends State<NewOrderDialog> {
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
                  "assets/images/new_order.png",
                  height: 145,
                ),
                const SizedBox(height: 18),
                const Text(
                  "You got an Order!",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Congratulations on your new order request! Click the 'View Order' button to access order information.",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
                const SizedBox(height: 20),
                buttonOne("View Order", true, () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/NewOrderPage",
                      arguments: widget.request);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RequestAcceptDialog extends StatefulWidget {
  final Request request;
  const RequestAcceptDialog({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<RequestAcceptDialog> createState() => _RequestAcceptDialogState();
}

class _RequestAcceptDialogState extends State<RequestAcceptDialog> {
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
                  "assets/images/new_order.png",
                  height: 145,
                ),
                const SizedBox(height: 18),
                const Text(
                  "Order Request Accepted",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Congratulations on your order request was accepted by! Click the 'Next Step' button to to continue to payment",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
                const SizedBox(height: 20),
                buttonOne("Next Step", true, () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/RequestDetails",
                      arguments: widget.request);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
