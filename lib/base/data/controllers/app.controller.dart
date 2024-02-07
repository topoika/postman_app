import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postman_app/base/data/models/package.dart';

import '../../../main.dart';
import '../../views/components/auth/success.dialog.dart';
import '../models/user.dart' as userModel;

import '../helper/constants.dart';
import 'main.controller.dart';

class AppController extends MainController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isloggedIn = FirebaseAuth.instance.currentUser != null;

  // COLLECTIONS STRINGS
  String userCol = "users";
  String tripsCol = "trips";
  String commentsCol = "comments";
  String chatsColl = "chats";
  String messagesColl = "messages";
  String packageColl = "packages";
  String requestColl = "requests";

  void openDrawer() => Scaffold.of(scaffoldKey.currentContext!).openDrawer();
  Future<String> getFCM() async {
    return await firebaseMessaging.getToken().then((value) => value.toString());
  }

  Future<String> getUserFCM(String? id) async => await db
      .collection(userCol)
      .doc(id)
      .get()
      .then((value) => value.data()!['deviceToken']);

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

  void showSuccessDialog(title, desc, btn, route) {
    showDialog(
      context: Get.context!,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: SuccessDialog(
              title: title, description: desc, btnText: btn, route: route),
        );
      },
    );
  }

  Future<List<String>?> uploadImagesToFirebase(
      List<File> files, String path) async {
    List<String> results = [];
    try {
      for (var file in files) {
        final Reference storageReference = storage
            .ref()
            .child('images/$path/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageReference.putFile(file);
        final String downloadURL = await storageReference.getDownloadURL();
        results.add(downloadURL);
      }
      return results;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<bool>? sendNotification(String token, String title, String id,
      {String type = "message"}) async {
    final Map<String, dynamic> data = {
      'to': token,
      'notification': {
        'title': title,
        'body':
            "You have a new ${type == "request" ? "Order request" : "Message"}",
      },
      "data": {"id": id, "type": type}
    };

    final http.Response response = await http.post(
      Uri.parse(SERVER_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$SERVER_KEY',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      log('Notification sent successfully');
      return true;
    } else {
      log('Failed to send notification. Response code: ${response.statusCode}');
      log('Response body: ${response.body}');
      return false;
    }
  }
}

ValueNotifier<userModel.User> activeUser =
    ValueNotifier<userModel.User>(userModel.User());
ValueNotifier<Package> activePackage = ValueNotifier<Package>(Package());

final filePicker = ImagePicker();

void loadProfilePicker(ImageSource source, context, onsaved, type) async {
  final pickedFile = await filePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100);
  cropImage(File(pickedFile!.path), context, onsaved, type);
  Navigator.pop(context);
}

Future<List<File>> loadImages(context) async {
  List<File> files = [];
  final pickedImages = await filePicker.pickMultiImage(imageQuality: 100);
  for (var file in pickedImages) {
    files.add(File(file.path));
  }
  Navigator.pop(context);
  return files;
}

Future<File> takePackageImage(context) async {
  final pickedFile = await filePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100);
  Navigator.pop(context);

  return File(pickedFile!.path);
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
