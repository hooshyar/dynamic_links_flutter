import 'dart:io';

import 'package:dynamic_links_flutter/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);

  if (Platform.isIOS || Platform.isAndroid) {
    // Get any initial links
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    runApp(MyApp(
      initLink: initialLink,
    ));
  }
  runApp(const MyApp());
}
