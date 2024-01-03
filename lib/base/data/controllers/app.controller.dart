import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:place_picker/place_picker.dart';

import '../../../env.dart';
import '../helper/helper.dart';
import '../models/address.dart';
import '../models/user.dart' as userModel;

import '../helper/constants.dart';

class AppController extends ControllerMVC {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isloggedIn = FirebaseAuth.instance.currentUser != null;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OverlayEntry loader = Helper.overlayLoader();
  late GlobalKey<ScaffoldState> scaffoldKey;

  // COLLECTIONS STRINGS
  String userCol = "users";
  String feedsCol = "feeds";
  String carsCol = "cars";
  String commentsCol = "comments";
  AppController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }
  Future<String> getFCM() async {
    return await firebaseMessaging.getToken().then((value) => value.toString());
  }

  Future<userModel.User?> getUserInfo(String id) async {
    return await db.collection(userCol).doc(id).get().then(
      (value) {
        if (value.exists) {
          return userModel.User.fromMap(value.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      },
      onError: (error) {
        print("Error retrieving user info: $error");
      },
    );
  }

  Future<String?> uploadImageToFirebase(File file, String path) async {
    try {
      final Reference storageReference = storage
          .ref()
          .child('images/$path/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(file);
      final String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<Address?> pickLocation() async {
    try {
      // LocationData currentLocation = await Location().getLocation();
      LocationResult? result =
          await Navigator.of(scaffoldKey.currentContext!).push(
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

ValueNotifier<userModel.User> activeUser =
    ValueNotifier<userModel.User>(userModel.User());

final filePicker = ImagePicker();

void loadProfilePicker(ImageSource source, context, onsaved, type) async {
  final pickedFile = await filePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100);
  cropImage(File(pickedFile!.path), context, onsaved, type);
  Navigator.pop(context);
}

cropImage(File picked, context, onsaved, type) async {
  final cropped = await ImageCropper().cropImage(
    sourcePath: picked.path,
    cropStyle: CropStyle.rectangle,
    aspectRatio: CropAspectRatio(
        ratioX: getHeight(context, 25),
        ratioY: getHeight(context, type == "id" ? 13.5 : 25)),
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: '$appName Crop Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      IOSUiSettings(
        title: '$appName Cropper',
      ),
    ],
    maxWidth: getWidth(context, 100).toInt(),
  );
  if (cropped != null) {
    onsaved(cropped.path);
  }
}

bool isValidDate(val) => RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(val);

bool validName(val) => RegExp(r'^[a-zA-Z\s]+$').hasMatch(val);

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

String? validatePhone(String value) {
  if (value.isEmpty) {
    return 'Phone number is required';
  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Invalid phone number format';
  }
  return null;
}

String? validateIdNumber(String value) {
  if (value.isEmpty) {
    return 'ID Number is required';
  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Invalid ID number format';
  }
  return null;
}

String? validateAddress(String value) {
  if (value.isEmpty) {
    return 'Address is required';
  }
  return null;
}

String? validatePassword(String value, {bool confirm = false}) {
  if (value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (confirm && value != activeUser.value.password) {
    return "Passwords provide do not match";
  }
  return null;
}
