import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:postman_app/base/data/controllers/app.controller.dart';

import '../../data/controllers/chats.controller.dart';
import '../../data/helper/constants.dart';
import '../../data/models/conversation.dart';
import '../../data/models/message.dart';
import '../../data/models/user.dart';
import '../components/chats/universal.widget.dart';
import '../components/universal.widgets.dart';

// ignore: must_be_immutable
class ConversationPage extends StatefulWidget {
  User user;
  ConversationPage({super.key, required this.user});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends StateMVC<ConversationPage> {
  late ChatsController con;
  _ConversationPageState() : super(ChatsController()) {
    con = controller as ChatsController;
  }
  TextEditingController message = TextEditingController();
  int text = 0;

  Conversation conversation = Conversation();

  @override
  void initState() {
    super.initState();
    setUser();
  }

  Future<void> setUser() async {
    await con
        .getConversation(widget.user.id!)
        .then((value) => setState(() => conversation = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      appBar: BlackAppBar(
        title: Column(
          children: [
            Text(
              widget.user.username ?? "",
              textScaleFactor: 1,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Online",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 13, color: greenColor),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset("assets/icons/phone.png",
                  height: 18, color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: scafoldBlack,
      body: Column(
        children: [
          Expanded(
            child: conversation.id == null
                ? const SizedBox()
                : Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: con.getMessageStream(conversation.id!),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        List<Message> messages = snapshot.data?.docs.map(
                                (QueryDocumentSnapshot<Map<String, dynamic>>
                                    doc) {
                              return Message.fromMap(doc.data());
                            }).toList() ??
                            [];

                        return ListView.builder(
                          itemCount: messages.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shrinkWrap: true,
                          reverse: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            bool byMe = message.sendBy == activeUser.value.id!;
                            return conversationItem(context, byMe, message,
                                index: index);
                          },
                        );
                      },
                    ),
                  ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Form(
                            child: TextFormField(
                              controller: message,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 18,
                              ),
                              onChanged: (val) {
                                setState(() => text = val.length);
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 4, left: 20),
                                hintText: "Type a Message...",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                errorStyle: TextStyle(fontSize: 0),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (conversation.id != null) {
                      con.addMessage(
                          conversation,
                          Message(
                              text: message.text,
                              createAt: DateTime.now().toString(),
                              sendBy: activeUser.value.id,
                              readBy: [activeUser.value.id!]));
                    } else {
                      con
                          .addMessageToNewChat(
                              widget.user,
                              Message(
                                  text: message.text,
                                  createAt: DateTime.now().toString(),
                                  sendBy: activeUser.value.id,
                                  readBy: [activeUser.value.id!]))
                          .then(
                              (value) => setState(() => conversation = value));
                    }
                    message.clear();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                      color: greenColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      text > 0 ? Icons.send : Icons.mic_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
