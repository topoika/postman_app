import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/buttons.dart';
import '../../components/universal.widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends StateMVC<EditProfilePage> {
  late UserController con;
  _EditProfilePageState() : super(UserController()) {
    con = controller as UserController;
  }
  File? image;
  File? gvnId;
  File? passport;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/Pages", arguments: 4);
        return Future(() => true);
      },
      child: Scaffold(
        key: con.scaffoldKey,
        appBar: AppBar(
          leadingWidth: 68,
          leading: GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, "/Pages", arguments: 4),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: .4, color: Colors.grey)),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Edit Profile",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: con.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (activeUser.value.image != null ||
                                image != null) {
                              showLargeImage(
                                  context, activeUser.value.image, image);
                            }
                          },
                          child: Container(
                            height: getWidth(context, 20),
                            width: getWidth(context, 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : activeUser.value.image != null
                                      ? DecorationImage(
                                          image: cachedImage(
                                              activeUser.value.image ??
                                                  noUserImage),
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                              shape: BoxShape.circle,
                              border: Border.all(width: .7, color: Colors.grey),
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
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => showPickOptionsDialog(
                              context,
                              () => loadProfilePicker(
                                  ImageSource.camera,
                                  context,
                                  (val) => setState(() => image = File(val)),
                                  "profile"),
                              () => loadProfilePicker(
                                  ImageSource.gallery,
                                  context,
                                  (val) => setState(() => image = File(val)),
                                  "profile"),
                              profile: false),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Upload your profile photo",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  authInputField(
                      context,
                      "user.png",
                      "Username",
                      "username",
                      (val) => activeUser.value.username = val,
                      (val) => con.setError(val),
                      init: activeUser.value.username),

                  pickAddressFields(
                    context,
                    "Address",
                    () {
                      con.pickLocation().then((value) {
                        activeUser.value.address = value;
                        setState(() {});
                      });
                    },
                    image: "address.png",
                    initial: activeUser.value.address != null
                        ? activeUser.value.address!.nameAddress ?? ""
                        : "",
                  ),
                  authInputField(
                      context,
                      "phone.png",
                      "Phone No",
                      "phone",
                      (val) => activeUser.value.phone = val,
                      (val) => con.setError(val),
                      init: activeUser.value.phone),
                  authInputField(
                      context,
                      "bank.png",
                      "ID Number",
                      "id",
                      (val) => activeUser.value.idNumber = val,
                      (val) => con.setError(val),
                      init: activeUser.value.idNumber),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                              onTap: () => showPickOptionsDialog(
                                    context,
                                    () => loadProfilePicker(
                                        ImageSource.camera,
                                        context,
                                        (val) =>
                                            setState(() => gvnId = File(val)),
                                        "id"),
                                    () => loadProfilePicker(
                                        ImageSource.gallery,
                                        context,
                                        (val) =>
                                            setState(() => gvnId = File(val)),
                                        "id"),
                                  ),
                              child: Container(
                                height: getHeight(context, 13.5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: btnColor.withOpacity(.2),
                                    image: gvnId != null
                                        ? DecorationImage(
                                            image: FileImage(gvnId!),
                                            fit: BoxFit.cover,
                                          )
                                        : activeUser.value.governmentId != null
                                            ? DecorationImage(
                                                image: cachedImage(activeUser
                                                        .value.governmentId ??
                                                    noUserImage),
                                                fit: BoxFit.fill,
                                              )
                                            : null),
                                child: gvnId != null
                                    ? const SizedBox()
                                    : const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.upload),
                                          SizedBox(height: 15),
                                          Text(
                                            'Upload Government ID',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                              )),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => showPickOptionsDialog(
                              context,
                              () => loadProfilePicker(
                                  ImageSource.camera,
                                  context,
                                  (val) => setState(() => passport = File(val)),
                                  "id"),
                              () => loadProfilePicker(
                                  ImageSource.gallery,
                                  context,
                                  (val) => setState(() => passport = File(val)),
                                  "id"),
                            ),
                            child: Container(
                              height: getHeight(context, 13.5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: btnColor.withOpacity(.2),
                                  image: passport != null
                                      ? DecorationImage(
                                          image: FileImage(passport!),
                                          fit: BoxFit.cover,
                                        )
                                      : activeUser.value.passport != null
                                          ? DecorationImage(
                                              image: cachedImage(
                                                  activeUser.value.passport ??
                                                      noUserImage),
                                              fit: BoxFit.fill,
                                            )
                                          : null),
                              child: passport != null
                                  ? const SizedBox()
                                  : const Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.upload),
                                        SizedBox(height: 15),
                                        Text(
                                          'Passport/Driver License ',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonOne("Update", true, () {
                    if (con.formKey.currentState!.validate()) {
                      con.formKey.currentState!.save();
                      if (activeUser.value.address != null) {
                        con.updateUserInfo(
                            activeUser.value, image, gvnId, passport);
                      } else {
                        toastShow(context,
                            "Please pick and address to continue", "err");
                      }
                    } else {
                      con.error != null
                          ? toastShow(context, con.error.toString(), "err")
                          : null;
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
