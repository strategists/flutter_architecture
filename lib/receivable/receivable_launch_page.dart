import 'package:flutter/material.dart';
import 'package:flutter_architecture/widget/invoice.dart';
import 'package:flutter_architecture/widget/dash_semicircle.dart';
import 'package:flutter_architecture/component/specific_app_bar.dart';
import 'package:flutter_architecture/style/style.dart';

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
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: <Widget>[
          Invoice(),
          Invoice(),
          Invoice(),
        ],
      ),
    );
  }
}
