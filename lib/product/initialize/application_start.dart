import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/product/initialize/app_cache.dart';

import 'package:news_app/product/utilities/database/firebase_options.dart';

@immutable
class ApplicationStart {
  const ApplicationStart._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.deviceInit();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    await AppCache.instance.setup();
  }
}
