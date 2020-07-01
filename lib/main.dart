import 'package:flutter/material.dart';
import 'package:webview_flutter_app/contactUs/email.dart';
import 'package:webview_flutter_app/splashScreen/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(),
        '/email': (context) => EmailUs(),
      },
      // home: SplashScreen(),
    );
  }
}
