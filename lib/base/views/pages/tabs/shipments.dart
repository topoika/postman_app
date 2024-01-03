import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/constants.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/helper/helper.dart';
import '../../components/buttons.dart';
import '../../components/universal.widgets.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({super.key});

  @override
  _ShipmentsPageState createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends StateMVC<ShipmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 64,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset("assets/icons/back.png")),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "My Shipments",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          const Text(
            'Completed & Active',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: btnColor.withOpacity(.5),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Order #12345',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.5),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: index.isEven ? blackColor : greenColor,
                          ),
                          child: Text(
                            index.isEven ? "Completed" : "Active",
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Date: 25/01/2023',
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '\$45.00',
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Icon(Icons.location_on_rounded,
                                color: Colors.black, size: 14.5),
                            SizedBox(width: 5),
                            Text(
                              '12 Garlfield Crescent',
                              textScaleFactor: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          height: 15,
                          child: const VerticalDivider(),
                        ),
                        const Row(
                          children: <Widget>[
                            Icon(Icons.location_on_rounded,
                                color: Colors.black, size: 14.5),
                            SizedBox(width: 5),
                            Text(
                              '123 Solo Street, IDN',
                              textScaleFactor: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                            color: greenColor.withOpacity(.3),
                            thickness: .9,
                            height: 15),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      activeUser.value.image != null
                                          ? showLargeImage(context,
                                              activeUser.value.image, null)
                                          : toastShow(context,
                                              "No profile picture", "nor");
                                    },
                                    child: Container(
                                      height: getWidth(context, 9),
                                      width: getWidth(context, 9),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.3),
                                        image: activeUser.value.image != null
                                            ? DecorationImage(
                                                image: cachedImage(
                                                    activeUser.value.image ??
                                                        noUserImage),
                                                fit: BoxFit.fill,
                                              )
                                            : null,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                      ),
                                      child: activeUser.value.image == null
                                          ? const Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    activeUser.value.username ?? "",
                                    textScaleFactor: 1,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: index.isEven,
                              child: Container(
                                child: Row(
                                  children: [1, 2, 3, 4, 5]
                                      .map((e) => const Icon(
                                            Icons.star,
                                            color: oranfeColor,
                                            size: 19,
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                            color: greenColor.withOpacity(.3),
                            thickness: .9,
                            height: 15),
                        const SizedBox(height: 5),
                        Visibility(
                          visible: index.isEven,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Tip',
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '\$5.00',
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !index.isEven,
                          child: whiteButton(
                            "Rate Transaction",
                            () => Navigator.pushNamed(
                              context,
                              "/RateTransaction",
                              arguments: "12",
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
