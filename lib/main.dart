import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_browser/web/provider/webProvider.dart';
import 'package:web_browser/web/view/webveiwScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => WebProvider(),
    child: MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => WebViewScreen(),
      },
    ),
  ));
}
