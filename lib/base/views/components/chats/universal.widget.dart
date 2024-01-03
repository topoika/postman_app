import 'package:flutter/material.dart';

import '../../../data/helper/constants.dart';
import '../../../data/helper/theme.dart';
import '../../../data/models/message.dart';

Widget conversationItem(context, byMe, Message message,{index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment:
          byMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        index == 0
            ? const Center(
                child: Text(
                  'Today',
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        Container(
          width: getWidth(context, 70),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: Radius.circular(byMe ? 15 : 3),
              bottomRight: Radius.circular(byMe ? 3 : 15),
            ),
            color: byMe
                ? primaryColor.withOpacity(.6)
                : Colors.grey.withOpacity(.5),
          ),
          child: const Text(
            "Fiqrih! How are you? It's been a long time since we last met.",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment:
              byMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: byMe,
              child: const Stack(
                alignment: Alignment.centerRight,
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.blue,
                  ),
                  Positioned(
                    left: 3,
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: byMe ? 3 : 0),
            const Text(
              "12:20 PM",
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
          ],
        )
      ],
    ),
  );
}
