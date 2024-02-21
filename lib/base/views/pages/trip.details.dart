import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/helper.dart';

import '../../data/controllers/app.controller.dart';
import '../../data/controllers/trip.controller.dart';
import '../../data/helper/constants.dart';
import '../../data/models/trip.dart';
import '../components/buttons.dart';
import '../components/custom.switch.dart';
import '../components/universal.widgets.dart';

class TripDetailsPage extends StatefulWidget {
  final Trip trip;
  const TripDetailsPage({super.key, required this.trip});

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends StateMVC<TripDetailsPage> {
  late TripController con;
  _TripDetailsPageState() : super(TripController()) {
    con = controller as TripController;
  }
  Trip? trip;

  @override
  void initState() {
    super.initState();
    setTrip();
  }

  void setTrip() async {
    await con.getOneTrip(widget.trip.id!).then((value) {
      setState(() => trip = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool myTrip = widget.trip.travellersId == activeUser.value.id;
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: Text(
          myTrip ? "Trip Details" : "Postman",
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setTrip();
          Future.delayed(const Duration(seconds: 1));
        },
        child: trip == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            trip!.traveller!.image != null
                                ? showLargeImage(
                                    context, trip!.traveller!.image, null)
                                : toastShow(
                                    context, "No profile picture", "nor");
                          },
                          child: Container(
                            height: getWidth(context, 20),
                            width: getWidth(context, 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              image: trip!.traveller!.image != null
                                  ? DecorationImage(
                                      image: cachedImage(
                                          trip!.traveller!.image ??
                                              noUserImage),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                              shape: BoxShape.circle,
                              border: Border.all(width: .7, color: Colors.grey),
                            ),
                            child: trip!.traveller!.image == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(flex: 1, child: SizedBox(width: 20)),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    trip!.traveller!.username ?? "",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          color: oranfeColor, size: 18),
                                      Text(" 5.0",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      Text(" (116 Reviews)",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.verified,
                                      color: greenColor, size: 30),
                                  Text("Verified",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        detailsItem("Service Fee",
                            '\$${trip!.postageFee!.toStringAsFixed(2)}'),
                        detailsItem("Vehicle Type", trip!.travelMethod!.name),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        detailsItem("Departing Address",
                            trip!.departureDetails!.address!.nameAddress),
                        detailsItem("Departure City",
                            trip!.departureDetails!.address!.city),
                        detailsItem("Nearest Intersection",
                            trip!.departureDetails!.meetUpPlace),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        detailsItem(
                            "Date", dateOnLy(trip!.departureDetails!.date)),
                        detailsItem(
                            "Time", timeOnly(trip!.departureDetails!.date)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !myTrip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: greyColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          detailsItem("Distance From Customer",
                              "${calculateDistance(trip!.traveller!.address!).toStringAsFixed(1)} KM"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        detailsItem("Destination Address",
                            trip!.destinationDetails!.address!.nameAddress),
                        detailsItem("Destination City",
                            trip!.destinationDetails!.address!.city),
                        detailsItem("Nearest Intersection",
                            trip!.destinationDetails!.meetUpPlace),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        detailsItem(
                            "Date", dateOnLy(trip!.destinationDetails!.date)),
                        detailsItem(
                            "Time", timeOnly(trip!.destinationDetails!.date)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: myTrip,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: greyColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Available for Packages",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              CustomSwitch(
                                  value: trip!.available ?? true,
                                  onChanged: (val) {
                                    // update event availability
                                    setState(() => trip!.available = val);
                                    con.updatePostmanStatus(trip!.id!, val);
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        buttonOne(
                            "Edit Trip",
                            true,
                            () => Navigator.pushReplacementNamed(
                                context, "/NewTripPage",
                                arguments: trip)),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => con.cancelTrip(trip!.id!),
                          child: Container(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.close,
                                    color: Colors.redAccent, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  "Cancel Trip",
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !myTrip,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: postManButton(
                                "Message",
                                false,
                                () => Navigator.pushReplacementNamed(
                                    context, "/ConversationPage",
                                    arguments: trip!.traveller))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: postManButton(
                            "Send Request",
                            true,
                            () {
                              con.sendRequest(trip!);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

Widget detailsItem(txt, desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          txt,
          textScaleFactor: 1,
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Flexible(
          child: Text(
            desc,
            textAlign: TextAlign.end,
            textScaleFactor: 1,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
