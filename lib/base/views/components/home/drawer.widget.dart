import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../universal.widgets.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  late UserController con;
  _DrawerWidgetState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showLargeImage(context, activeUser.value.image, null);
                    },
                    child: Container(
                      height: getWidth(context, 18),
                      width: getWidth(context, 18),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(.3),
                        image: activeUser.value.image != null
                            ? DecorationImage(
                                image: cachedImage(
                                    activeUser.value.image ?? noUserImage),
                                fit: BoxFit.fill,
                              )
                            : null,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.2, color: greenColor),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      activeUser.value.username!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 10),
                  menuItem(Icons.airplane_ticket_sharp, "My Trips", () {}),
                  menuItem(
                      Icons.breakfast_dining_rounded, "My Shipments", () {}),
                  menuItem(
                      Icons.notifications_active,
                      "Available Orders",
                      () =>
                          Navigator.pushNamed(context, "/AvailableOrdersPage")),
                ],
              ),
            ),
          ),
          menuItem(Icons.info, "About Us", () {}),
          menuItem(Icons.thumb_up, "Feedback", () {}),
          menuItem(Icons.logout, "Log Out", () => con.logOut()),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, txt, ontap) => InkWell(
        onTap: () {
          Navigator.pop(context);
          ontap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: txt == "Log Out" ? Colors.redAccent : Colors.black,
              ),
              const SizedBox(width: 7),
              Text(
                txt,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: txt == "Log Out" ? Colors.redAccent : Colors.black,
                ),
              )
            ],
          ),
        ),
      );
}
