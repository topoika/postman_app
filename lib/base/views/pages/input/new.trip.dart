import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../data/controllers/app.controller.dart';
import '../../components/auth/universal.widgets.dart' as auth;

import '../../../data/controllers/trip.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/travel.method.dart';
import '../../../data/models/trip.dart';
import '../../components/buttons.dart';
import '../../components/input/universal.widget.dart';
import '../../components/universal.widgets.dart';
import 'new.package.dart';

class NewTripPage extends StatefulWidget {
  const NewTripPage({super.key});

  @override
  _NewTripPageState createState() => _NewTripPageState();
}

class _NewTripPageState extends StateMVC<NewTripPage>
    with WidgetsBindingObserver {
  late TripController con;
  _NewTripPageState() : super(TripController()) {
    con = controller as TripController;
  }
  File? ticket;

  @override
  void initState() {
    super.initState();
    setState(() {
      con.trip.travellerIs = "Driver";
      con.trip.travelMethod = travelMethods.firstWhere((i) => i.id == 3);
      con.trip.vehicleDetails = VehicleDetails();
      con.trip.departureDetails = DepartureDetails();
      con.trip.destinationDetails = DepartureDetails();
      con.trip.planDetails = PlaneDetails();
      con.trip.trainDetails = TrainDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: CustomAppBar(title: "Travel Details"),
      body: SingleChildScrollView(
        child: Form(
          key: con.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: mainHeading(context, "Select your Travel Method"),
                ),
                Wrap(
                  children: travelMethods.map((e) {
                    bool selected = e.id == con.trip.travelMethod!.id;
                    return GestureDetector(
                      onTap: () => setState(() {
                        con.trip.travelMethod = e;
                        if ([1, 4].contains(e.id)) {
                          con.trip.vehicleDetails = null;
                        } else {
                          con.trip.vehicleDetails = VehicleDetails();
                        }
                        if ([1, 2, 3, 5, 6].contains(e.id)) {
                          con.trip.trainDetails = null;
                        } else {
                          ticket = null;
                          con.trip.planDetails = null;
                        }
                      }),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10)
                                .copyWith(right: 10, bottom: 5),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    selected ? greenColor : Colors.transparent,
                                border: Border.all(
                                    width: 1,
                                    color: selected
                                        ? Colors.transparent
                                        : Colors.black)),
                            child: Image.asset(
                              "assets/icons/${e.icon}",
                              height: 35,
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            e.name.toString(),
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Visibility(
                  visible: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      mainHeading(context, "Upload Ticket if you have one"),
                      GestureDetector(
                        onTap: () => auth.showPickOptionsDialog(
                            context,
                            () => loadProfilePicker(
                                ImageSource.camera,
                                context,
                                (val) => setState(() => ticket = File(val)),
                                "id"),
                            () => loadProfilePicker(
                                ImageSource.gallery,
                                context,
                                (val) => setState(() => ticket = File(val)),
                                "id")),
                        child: ticket == null
                            ? Container(
                                height: getHeight(context, 15.5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: btnColor.withOpacity(.1),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.image_outlined, size: 42),
                                    Text(
                                      'Upload Ticket if you have one',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(right: 15),
                                height: getHeight(context, 25),
                                // width: getWidth(context, 70),
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: btnColor,
                                  image: DecorationImage(
                                    image: FileImage(ticket!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: ![1, 4].contains(con.trip.travelMethod!.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      mainHeading(context, "Are you a ?"),
                      Row(
                        children: <Widget>[
                          radioItem(
                              "Driver",
                              con.trip.travellerIs,
                              "Driver",
                              (val) =>
                                  setState(() => con.trip.travellerIs = val)),
                          radioItem(
                              "Shipping Company",
                              con.trip.travellerIs,
                              "Shipping Company",
                              (val) =>
                                  setState(() => con.trip.travellerIs = val),
                              flex: 2),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          radioItem(
                              "Passenger",
                              con.trip.travellerIs,
                              "Passenger",
                              (val) =>
                                  setState(() => con.trip.travellerIs = val)),
                          radioItem(
                              "Conductor",
                              con.trip.travellerIs,
                              "Conductor",
                              (val) =>
                                  setState(() => con.trip.travellerIs = val),
                              flex: 2),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: ![1, 4].contains(con.trip.travelMethod!.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      mainHeading(context, "Vehicle Details"),
                      InputFieldItem(
                        hint: "Vehicle Identification",
                        label: "Vehicle Identification",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.vehicleDetails!.vehicleIdentity = val,
                      ),
                      InputFieldItem(
                        hint: "Transport Company",
                        label: "Transport Company",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.vehicleDetails!.transportCompany = val,
                      ),
                      InputFieldItem(
                        hint: "License Plate",
                        label: "License Plate",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.vehicleDetails!.vehicleLicencePlate = val,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: [4].contains(con.trip.travelMethod!.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      mainHeading(context, "Train Details"),
                      InputFieldItem(
                        hint: "Train Name",
                        label: "Train Name",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.trainDetails!.trainName = val,
                      ),
                      InputFieldItem(
                        hint: "Train Number",
                        label: "Train No.",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.trainDetails!.trainNumber = val,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: [1].contains(con.trip.travelMethod!.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      mainHeading(context, "Airline Details"),
                      InputFieldItem(
                        hint: "Plane Name",
                        label: "Plane Name",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) => con.trip.planDetails!.planeName = val,
                      ),
                      InputFieldItem(
                        hint: "Plane Number",
                        label: "Plane No.",
                        onValidate: (val) => con.setError(val),
                        type: "text",
                        onsaved: (val) =>
                            con.trip.planDetails!.planeNumber = val,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                mainHeading(context, "Departing Details"),
                pickAddressFields(
                    context, "Departing Address", "Departing Address", () {
                  con.pickLocation().then((value) {
                    con.trip.departureDetails!.address = value;
                    setState(() {});
                  });
                }, address: con.trip.departureDetails),
                InputFieldItem(
                  hint: "Nearby Places",
                  label: "Nearby Places",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) =>
                      con.trip.departureDetails!.meetUpPlace = val,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: datePicker(context, "", "Date", () async {
                      await con.pickDate(context).then((value) {
                        if (value != null) {
                          con.trip.departureDetails!.date = value.toString();
                        } else {
                          con.trip.departureDetails!.date =
                              DateTime.now().toString();
                        }
                        setState(() {});
                      });
                    }, date: con.trip.departureDetails!.date)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: timePicker(context, "", "Time", () async {
                      await con.pickTime(context).then((value) {
                        if (value != null) {
                          con.trip.departureDetails!.time = value.toString();
                        } else {
                          con.trip.departureDetails!.time =
                              DateTime.now().toString();
                        }
                        setState(() {});
                      });
                    }, time: con.trip.departureDetails!.time)),
                  ],
                ),
                const SizedBox(height: 10),
                mainHeading(context, "Destination Details"),
                pickAddressFields(
                    context, "Destination Address", "Destination Address", () {
                  con.pickLocation().then((value) {
                    con.trip.destinationDetails!.address = value;
                    setState(() {});
                  });
                }, address: con.trip.destinationDetails),
                InputFieldItem(
                  hint: "Nearby Places",
                  label: "Nearby Places",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) =>
                      con.trip.destinationDetails!.meetUpPlace = val,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: datePicker(context, "", "Date", () async {
                      await con.pickDate(context).then((value) {
                        if (value != null) {
                          con.trip.destinationDetails!.date = value.toString();
                        } else {
                          con.trip.destinationDetails!.date =
                              DateTime.now().toString();
                        }
                        setState(() {});
                      });
                    }, date: con.trip.destinationDetails!.date)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: timePicker(context, "", "Time", () async {
                      await con.pickTime(context).then((value) {
                        if (value != null) {
                          con.trip.destinationDetails!.time = value.toString();
                        } else {
                          con.trip.destinationDetails!.time =
                              DateTime.now().toString();
                        }
                        setState(() {});
                      });
                    }, time: con.trip.destinationDetails!.time)),
                  ],
                ),
                const SizedBox(height: 10),
                mainHeading(context, "Package Preference"),
                InputFieldItem(
                  hint: "Package preference",
                  label: "E.g ; Small bags & Envelope only",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) => con.trip.packagePrefernces = val,
                ),
                const SizedBox(height: 10),
                mainHeading(context, "Guide to meet up"),
                InputFieldItem(
                  hint: "Guide to meet up",
                  label: "Tell customer where bring the package",
                  onValidate: (val) => con.setError(val),
                  type: "description",
                  onsaved: (val) => con.trip.guideToMeet = val,
                ),
                const SizedBox(height: 10),
                mainHeading(context, "Postage fee"),
                InputFieldItem(
                  hint: "Postage fee",
                  label: "Postage fee",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => con.trip.postageFee = double.parse(val),
                ),
                const SizedBox(height: 20),
                buttonOne("Go Live", true, () {
                  if (con.formKey.currentState!.validate()) {
                    con.formKey.currentState!.save();
                    String? desterror =
                        getError(con.trip.destinationDetails!, "destination");
                    String? deperror =
                        getError(con.trip.departureDetails!, "departure");
                    log(desterror.toString());
                    if (desterror != null || deperror != null) {
                      toastShow(context, desterror ?? deperror ?? "", 'err');
                    } else {
                      con.addTrip(con.trip, ticket);
                    }
                  } else {
                    con.error != null
                        ? toastShow(context, con.error.toString(), "err")
                        : null;
                  }
                }),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getError(DepartureDetails details, String type) {
    if (details.address == null) {
      return "Pick $type address to continue";
    } else if (details.date == null) {
      return "Select $type date to continue";
    } else if (details.time == null) {
      return "Select $type time to continue";
    }
    return null;
  }
}
