import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';
import '../../views/components/home/universal.widget.dart';
import 'app.controller.dart';

class NotificationController extends AppController {
  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await requestPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (NotificationResponse load) async {
      try {
        if (load.payload!.isNotEmpty) {
          var payload = jsonDecode(load.payload!);

          if (payload['type'] == 'request') {
            final request = await getOneRequest(payload['requestId']);
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 2);
            Navigator.pushNamed(Get.context!, "/NewOrderPage",
                arguments: request);
          } else if (payload['type'] == '"request-accept"') {
            final request = await getOneRequest(payload['requestId']);
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 2);
            Navigator.pushNamed(Get.context!, "/RequestDetails",
                arguments: request);
          } else {
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 3);
          }
        }
      } catch (_) {}
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print(
            "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("onMessage type: ${message.data['type']}/${message.data['id']}");
      }
      if (FirebaseAuth.instance.currentUser != null) {
        final request = await getOneRequest(message.data['requestId']);
        if (!kIsWeb && message.data['type'] == "request") {
          showDialog(
            context: Get.context!,
            barrierColor: Colors.black26,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                child: NewOrderDialog(request: request),
              );
            },
          );
        } else if (!kIsWeb && message.data['type'] == "request-accept") {
          showDialog(
            context: Get.context!,
            barrierColor: Colors.black26,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  insetPadding: EdgeInsets.zero,
                  child: RequestAcceptDialog(request: request));
            },
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        log("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.data.toString()}");
      }
      if (FirebaseAuth.instance.currentUser != null) {
        try {
          final request = await getOneRequest(message.data['requestId']);

          if (message.data['type'] == "request") {
            Navigator.pushNamed(Get.context!, "/NewOrderPage",
                arguments: message.data['id']);
          } else if (message.data['type'] == "request-accept") {
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 2);
            Navigator.pushNamed(Get.context!, "/RequestDetails",
                arguments: request);
          }
        } catch (_) {}
      }
    });
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(
        "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
  if (FirebaseAuth.instance.currentUser != null) {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    // NotificationController.showNotification(
    //     message, flutterLocalNotificationsPlugin, true);
  }
}

// class NotificationBody {
//   String? id;
//   String? type;

//   NotificationBody({
//     this.id,
//     this.type,
//   });

//   NotificationBody.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     return data;
//   }
// }
