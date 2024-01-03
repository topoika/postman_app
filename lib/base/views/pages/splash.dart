import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../data/controllers/splash.controller.dart';
import '../../data/helper/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  late SplashController con;
  _SplashScreenState() : super(SplashController()) {
    con = controller as SplashController;
  }
  @override
  void initState() {
    super.initState();
    con.navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(),
              Image.asset(
                'assets/images/splash0.png',
                color: Colors.black,
                height: 200,
              ),
              Image.asset(
                "assets/images/loading.gif",
                height: getHeight(context, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
