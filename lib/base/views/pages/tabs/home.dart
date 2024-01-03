import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/constants.dart';
import 'package:postman_app/base/data/helper/theme.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
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
        leading: GestureDetector(
          child: const Icon(
            Icons.sort,
            size: 32,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "👋 Welcome!",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              activeUser.value.username ?? "",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => con.logOut(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.notifications,
                size: 26,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          const Text('What task are  you performing \ntoday?',
              textScaleFactor: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 19),
              textAlign: TextAlign.center),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // TODO:Go to the add a itianary page
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/icons/postman.png",
                        color: greenColor,
                        height: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Post\nyour itinerary",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO:Go to the add a package page
                  Navigator.pushNamed(context, "/NewPackagePage");
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/icons/package.png",
                        color: greenColor,
                        height: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Ship\na package",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  primaryColor.withOpacity(.6),
                  Colors.white,
                  Colors.white
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('You can make money anywhere you go',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 20),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => showLearnMoreDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black),
                          child: const Text(
                            "Learn more",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Transform.scale(
                        scale: 1.6,
                        child: Image.asset("assets/images/undraw_savings.png")))
              ],
            ),
          ),
          const Text('Your Earnings',
              textScaleFactor: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 23),
              textAlign: TextAlign.left),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    statsItem(context, "Available for withdrawals", "\$280"),
                    statsItem(context, "Earnings this month", "\$340")
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
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                const Text('Invite your friends',
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20),
                    textAlign: TextAlign.left),
                const SizedBox(height: 10),
                const Text(
                    "Let your friend know what's up,  invite them to join this growing community of people helping each other  and making money while having fun!",
                    style: TextStyle()),
                Container(
                  transform: Matrix4.translationValues(0, 30, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: const Text(
                    "Invite now",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
