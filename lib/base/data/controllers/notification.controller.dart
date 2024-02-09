import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';
import '../../views/components/home/universal.widget.dart';
import '../models/request.dart';

class NotificationController {
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

  static Future<void> initialize(
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
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 2);
            Navigator.pushNamed(Get.context!, "/NewOrderPage",
                arguments:
                    Request(id: payload['id'], packageId: payload['id']));
          } else {
            Navigator.of(Get.context!)
                .pushReplacementNamed("/Pages", arguments: 3);
          }
        }
      } catch (_) {}
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
            "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("onMessage type: ${message.data['type']}/${message.data['id']}");
      }
      if (FirebaseAuth.instance.currentUser != null) {
        if (!kIsWeb && message.data['type'] == "request") {
          // Only show the dialog if not running on the web and the message type is "request"
          showDialog(
            context: Get.context!,
            barrierColor: Colors.black26,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                child: NewOrderDialog(
                    request: Request(
                        id: message.data['id'], packageId: message.data['id'])),
              );
            },
          );
        } else {
          // showNotification(message, flutterLocalNotificationsPlugin, false);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        log("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.data.toString()}");
      }
      if (FirebaseAuth.instance.currentUser != null) {
        try {
          if (message.data['type'] == "request") {
            Navigator.pushNamed(Get.context!, "/NewOrderPage",
                arguments: message.data['id']);
          } else {
            // log("It is a chat")
            // TODO: get the user and navigate to the conversation page to chat
          }
        } catch (_) {}
      }
    });
  }

  //

//   static Future<void> showNotification(RemoteMessage message,
//       FlutterLocalNotificationsPlugin fln, bool data) async {
//     if (!Platform.isIOS) {
//       String? title;
//       String? body;
//       String? requestId;
//       NotificationBody notificationBody = convertNotification(message.data);
//       if (data) {
//         title = message.data['title'];
//         body = message.data['body'];
//         requestId = message.data['id'];
//       }
//       await showBigTextNotification(
//           title, body ?? "", requestId, notificationBody, fln);
//     }
//   }

//   static Future<void> showBigTextNotification(
//       String? title,
//       String body,
//       String? requestId,
//       NotificationBody? notificationBody,
//       FlutterLocalNotificationsPlugin fln) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       body,
//       htmlFormatBigText: true,
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'postman',
//       'postman',
//       importance: Importance.max,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.max,
//       playSound: true,
//       sound: const RawResourceAndroidNotificationSound('notification'),
//     );
//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload: notificationBody != null
//             ? jsonEncode(notificationBody.toJson())
//             : null);
//   }

//   static NotificationBody convertNotification(Map<String, dynamic> data) {
//     if (data['type'] == 'request') {
//       return NotificationBody(type: 'notification', id: data['id']);
//     } else {
//       return NotificationBody(type: 'chats');
//     }
//   }
// }
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
