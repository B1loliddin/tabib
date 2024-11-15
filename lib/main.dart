import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabib/app.dart';
import 'package:tabib/firebase_options.dart';
import 'package:tabib/providers/current_user_provider.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
          ],
          child: Tabib(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Error: $error');
    },
  );
}
