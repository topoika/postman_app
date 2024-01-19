import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/package.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/package.dart';
import '../../components/auth/universal.widgets.dart' as auth;
import '../../components/buttons.dart';
import '../../components/input/universal.widget.dart';
import '../../components/universal.widgets.dart';

class NewPackagePage extends StatefulWidget {
  const NewPackagePage({super.key});

  @override
  _NewPackagePageState createState() => _NewPackagePageState();
}

class _NewPackagePageState extends StateMVC<NewPackagePage>
    with WidgetsBindingObserver {
  late PackageController con;
  _NewPackagePageState() : super(PackageController()) {
    con = controller as PackageController;
  }

  List<File> packageImage = [];
  bool insurance = false;
  bool packBySender = true;
  String weight = "Standard (0-5Kg)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: CustomAppBar(title: "Create a new shipment"),
      body: SingleChildScrollView(
        child: Form(
          key: con.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainHeading(context, "Package Images"),
                GestureDetector(
                  onTap: () => auth.showPickOptionsDialog(
                      context,
                      () => takePackageImage(context)
                          .then((val) => setState(() => packageImage.add(val))),
                      () => loadImages(context).then((val) {
                            setState(() => packageImage.addAll(val));
                          })),
                  child: packageImage.isEmpty
                      ? Container(
                          height: getHeight(context, 15.5),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: btnColor,
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.image_outlined, size: 42),
                              Text(
                                'Upload item Images',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: getHeight(context, 25),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ...packageImage
                                    .map(
                                      (i) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        height: getHeight(context, 25),
                                        width: getWidth(context, 70),
                                        alignment: Alignment.topRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: btnColor,
                                          image: DecorationImage(
                                            image: FileImage(i),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () => setState(() =>
                                              packageImage.removeAt(
                                                  packageImage.indexOf(i))),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black,
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                Container(
                                  height: getHeight(context, 12),
                                  width: getWidth(context, 70),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.add),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                InputFieldItem(
                  hint: "Item name",
                  label: "Name",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) => con.package.name = val,
                ),
                InputFieldItem(
                  hint: "Item value",
                  label: "Item Value",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => con.package.value = double.parse(val),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    mainHeading(context, "Do you need insurance Protection?"),
                    Row(
                      children: <Widget>[
                        radioItem(true, insurance, "Yes",
                            (val) => setState(() => insurance = val)),
                        radioItem(false, insurance, "No",
                            (val) => setState(() => insurance = val),
                            flex: 2),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    mainHeading(context, "Did you pack this package yourself?"),
                    Row(
                      children: <Widget>[
                        radioItem(true, packBySender, "Yes",
                            (val) => setState(() => packBySender = val)),
                        radioItem(false, packBySender, "No",
                            (val) => setState(() => packBySender = val),
                            flex: 2),
                      ],
                    ),
                  ],
                ),
                InputFieldItem(
                  hint: "Package description",
                  label: "Package description",
                  onValidate: (val) => con.setError(val),
                  type: "description",
                  onsaved: (val) => con.package.description = val,
                ),
                Visibility(
                  visible: insurance,
                  child: InputFieldItem(
                    hint: "Approximate item value",
                    label: "Approximate item value",
                    onValidate: (val) => con.setError(val),
                    type: "number",
                    onsaved: (val) =>
                        con.package.approximateValue = double.parse(val),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    mainHeading(context, "Select your weight"),
                    Row(
                      children: <Widget>[
                        radioItem(
                            "Standard (0-5Kg)",
                            weight,
                            "Standard (0-5Kg)",
                            (val) => setState(() => weight = val)),
                        radioItem(
                            "Parcel (5Kg Plus)",
                            weight,
                            "Parcel (5Kg Plus)",
                            (val) => setState(() => weight = val)),
                      ],
                    ),
                  ],
                ),
                mainHeading(context, "Size/ Dimensions (Inches)"),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InputFieldItem(
                        hint: "Length",
                        label: "Length",
                        onValidate: (val) => con.setError(val),
                        type: "number",
                        onsaved: (val) =>
                            con.package.dimLength = double.parse(val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputFieldItem(
                        hint: "Width",
                        label: "Width",
                        onValidate: (val) => con.setError(val),
                        type: "number",
                        onsaved: (val) =>
                            con.package.dimWidth = double.parse(val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputFieldItem(
                        hint: "Height",
                        label: "Height",
                        onValidate: (val) => con.setError(val),
                        type: "number",
                        onsaved: (val) =>
                            con.package.dimHeight = double.parse(val),
                      ),
                    ),
                  ],
                ),
                mainHeading(context, "Shipment Address"),
                pickAddressFields(context, "Shipment Address", "Address", () {
                  con.pickLocation().then((value) {
                    con.package.shipmentAddress =
                        PackageAddress(address: value);
                    setState(() {});
                  });
                }, address: con.package.shipmentAddress),
                InputFieldItem(
                  hint: "Shipment nearest intersection",
                  label: "Intersection",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) =>
                      con.package.shipmentAddress!.intersection = val,
                ),
                mainHeading(context, "Destination Address"),
                pickAddressFields(context, "Destination Address", "Address",
                    () {
                  con.pickLocation().then((value) {
                    con.package.destinationAddress =
                        PackageAddress(address: value);
                    setState(() {});
                  });
                }, address: con.package.destinationAddress),
                InputFieldItem(
                  hint: "Destination nearest intersection",
                  label: "Intersection",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) =>
                      con.package.destinationAddress!.intersection = val,
                ),
                mainHeading(context, "Date"),
                datePicker(context, "23-01-2023", "", () async {
                  await con.pickDateTime(context).then((value) {
                    if (value != null) {
                      con.package.date = value.toString();
                    } else {
                      con.package.date = DateTime.now().toString();
                    }
                    setState(() {});
                  });
                }, date: con.package.date),
                const SizedBox(height: 20),
                buttonOne("Add Package Reciever", true, () {
                  if (con.formKey.currentState!.validate()) {
                    con.formKey.currentState!.save();
                    if (packageImage.isEmpty) {
                      toastShow(
                          context, "Select package images to continue", 'err');
                    } else if (con.package.shipmentAddress!.address == null ||
                        con.package.destinationAddress!.address == null) {
                      toastShow(
                          context, "Select package address to contiue", 'err');
                    } else if (con.package.date == null) {
                      toastShow(context, "Select date to continue", 'err');
                    } else {
                      toastShow(context, "Success on this", 'suc');
                      con.package.insurance = insurance;
                      con.package.packBySender = packBySender;
                      con.package.weight = weight;
                      Navigator.pushNamed(context, "/ReceiverDetailsPage",
                          arguments: [con.package, packageImage]);
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
}

Widget radioItem(val, gVal, txt, onChange, {flex = 1}) {
  return Flexible(
    flex: flex,
    child: InkWell(
      splashColor: Colors.transparent,
      onTap: () => onChange(val),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.12,
            child: Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Colors.black,
              value: val,
              groupValue: gVal,
              onChanged: (value) => onChange(value),
            ),
          ),
          Text(
            txt,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
