import 'package:flutter/material.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/package.dart';

Widget packagesItems(context, List<Package> packages, {bool mine = false}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: packages.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final package = packages[index];
      return GestureDetector(
        onTap: () {
          if (mine) {
            activePackage.value = package;
            Navigator.pushReplacementNamed(context, "/AvailableTripsPage");
          } else {
            Navigator.pushNamed(context, "/NewOrderPage",
                arguments: package.id);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: btnColor.withOpacity(.1),
            // color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: package.images!
                          .sublist(
                              0,
                              (package.images!.length >= 3
                                  ? 3
                                  : package.images!.length))
                          .map((e) {
                        double i = package.images!.indexOf(e).toDouble();
                        return Container(
                          transform:
                              Matrix4.translationValues(0 + (5 * i) + 5, 0, 0),
                          height: 65 - (5 * i),
                          width: 65 - (5 * i),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(e), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.white, width: 1.2)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "From:",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              rowItem("City",
                                  package.shipmentAddress!.address!.city),
                              rowItem("Intersection",
                                  package.shipmentAddress!.intersection),
                              Text(
                                "Date ${dateOnLy(package.date)}",
                                textScaleFactor: 1,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "To:",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              rowItem("City",
                                  package.destinationAddress!.address!.city),
                              rowItem(
                                  "Address",
                                  package.destinationAddress!.address!
                                      .nameAddress),
                              rowItem("Intersection",
                                  package.destinationAddress!.intersection),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
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
