import 'package:flutter/material.dart';

class SpecificAppBar extends AppBar {
  final String text;
  final Color backgroundColor;
  final bool light;

  SpecificAppBar(this.text,
      {this.light = true, this.backgroundColor = Colors.white})
      : super(
          title: Text(text),
          centerTitle: true,
          backgroundColor: backgroundColor,
          brightness: light ? Brightness.light : Brightness.dark,
          iconTheme: IconThemeData(color: light ? Colors.black : Colors.white),
          textTheme: TextTheme(
            title: TextStyle(color: light ? Colors.black : Colors.white),
          ),
        );
}
