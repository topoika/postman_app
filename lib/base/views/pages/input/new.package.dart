import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/views/components/buttons.dart';

import '../../../data/controllers/package.controller.dart';
import '../../../data/models/package.dart';
import '../../components/input/universal.widget.dart';
import '../../components/universal.widgets.dart';

class NewPackagePage extends StatefulWidget {
  const NewPackagePage({super.key});

  @override
  _NewPackagePageState createState() => _NewPackagePageState();
}

class _NewPackagePageState extends StateMVC<NewPackagePage> {
  late PackageController con;
  _NewPackagePageState() : super(PackageController()) {
    con = controller as PackageController;
  }
  Package package = Package();
  List<File>? packageImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: CustomAppBar(title: "Create a new shipment"),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          children: [
            inputField(context, "Item name", "Name",
                (val) => package.name = val, "text"),
            inputField(context, "Item value", "Value",
                (val) => package.value = val, "number"),
            inputField(context, "Describe your packages...", "Description",
                (val) => package.description = val, "description"),
            // TODO:==> Add the extimated value to the package model
            inputField(context, "Estimate value", "Aproximate value",
                (val) => package.value = val, "number"),
            mainHeading(context, "Shipment Address"),
            pickAddressFields(context, "Shipment Address", "Address", () {
              con.pickLocation().then((value) {
                package.shipmentAddress!.address = value;
                setState(() {});
              });
            }, address: package.shipmentAddress),
            inputField(context, "Nearer Intersection", "Intersection",
                (val) => package.shipmentAddress!.intersection = val, "text"),
            mainHeading(context, "Destination Address"),
            pickAddressFields(context, "Destination Address", "Address", () {
              con.pickLocation().then((value) {
                package.destinationAddress!.address = value;
                setState(() {});
              });
            }, address: package.destinationAddress),

            inputField(
                context,
                "Nearer Intersection",
                "Intersection",
                (val) => package.destinationAddress!.intersection = val,
                "text"),

            const SizedBox(height: 20),
            buttonOne("Add Package Reciever", true, () {}),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
