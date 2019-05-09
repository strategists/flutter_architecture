import 'package:flutter/material.dart';

class InputMobilePage extends StatefulWidget {
  @override
  _InputMobilePageState createState() {
    return _InputMobilePageState();
  }
}

class _InputMobilePageState extends State<InputMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        child: _buildColumn(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chevron_right),
      ),
    );
  }

  Column _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[Text("手机号登录"), TextField()],
    );
  }
}
