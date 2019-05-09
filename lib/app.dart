import 'package:flutter/material.dart';
import 'page/page.dart';
import 'package:flutter_architecture/style/style.dart';
import 'shelf.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_title,
      color: Colors.red,

      theme: ThemeData(
        brightness: Brightness.light
//        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
