import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../../components/buttons.dart';
import '../../components/home/universal.widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends StateMVC<Homepage> {
  late UserController con;
  _HomepageState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: scafoldBlack,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/MorePage"),
          child: const Icon(
            Icons.sort,
            size: 32,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        title: Text(
          "👋 Welcome! ${activeUser.value.username}",
          textScaleFactor: 1,
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            onTap: () => log(activeUser.value.deviceToken!),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.notifications,
                size: 26,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: scafoldBlack,
            child: Stack(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What task are you',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 21),
                          textAlign: TextAlign.left),
                      Text('performing today?',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 26),
                          textAlign: TextAlign.left),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 160, bottom: 0),
                  transform: Matrix4.translationValues(0, 2, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                          .copyWith(top: 80),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Your Earnings',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 21),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.09),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                statsItem(context, "Available for withdrawal",
                                    "\$280"),
                                statsItem(
                                    context, "Earnings this month", "\$340")
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                statsItem(context, "Active orders", "6"),
                                statsItem(context, "Complete orders", "20")
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20)
                          .copyWith(top: 110),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, "/NewTripPage"),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: greenColor.withOpacity(.12),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/icons/postman.png",
                                height: 35,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Post your Itinerary",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )),
                      const SizedBox(
                        height: 90,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: VerticalDivider(
                                color: greenColor,
                                thickness: 1.4,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.radio_button_on_rounded,
                                  color: greenColor, size: 17),
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: greenColor,
                                thickness: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "/NewPackagePage"),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: greenColor.withOpacity(.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/icons/package.png",
                                  height: 35,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Ship a package",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(colors: [
                  Color(0xff1BC07A),
                  Color(0xff217b55),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/earn.png",
                    height: 150,
                    opacity: const AlwaysStoppedAnimation(.69),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('You can make\nmoney anywhere you go',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 22),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 20),
                      learnMoreButton(
                          "Learn more", () => showLearnMoreDialog(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(colors: [
                  Color(0xff1BC07A),
                  Color(0xff217b55),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/invite.png",
                    height: 150,
                    opacity: const AlwaysStoppedAnimation(.95),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Invite your friends',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 22),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 5),
                      const Text(
                          "Join our vibrant community—helping,\nearning, and having fun together!",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 5),
                      learnMoreButton(
                          "Invite Now", () => showLearnMoreDialog(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
