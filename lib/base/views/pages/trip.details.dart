import 'package:flutter/material.dart';

import '../../data/controllers/app.controller.dart';
import '../../data/helper/constants.dart';
import '../components/buttons.dart';
import '../components/universal.widgets.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 64,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset("assets/icons/back.png")),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Postman",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showLargeImage(context, activeUser.value.image, null);
                  },
                  child: Container(
                    height: getWidth(context, 20),
                    width: getWidth(context, 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      image: activeUser.value.image != null
                          ? DecorationImage(
                              image: cachedImage(
                                  activeUser.value.image ?? noUserImage),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(flex: 1, child: SizedBox(width: 20)),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            activeUser.value.username ?? "",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: oranfeColor, size: 18),
                              Text(" 5.0",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              Text(" (116 Reviews)",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.verified, color: greenColor, size: 30),
                          Text("Verified",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
            child: Column(
              children: <Widget>[
                detailsItem("Service Fee", '\$20'),
                detailsItem("Vehicle Type", 'Car'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
            child: Column(
              children: <Widget>[
                detailsItem("Departing Address", "12 Garlfield Crescent"),
                detailsItem("Departure City", 'Toronto'),
                detailsItem("Nearest Intersection", 'Queen & Kennedy'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
            child: Column(
              children: <Widget>[
                detailsItem("Date", "January 9th, 2023"),
                detailsItem("Time", '11:00 PM'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
            child: Column(
              children: <Widget>[
                detailsItem("Distance From Customer", "2 KM"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
            child: Column(
              children: <Widget>[
                detailsItem("Destination Address", "120 Col Road"),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(child: postManButton("Message", false, () {})),
              const SizedBox(width: 10),
              Expanded(child: postManButton("Hire Postman", true, () {})),
            ],
          )
        ],
      ),
    );
  }

  Widget detailsItem(txt, desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            txt,
            textScaleFactor: 1,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          Text(
            desc,
            textScaleFactor: 1,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
