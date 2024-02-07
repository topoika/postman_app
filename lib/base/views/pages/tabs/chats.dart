import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../data/controllers/chats.controller.dart';
import '../../../data/models/conversation.dart';
import '../../components/chats/universal.widget.dart';

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
          onTap: () => Navigator.pushNamed(context, "/MorePage"),
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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: con.getConversations(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              List<Conversation> chats = snapshot.data?.docs.map((dynamic doc) {
                    return Conversation.fromMap(doc.data());
                  }).toList() ??
                  [];

              return ListView.builder(
                itemCount: chats.length,
                shrinkWrap: true,
                reverse: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return chatTileItem(context, chat, index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
