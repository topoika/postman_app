import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/views/components/auth/universal.widgets.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/user.controller.dart';
import '../../../data/helper/constants.dart';
import '../../components/buttons.dart';
import '../../components/universal.widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC<ProfilePage> {
  late UserController con;
  _ProfilePageState() : super(UserController()) {
    con = controller as UserController;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: GestureDetector(
          onTap: () => con.openDrawer(),
          child: const Icon(
            Icons.sort,
            size: 32,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            // onTap: () => con.logOut(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset("assets/icons/edit.png", height: 14),
                  const Text(
                    " Edit",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          const SizedBox(height: 20),
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
                GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        activeUser.value.username ?? "",
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "@${activeUser.value.username!.split(" ").first}",
                        textScaleFactor: 1,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          profileItem(context, "Username", activeUser.value.username ?? ""),
          profileItem(context, "Email Address", activeUser.value.email ?? ""),
          profileItem(context, "Phone No.", activeUser.value.phone ?? ""),
          profileItem(
              context,
              "Address",
              activeUser.value.address != null
                  ? activeUser.value.address!.nameAddress
                  : ""),
          profileItem(context, "Password",
              activeUser.value.password ?? "*************"),
          buttonBlackOne("Delete Account", true, () {
            //TODO: Call the function to delete the account
          })
        ],
      ),
    );
  }
}
