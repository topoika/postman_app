import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'base/data/helper/route_generator.dart';
import 'base/data/helper/theme.dart';
import 'base/views/pages/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInnit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postman',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const SplashScreen(),
    );
  }
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
    showBadge: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('///////////////////////////////////////');
  print('A bg message just showed up :  ${message.messageId} ${message.data} ');
  print('///////////////////////////////////////');
}

Future firebaseInnit() async {
  await Firebase.initializeApp(
    name: 'new-postman',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
