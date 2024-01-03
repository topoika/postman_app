import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../../data/helper/strings.dart';
import '../../../data/helper/theme.dart';

Widget statsItem(context, txt, stat) {
  return Expanded(
    flex: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          txt,
          style: const TextStyle(fontSize: 13, color: greenColor),
        ),
        const SizedBox(height: 5),
        Text(
          stat,
          style: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w800),
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
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
          .copyWith(bottom: 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            primaryColor,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              const Flexible(
                flex: 2,
                child: Text(
                  you_can_make_title,
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Flexible(
                flex: 1,
                child: Image.asset(
                  "assets/images/undraw_savings.png",
                  height: 100,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            you_can_make_desc,
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
