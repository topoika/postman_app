import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/helper/constants.dart';

class Onboading extends StatefulWidget {
  const Onboading({super.key});

  @override
  State<Onboading> createState() => _OnboadingState();
}

class _OnboadingState extends State<Onboading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.4),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/splash.gif',
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            bottom: 40,
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("opened", true);
                Navigator.pushReplacementNamed(context, "/Register");
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width - 30,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: const Text(
                  "Start Here",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
