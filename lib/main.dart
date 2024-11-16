import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabib/app.dart';
import 'package:tabib/firebase_options.dart';
import 'package:tabib/providers/current_user_provider.dart';
import 'package:tabib/services/firebase_service.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final firebaseService = FirebaseService();

      /// #permission request
      firebaseService.requestPermission();

      /// #initialization
      firebaseService.initializeLocalNotifications();

      /// #showing notifications
      FirebaseMessaging.onBackgroundMessage(
        firebaseService.firebaseBackgroundMessagingHandler,
      );

      /// #subscirption to particular topic
      firebaseService.subscribeToTopic('daily-notifications');

      /// #receiving notifications
      firebaseService.receiveNotifications();

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
          ],
          child: const Tabib(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Error: $error');
    },
  );
}
