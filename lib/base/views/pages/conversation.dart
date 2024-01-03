import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../data/controllers/chats.controller.dart';
import '../../data/helper/constants.dart';
import '../../data/models/message.dart';
import '../../data/models/user.dart';
import '../components/chats/universal.widget.dart';

class ConversationPage extends StatefulWidget {
  final User user;
  const ConversationPage({super.key, required this.user});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.formKey,
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
        title: Column(
          children: [
            Text(
              widget.user.username ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Text(
              "Online",
              style: TextStyle(fontSize: 13, color: greenColor),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            // onTap: () => con.logOut(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset("assets/icons/phone.png", height: 18),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shrinkWrap: true,
              reverse: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                bool byMe = index.isOdd;
                return conversationItem(context, byMe, Message(), index: index);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                              autovalidateMode: AutovalidateMode.always,
                              autocorrect: false,
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
                Container(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
