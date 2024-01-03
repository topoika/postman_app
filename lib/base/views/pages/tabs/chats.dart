import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/helper/theme.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/controllers/chats.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../components/universal.widgets.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends StateMVC<ChatsPage> {
  late ChatsController con;
  _ChatsPageState() : super(ChatsController()) {
    con = controller as ChatsController;
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
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Messages",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            // onTap: () => con.logOut(),
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          const Text(
            'All Messages',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: primaryColor.withOpacity(.4),
                onTap: () => Navigator.pushNamed(context, "/ConversationPage",
                    arguments: activeUser.value),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5).copyWith(top: 5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              activeUser.value.image != null
                                  ? showLargeImage(
                                      context, activeUser.value.image, null)
                                  : toastShow(
                                      context, "No profile picture", "nor");
                            },
                            child: Container(
                              height: getWidth(context, 12),
                              width: getWidth(context, 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                image: activeUser.value.image != null
                                    ? DecorationImage(
                                        image: cachedImage(
                                            activeUser.value.image ??
                                                noUserImage),
                                        fit: BoxFit.fill,
                                      )
                                    : null,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: .7, color: Colors.grey),
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  activeUser.value.username ?? "",
                                  textScaleFactor: 1,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // const SizedBox(height: 5),
                                Text(
                                  "Why did you do that?",
                                  textScaleFactor: 1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: [0, 1, 2].contains(index)
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const Text(
                                "12:20 PM",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              index.isEven
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Text(
                                        "9",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                    )
                                  : const Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        Positioned(
                                          left: 3,
                                          child: Icon(
                                            Icons.check,
                                            size: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      index != 19
                          ? Divider(
                              thickness: .7,
                              color: Colors.grey.withOpacity(.4),
                              height: 1.4)
                          : const SizedBox()
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
