import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/data/helper/helper.dart';

import '../../../data/controllers/package.controller.dart';
import '../../../data/models/package.dart';
import '../../../data/models/request.dart';
import '../../../data/models/user.dart';
import '../../components/buttons.dart';
import '../../components/packages/image.slider.dart';
import '../../components/universal.widgets.dart';
import '../more/shipment.management.dart';
import '../trip.details.dart';

class NewOrderPage extends StatefulWidget {
  final Request? request;
  const NewOrderPage({super.key, required this.request});

  @override
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends StateMVC<NewOrderPage> {
  late PackageController con;
  _NewOrderPageState() : super(PackageController()) {
    con = controller as PackageController;
  }
  Package? package;
  @override
  void initState() {
    super.initState();
    setPackage();
  }

  void setPackage() async {
    await con.getOnePackage(widget.request!.packageId!).then((value) {
      setState(() => package = value);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    bool mine =
        (package != null ? package!.senderId : "") == activeUser.value.id;
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: Text(
          mine ? "Package Detais" : "New Order",
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          Visibility(
            visible: mine && package != null && !package!.ordered!,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/NewPackagePage",
                  arguments: package),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset("assets/icons/edit.png", height: 14),
                    const Text(
                      " Edit",
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: package == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                SliderWithIndicators(images: package!.images),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              package!.name ?? "",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: greenColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Item# ${package!.id!.substring(0, 7)}",
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      dimensions(context, package),
                      subheading("Note to Postman"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                package!.userDetails!.noteToPostman ?? "",
                                textScaleFactor: 1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      subheading("Description"),
                      Text(
                        package!.description!,
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      subheading("Take off location"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem("Address",
                                package!.shipmentAddress!.address!.nameAddress),
                            detailsItem("Departure City",
                                package!.shipmentAddress!.address!.city),
                            detailsItem("Nearest Intersection",
                                package!.shipmentAddress!.intersection),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      subheading("Package Delivery Address"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem(
                                "Address",
                                package!
                                    .destinationAddress!.address!.nameAddress),
                            detailsItem("Desstination City",
                                package!.destinationAddress!.address!.city),
                            detailsItem("Nearest Intersection",
                                package!.destinationAddress!.intersection),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            detailsItem("Date", dateOnLy(package!.date)),
                            detailsItem("Time", timeOnly(package!.date)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !mine,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            margin: const EdgeInsets.only(top: 15, bottom: 25),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.06),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Shipper",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: greenColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  package!.senderName ?? "Shipper One",
                                  textScaleFactor: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: greenColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Visibility(
                        visible: !mine,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () async {
                            await con.db
                                .collection(con.userCol)
                                .doc(package!.senderId)
                                .get()
                                .then((value) {
                              Navigator.pushReplacementNamed(
                                  context, "/ConversationPage",
                                  arguments: User.fromMap(
                                      value.data() as Map<String, dynamic>));
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset("assets/icons/chats.png",
                                  height: 22, color: Colors.black),
                              const SizedBox(width: 10),
                              const Text(
                                "Contact Shipper",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios,
                                  color: greenColor, size: 20),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: mine,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 15),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Visibility(
                                  visible: !package!.ordered!,
                                  child: Expanded(
                                      child: postManButton(
                                          "Find Postman", false, () {
                                    activePackage.value = package!;
                                    Navigator.pushNamed(
                                        context, "/AvailableTripsPage",
                                        arguments: package);
                                  })),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: postManButton(
                                    "Requests",
                                    true,
                                    () {
                                      Navigator.pushNamed(
                                          context, "/PackageRequests",
                                          arguments: package!.id);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () => con.deletePackage(package!),
                              child: Container(
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.delete,
                                        color: Colors.redAccent, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      "Delete Package",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Visibility(
                        visible: !mine,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: postManButton(
                                    "Decline",
                                    false,
                                    () => con
                                        .declineRequest(widget.request!.id))),
                            const SizedBox(width: 10),
                            Expanded(
                                child: postManButton("Accept", true, () {
                              // TODO: make a convesation for the two users
                              con.acceptRequest(widget.request!);
                            })),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

Widget subheading(txt) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        txt,
        textScaleFactor: 1,
        style: const TextStyle(
          color: greenColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

Widget packageDetails(context, package, mine) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                package!.name ?? "",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: greenColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Item# ${package!.id!.substring(0, 7)}",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        dimensions(context, package),
        subheading("Note to Postman"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  package!.userDetails!.noteToPostman ?? "",
                  textScaleFactor: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        subheading("Description"),
        Text(
          package!.description!,
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
        const SizedBox(height: 10),
        subheading("Take off location"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              detailsItem(
                  "Address", package!.shipmentAddress!.address!.nameAddress),
              detailsItem(
                  "Departure City", package!.shipmentAddress!.address!.city),
              detailsItem("Nearest Intersection",
                  package!.shipmentAddress!.intersection),
            ],
          ),
        ),
        const SizedBox(height: 10),
        subheading("Package Delivery Address"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              detailsItem(
                  "Address", package!.destinationAddress!.address!.nameAddress),
              detailsItem("Desstination City",
                  package!.destinationAddress!.address!.city),
              detailsItem("Nearest Intersection",
                  package!.destinationAddress!.intersection),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              detailsItem("Date", dateOnLy(package!.date)),
              detailsItem("Time", timeOnly(package!.date)),
            ],
          ),
        ),
        Visibility(
          visible: !mine,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: const EdgeInsets.only(top: 15, bottom: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.06),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Shipper",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  package!.senderName ?? "Shipper One",
                  textScaleFactor: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: !mine,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () async {
              await AppController()
                  .db
                  .collection("users")
                  .doc(package!.senderId)
                  .get()
                  .then((value) {
                Navigator.pushReplacementNamed(context, "/ConversationPage",
                    arguments:
                        User.fromMap(value.data() as Map<String, dynamic>));
              });
            },
            child: Row(
              children: <Widget>[
                Image.asset("assets/icons/chats.png",
                    height: 22, color: Colors.black),
                const SizedBox(width: 10),
                const Text(
                  "Contact Shipper",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios,
                    color: greenColor, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
