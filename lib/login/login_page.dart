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
    return ProviderNode(
      providers: _providers,
      child: _buildScaffold(),
    );
//    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      primary: false,
      backgroundColor: AppColors.login_bg,
      body: SafeArea(
        child: Container(
          child: _buildStack(),
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

  Widget _buildLogo() {
    var icon = Icon(
      Icons.camera,
      size: 198.0,
    );
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 150.0),
        child: icon,
      ),
    );
  }

  Widget _buildButton() {
    var raisedButton = RaisedButton(
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Text('手机号登录'),
      color: Colors.blue,
      textColor: Colors.white,
    );
    var align = Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 164,
        height: 38,
        child: raisedButton,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 68.0 + 30.0),
      child: align,
    );
  }

  Widget _buildProtocolText() {
    var text = Text("I am Jack");
    var align = Align(
      child: text,
      alignment: Alignment.bottomCenter,
    );
    return Padding(
      padding: EdgeInsets.only(
        bottom: 68,
      ),
      child: align,
    );
  }
}
