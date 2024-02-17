import 'package:flutter/material.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/helper.dart';
import '../../components/universal.widgets.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackAppBar(
        title: const Text(
          "News Feed",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          activeUser.value.image != null
                              ? showLargeImage(
                                  context, activeUser.value.image, null)
                              : toastShow(context, "No profile picture", "nor");
                        },
                        child: Container(
                          height: getWidth(context, 10),
                          width: getWidth(context, 10),
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
                            border: Border.all(
                                width: 2, color: greenColor.withOpacity(.5)),
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
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "New Postman",
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "10 min ago",
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Run route recommendations in London",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Does anyone have any long run route recommendations in or around London? Preferably with minimal crossing of roads, i’m getting a bit bored of the Thames path and Richmond Park!",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
