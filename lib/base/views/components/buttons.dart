import 'package:flutter/material.dart';

import '../../data/helper/constants.dart';

Widget buttonOne(String txt, active, ontap) => GestureDetector(
      onTap: () => active ? ontap() : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
        ),
      ),
    );

Widget learnMoreButton(txt, ontap) => GestureDetector(
      onTap: () => ontap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.black),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
Widget buttonBlackOne(String txt, active, ontap) => GestureDetector(
      onTap: () => active ? ontap() : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );

Widget buttonBlack(String txt, ontap) => GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        // alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: btnColor),
        ),
      ),
    );
Widget postManButton(String txt, filled, ontap) => GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: filled ? btnColor : Colors.black),
          color: filled ? btnColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: filled ? Colors.white : Colors.black),
        ),
      ),
    );
Widget whiteButton(String txt, ontap) => GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
        ),
      ),
    );
