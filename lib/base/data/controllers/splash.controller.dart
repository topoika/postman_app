import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.controller.dart';

class SplashController extends AppController {
  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String route = "/Onboading";
    if (prefs.containsKey("opened")) {
      if (auth.currentUser != null) {
        await getUserInfo(auth.currentUser!.uid)
            .then((value) => activeUser.value = value!);
        route = "/Pages";
      } else {
        route = "/Login";
      }
    }
    Future.delayed(const Duration(milliseconds: 10)).then((value) =>
        Navigator.pushReplacementNamed(scaffoldKey.currentContext!, route,
            arguments: 0));
  }
}
