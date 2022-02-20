import 'dart:io';

import 'package:dynamic_links_flutter/src/home_screen/home_screen_view.dart';
import 'package:dynamic_links_flutter/src/services/dynamic_links_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.initLink}) : super(key: key);
  final PendingDynamicLinkData? initLink;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks _firebaseDynamicLinks = FirebaseDynamicLinks.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreenHandler(
        initLink: widget.initLink,
      ),
    );
  }
}

class MainScreenHandler extends StatefulWidget {
  const MainScreenHandler({Key? key, this.initLink}) : super(key: key);
  final PendingDynamicLinkData? initLink;

  @override
  _MainScreenHandlerState createState() => _MainScreenHandlerState();
}

class _MainScreenHandlerState extends State<MainScreenHandler> {
  DynamicLinksService _dynamicLinksService = DynamicLinksService();

  @override
  void initState() {
    if (Platform.isIOS || Platform.isAndroid) {
      widget.initLink != null
          ? whichDynamicLink(dynamicLink: widget.initLink!.link.toString())
          : null;

      listenForDynamicLinks();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text('create a dynamic link'),
        onPressed: () async => await _dynamicLinksService.buildDynamicLinks(
            postAuthor: "postAuthor",
            postCategory: "postCategory",
            postDescription: "postDescription",
            postID: "postID",
            postTitle: "postTitle"),
      ),
    );
  }

  whichDynamicLink({String? dynamicLink}) async {
    if (dynamicLink != null) {
      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
          .instance
          .getDynamicLink(Uri.parse(dynamicLink));
      debugPrint(initialLink!.link.toString());
      return initialLink;
    }
  }

  listenForDynamicLinks() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      //  Navigator.pushNamed(context, dynamicLinkData.link.path);
      debugPrint(dynamicLinkData.link.toString() + " Received ");
    }).onError((error) {
      // Handle errors
      debugPrint('handle error');
    });
  }
}
