import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/helper.dart';
import 'package:postman_app/base/views/components/buttons.dart';
import 'package:place_picker/place_picker.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:postman_app/env.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/models/address.dart';
import '../../components/auth/universal.widgets.dart';
import '../../components/universal.widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends StateMVC<RegisterPage> {
  late UserController con;
  _RegisterPageState() : super(UserController()) {
    con = controller as UserController;
  }
  File? image;
  File? gvnId;
  File? passport;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      body: Form(
        key: con.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          children: [
            const SizedBox(height: 30),
            Image.asset("assets/images/logo.png", height: 90),
            const SizedBox(height: 20),
            topColumnText(context, "Let’s create your account",
                "Enter your details to get things started."),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (activeUser.value.image != null || image != null) {
                        showLargeImage(context, activeUser.value.image, image);
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
                                        activeUser.value.image ?? noUserImage),
                                    fit: BoxFit.fill,
                                  )
                                : null,
                        shape: BoxShape.circle,
                        border: Border.all(width: .7, color: Colors.grey),
                      ),
                      child: activeUser.value.image == null && image == null
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
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Upload ',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.edit_outlined,
                          size: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            authInputField(
                context,
                "user.png",
                "Username",
                "username",
                (val) => activeUser.value.username = val,
                (val) => con.setError(val)),
            authInputField(
                context,
                "email.png",
                "Email Address",
                "email",
                (val) => activeUser.value.email = val,
                (val) => con.setError(val)),
            authInputField(
                context,
                "password.png",
                "Password",
                "password",
                (val) => activeUser.value.password = val,
                (val) => con.setError(val),
                obs: con.obs,
                setObs: con.setObs),
            pickAddressFields(
              context,
              "Address",
              () {
                pickLocation(context).then((value) {
                  activeUser.value.address = value;
                  setState(() {});
                });
              },
              image: "address.png",
              initial: activeUser.value.address != null
                  ? activeUser.value.address!.nameAddress ?? ""
                  : "",
            ),
            // authInputField(
            //     context,
            //     ,
            //     "Address",
            //     "address",
            //     (val) => activeUser.value.address = val,
            //     (val) => con.setError(val)),
            authInputField(
                context,
                "phone.png",
                "Phone No",
                "phone",
                (val) => activeUser.value.phone = val,
                (val) => con.setError(val)),
            authInputField(
                context,
                "bank.png",
                "ID Number",
                "id",
                (val) => activeUser.value.governmentId = val,
                (val) => con.setError(val)),
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
                                  (val) => setState(() => gvnId = File(val)),
                                  "id"),
                              () => loadProfilePicker(
                                  ImageSource.gallery,
                                  context,
                                  (val) => setState(() => gvnId = File(val)),
                                  "id"),
                            ),
                        child: Container(
                          height: getHeight(context, 13.5),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: btnColor,
                              image: gvnId != null
                                  ? DecorationImage(
                                      image: FileImage(gvnId!),
                                      fit: BoxFit.cover,
                                    )
                                  : activeUser.value.governmentId != null
                                      ? DecorationImage(
                                          image: cachedImage(
                                              activeUser.value.governmentId ??
                                                  noUserImage),
                                          fit: BoxFit.fill,
                                        )
                                      : null),
                          child: gvnId != null
                              ? const SizedBox()
                              : const Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      () => loadProfilePicker(ImageSource.camera, context,
                          (val) => setState(() => passport = File(val)), "id"),
                      () => loadProfilePicker(ImageSource.gallery, context,
                          (val) => setState(() => passport = File(val)), "id"),
                    ),
                    child: Container(
                      height: getHeight(context, 13.5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: btnColor,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                  ))
                ],
              ),
            ),
            buttonOne("Register", true, () {
              if (con.formKey.currentState!.validate()) {
                con.formKey.currentState!.save();
                if (gvnId == null) {
                  toastShow(context, "Upload Government ID to continue", "err");
                } else if (image == null) {
                  toastShow(context, "Upload profile image to continue", "err");
                } else {
                  if (activeUser.value.address != null) {
                    con.register(activeUser.value, image, gvnId, passport);
                  } else {
                    toastShow(
                        context, "Please pick and address to continue", "err");
                  }
                }
              } else {
                con.error != null
                    ? toastShow(context, con.error.toString(), "err")
                    : null;
              }
            }),
            const LoginOrSignUpText(
                link: "Login", main: "Already have and account? "),
          ],
        ),
      ),
    );
  }

  Future<Address?> pickLocation(BuildContext context) async {
    try {
      // LocationData currentLocation = await Location().getLocation();
      LocationResult? result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            MAP_API,
            defaultLocation: const LatLng(56.1304, 106.3468),
          ),
        ),
      );

      if (result != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            result.latLng!.latitude, result.latLng!.longitude);

        Placemark place = placemarks.first;

        // Return the address details in the specified format
        return Address(
            address: place.street ?? '',
            country: place.country ?? '',
            state: place.administrativeArea ?? '',
            latitude: result.latLng!.latitude,
            longitude: result.latLng!.longitude,
            nameAddress: result.name ?? "");
      }
      return null;
    } catch (e) {
      print('Error picking location: $e');
    }
    return null;
  }
}
