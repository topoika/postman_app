import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postman_app/base/data/models/conversation.dart';

import '../models/message.dart';
import '../models/user.dart';
import 'app.controller.dart';

class ChatsController extends AppController {
  Future<Conversation> getConversation(String id) async {
    QuerySnapshot querySnapshot = await db
        .collection(chatsColl)
        .where('participants', arrayContains: activeUser.value.id)
        .get();
    try {
      if (querySnapshot.docs.isNotEmpty) {
        return Conversation.fromMap(querySnapshot.docs
            .firstWhere((doc) => doc['participants'].contains(id))
            .data() as Map<String, dynamic>);
      } else {
        return Conversation();
      }
    } catch (e) {
      log(e.toString());
      return Conversation();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream(String id) {
    return db
        .collection(chatsColl)
        .doc(id)
        .collection(messagesColl)
        .orderBy("createAt", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations() {
    return db
        .collection(chatsColl)
        .where('participants', arrayContains: activeUser.value.id)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }
  // add Message to a conversation

  void addMessage(Conversation conversation, Message message) async {
    DocumentReference docRef = await db
        .collection(chatsColl)
        .doc(conversation.id)
        .collection(messagesColl)
        .add(message.toMap())
        .then((value) async {
      await value.update({"id": value.id});
      return value;
    });
    Message message0 = await docRef
        .get()
        .then((value) => Message.fromMap(value.data() as Map<String, dynamic>));

    conversation.lastMessage = message0;
    conversation.updatedAt = DateTime.now().toString();
    conversation.unreadMessages = getUnreadMessages(conversation, message0);
    await db
        .collection(chatsColl)
        .doc(conversation.id)
        .update(conversation.toMap())
        .onError((error, stackTrace) => log(error.toString()));

    setState(() {});
  }

  // read all messages
  void updateUnreadMessage(Conversation conversation) {
    db
        .collection(chatsColl)
        .doc(conversation.id)
        .update({"unreadMessages": getUnreadMessages(conversation, Message())});
  }

  // CREATE CONVERSATION AND ADD A FIRST MESSAGE

  Future<Conversation> createConversation(User user) async {
    try {
      Conversation conversation0 = Conversation(
        participants: [activeUser.value.id!, user.id!],
        involved: [activeUser.value, user],
        package: activePackage.value,
        createAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        unreadMessages: getUnreadMessages(
            Conversation(participants: [activeUser.value.id!, user.id!]), null),
      );
      DocumentReference docRef = await db
          .collection(chatsColl)
          .add(conversation0.toMap())
          .then((value) async {
        await value.update({"id": value.id});
        return value;
      });
      DocumentSnapshot conversation = await docRef.get();
      return Conversation.fromMap(conversation.data() as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  // CREATE CONVERSATION AND ADD A FIRST MESSAGE
  Future<Conversation> addMessageToNewChat(User user, Message message) async {
    Conversation conversation = await createConversation(user);
    try {
      DocumentReference docRef = await db
          .collection(chatsColl)
          .doc(conversation.id)
          .collection(messagesColl)
          .add(message.toMap())
          .then((value) async {
        await value.update({"id": value.id});
        return value;
      });
      Message message0 = await docRef.get().then(
          (value) => Message.fromMap(value.data() as Map<String, dynamic>));

      conversation.lastMessage = message0;
      conversation.updatedAt = DateTime.now().toString();
      conversation.unreadMessages = getUnreadMessages(conversation, message0);
      await db
          .collection(chatsColl)
          .doc(conversation.id)
          .update(conversation.toMap())
          .onError((error, stackTrace) => log(error.toString()));
      return conversation;
    } catch (e) {
      log(e.toString());
    }
    return conversation;
  }

  Map<String, List<dynamic>> getUnreadMessages(
      Conversation conversation, Message? message) {
    Map<String, List<dynamic>> result = {};
    if (conversation.unreadMessages == null) {
      conversation.participants?.forEach((id) => result[id] = []);
    } else {
      String receiverId = conversation.participants!
          .firstWhere((i) => i != activeUser.value.id);
      result[receiverId] ??= conversation.unreadMessages[receiverId] ?? [];
      message!.id != null ? result[receiverId]!.add(message.id) : null;
      result[activeUser.value.id!] ??= [];
    }
    return result;
  }

  Future<User> getOtherUser(String id) async => await db
      .collection(userCol)
      .doc(id)
      .get()
      .then((value) => User.fromMap(value.data() as Map<String, dynamic>));
}
