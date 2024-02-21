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
  Package? package;
  @override
  void initState() {
    super.initState();
    package = widget.data[0];
    package!.id != null ? userDetails = package!.userDetails! : null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool edit = package != null && package!.id != null;
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: Text(
          edit ? "Update Receiver Details" : "Receiver Details",
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
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
                  init: userDetails.senderName,
                ),
                InputFieldItem(
                  hint: "Sender Mobile",
                  label: "Sender Mobile",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.senderMobile = val,
                  init: userDetails.senderMobile,
                ),
                mainHeading(context, "Receiver Details"),
                InputFieldItem(
                  hint: "Receiver’s Name",
                  label: "Receiver’s Name",
                  onValidate: (val) => con.setError(val),
                  type: "text",
                  onsaved: (val) => userDetails.recieverName = val,
                  init: userDetails.recieverName,
                ),
                InputFieldItem(
                  hint: "Receiver’s Mobile",
                  label: "Receiver’s Mobile",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.recieverMobile = val,
                  init: userDetails.recieverMobile,
                ),
                InputFieldItem(
                  hint: "Alternate Mobile No.",
                  label: "Alternate Mobile No.",
                  onValidate: (val) => con.setError(val),
                  type: "number",
                  onsaved: (val) => userDetails.recieverALtMobile = val,
                  init: userDetails.recieverALtMobile,
                ),
                mainHeading(context, "Note For Postman"),
                InputFieldItem(
                  hint: "Note to postman",
                  label: "Come 20 minutes  before my take off time?",
                  onValidate: (val) => con.setError(val),
                  type: "description",
                  onsaved: (val) => userDetails.noteToPostman = val,
                  init: userDetails.noteToPostman,
                ),
                const SizedBox(height: 20),
                buttonOne(edit ? "Update Package Info" : "Find a Postman", true,
                    () {
                  if (con.formKey.currentState!.validate()) {
                    con.formKey.currentState!.save();
                    List<File> images = widget.data[1];
                    package!.userDetails = userDetails;
                    edit
                        ? con.updatePackage(package!, images)
                        : con.addPackage(package!, images);
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
