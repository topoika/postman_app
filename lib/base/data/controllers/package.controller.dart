import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../views/components/auth/success.dialog.dart';
import '../helper/helper.dart';
import '../models/package.dart';
import 'app.controller.dart';

class PackageController extends AppController {
  Package package = Package();
  String? error;

  setError(val) => setState(() => error = val);

  void addPackage(Package package, List<File> images) async {
    Overlay.of(scaffoldKey.currentContext!).insert(loader);
    try {
      if (images.isNotEmpty) {
        package.images =
            await uploadImagesToFirebase(images, "packages/images");
      }
      package.senderId = activeUser.value.id!;
      log(package.toMap().toString());
      await db.collection(packageColl).add(package.toMap()).then((value) {
        value.update({'id': value.id});
        loader.remove();
        showSuccessDialogBox(scaffoldKey.currentContext!,
            "Your package has been posted!", "", "/", "Find a Postman");
      });
    } catch (e) {
      loader.remove();
      log(e.toString());
      toastShow(scaffoldKey.currentContext!,
          "An error occurred, please try again", 'err');
    }
  }
}
