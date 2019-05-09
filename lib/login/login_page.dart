import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'login_view_model.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:flutter_architecture/login/input_mobile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  Providers _providers = Providers()
    ..provide(
      Provider.value(
        LoginViewModel(),
      ),
    );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    /*return ProviderNode(
      providers: _providers,
      child: _buildScaffold(),
    );*/
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      primary: false,
      backgroundColor: AppColors.login_bg,
      body: SafeArea(
        child: Container(
          color: Colors.red,
          child: _buildColumn(),
        ),
      ),
    );
  }

  Widget _buildStack() {
    var stack = Stack(
      fit: StackFit.loose,
      children: <Widget>[
        _buildLogo(),
        _buildButton(),
        _buildProtocolText(),
      ],
    );
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: stack,
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildLogo(),
        Expanded(flex: 1),
        _buildButton(),
        _buildProtocolText(),
      ],
    );
  }



  Widget _buildLogo() {
    return Center(
      child: Icon(
        Icons.camera,
        size: 50,
      ),
    );
  }

  Widget _buildButton() {

    var align = Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) {
                return InputMobilePage();
              },
            ),
          );
        },
        child: Text('手机号登录'),
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
    return Padding(padding: EdgeInsets.only(bottom: 18.0),child: align,);
  }

  Widget _buildProtocolText() {
    var text = Text("I am Jack");
    return Align(child: text,alignment: Alignment.centerRight,);
  }
}
