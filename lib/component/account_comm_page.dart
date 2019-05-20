import 'package:flutter/material.dart';
import 'specific_app_bar.dart';

class AccountCommPage extends StatelessWidget {
  final String title;
  final Widget body;

  const AccountCommPage({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecificAppBar(title),
      body: body,
    );
  }
}
