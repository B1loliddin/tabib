import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeLocalNotifications() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> firebaseBackgroundMessagingHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    showLocalNotification(message);
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Notifications',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
  }

  void subscribeToTopic(String topic) =>
      FirebaseMessaging.instance.subscribeToTopic(topic);

  void receiveNotifications() =>
      FirebaseMessaging.onMessage.listen(showLocalNotification);
}
