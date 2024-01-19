import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/package.controller.dart';
import '../../../data/helper/helper.dart';
import '../../../data/models/package.dart';
import '../../components/buttons.dart';
import '../../components/input/universal.widget.dart';
import '../../components/universal.widgets.dart';

class ReceiverDetailsPage extends StatefulWidget {
  final dynamic data;
  const ReceiverDetailsPage({super.key, required this.data});

  @override
  _ReceiverDetailsPageState createState() => _ReceiverDetailsPageState();
}

class _ReceiverDetailsPageState extends StateMVC<ReceiverDetailsPage>
    with WidgetsBindingObserver {
  late PackageController con;
  _ReceiverDetailsPageState() : super(PackageController()) {
    con = controller as PackageController;
  }

  UserDetails userDetails = UserDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: CustomAppBar(title: "Receiver Details"),
      body: SingleChildScrollView(
        child: Form(
          key: con.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainHeading(context, "Sender Details"),
                InputFieldItem(
                  hint: "Sender Name",
                  label: "Sender Name",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) => userDetails.senderName = val,
                ),
                InputFieldItem(
                  hint: "Sender Mobile",
                  label: "Sender Mobile",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.senderMobile = val,
                ),
                mainHeading(context, "Receiver Details"),
                InputFieldItem(
                  hint: "Receiver’s Name",
                  label: "Receiver’s Name",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) => userDetails.recieverName = val,
                ),
                InputFieldItem(
                  hint: "Receiver’s Mobile",
                  label: "Receiver’s Mobile",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.recieverMobile = val,
                ),
                InputFieldItem(
                  hint: "Alternate Mobile No.",
                  label: "Alternate Mobile No.",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.recieverALtMobile = val,
                ),
                mainHeading(context, "Note For Postman"),
                InputFieldItem(
                  hint: "Note to postman",
                  label: "Come 20 minutes  before my take off time?",
                  onValidate: (val) => con.setError(val),
                  type: "description",
                  onsaved: (val) => userDetails.noteToPostman = val,
                ),
                const SizedBox(height: 20),
                buttonOne("Find a Postman", true, () {
                  if (con.formKey.currentState!.validate()) {
                    con.formKey.currentState!.save();
                    List<File> images = widget.data[1];
                    Package package = widget.data[0];
                    package.userDetails = userDetails;
                    con.addPackage(package, images);
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
