import 'package:flutter/material.dart';
import 'package:flutter_architecture/widget/invoice.dart';
import 'package:flutter_architecture/widget/dash_semicircle.dart';
import 'package:flutter_architecture/component/specific_app_bar.dart';

class ReceivableLaunchPage extends StatefulWidget {
  @override
  _ReceivableLaunchPageState createState() {
    return _ReceivableLaunchPageState();
  }
}

class _ReceivableLaunchPageState extends State<ReceivableLaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecificAppBar("收款记录"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Invoice(),
        ],
      ),
    );
  }
}
