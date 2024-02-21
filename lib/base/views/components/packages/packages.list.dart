import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/package.dart';
import '../../../data/models/request.dart';

Widget packagesItems(context, List<Package> packages, {bool mine = false}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: packages.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final package = packages[index];
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/NewOrderPage",
              arguments: Request(packageId: package.id));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.09),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      package.name ?? "New Package",
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: package.ordered! ? btnColor : oranfeColor,
                    ),
                    child: Text(
                      package.ordered! ? "Ordered" : "Pending",
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: <Widget>[
                  Text(
                    'Departing City',
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Expanded(
                          child:
                              Divider(color: Color(0xffF95959), thickness: 1),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: Color(0xffF95959),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child:
                              Divider(color: Color(0xffF95959), thickness: 1),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Text(
                    'Final destination',
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.shipmentAddress!.address!.city ?? "",
                          textScaleFactor: 1,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Date & Time',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dateAndTIme(package.date!),
                          textScaleFactor: 1,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          package.destinationAddress!.address!.city ?? "",
                          textScaleFactor: 1,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Date & Time',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "-----------",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget rowItem(txt, txt1) => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$txt : ",
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Flexible(
          child: Text(
            txt1,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
