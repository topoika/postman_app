import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/helper.dart';
import 'package:postman_app/base/data/models/conversation.dart';

import '../../../data/controllers/app.controller.dart';
import '../../../data/helper/constants.dart';
import '../../../data/helper/theme.dart';
import '../../../data/models/message.dart';
import '../../../data/models/user.dart';
import '../universal.widgets.dart';

Widget conversationItem(context, byMe, Message message, {index}) {
  bool read = message.readBy!.isEmpty;
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
          constraints: BoxConstraints(
            maxWidth: getWidth(context, 70),
            minWidth: getWidth(context, 5),
          ),
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
          child: Text(
            message.text ?? "",
            textScaleFactor: 1,
            style: const TextStyle(
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
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: read ? Colors.blue : Colors.grey,
                  ),
                  Positioned(
                    left: 3,
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: read ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: byMe ? 3 : 0),
            Text(
              timeOnly(message.createAt),
              textScaleFactor: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
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

Widget chatTileItem(context, Conversation conversation, index) {
  User reciever =
      conversation.involved!.firstWhere((i) => i.id != activeUser.value.id);
  return InkWell(
    splashColor: primaryColor.withOpacity(.4),
    onTap: () => Navigator.pushNamed(context, "/ConversationPage",
        arguments: activeUser.value),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5).copyWith(top: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  activeUser.value.image != null
                      ? showLargeImage(context, activeUser.value.image, null)
                      : toastShow(context, "No profile picture", "nor");
                },
                child: Container(
                  height: getWidth(context, 12),
                  width: getWidth(context, 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    image: reciever.image != null
                        ? DecorationImage(
                            image: cachedImage(reciever.image ?? noUserImage),
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
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      reciever.username ?? "",
                      textScaleFactor: 1,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    Visibility(
                      visible: conversation.lastMessage != null,
                      child: Text(conversation.lastMessage!.text ?? "",
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: [0, 1, 2].contains(index)
                                  ? Colors.black
                                  : Colors.grey)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    timeOnly(conversation.updatedAt!),
                    textScaleFactor: 1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  conversation.unreadMessages[activeUser.value.id].isNotEmpty
                      ? Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            conversation
                                .unreadMessages[activeUser.value.id].length
                                .toString(),
                            textScaleFactor: 1,
                            style: const TextStyle(
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
}
