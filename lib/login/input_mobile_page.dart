import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/arch/arch.dart';
import 'package:provide/provide.dart';
import 'login_view_model.dart';
import 'package:flutter_architecture/style/style.dart';
import 'input_auth_page.dart';

class InputMobilePage extends PageProviderNode {
  final LoginViewModel _loginViewModel = LoginViewModel();

  InputMobilePage() {
    providers.provide(Provider<LoginViewModel>.value(_loginViewModel));
  }

  @override
  Widget buildPage(BuildContext context) {
    return InputMobileContent(_loginViewModel);
  }
}

class InputMobileContent extends StatefulWidget {
  LoginViewModel model;

  InputMobileContent(this.model);

  @override
  _InputMobilePageState createState() {
    return _InputMobilePageState();
  }
}

class _InputMobilePageState extends State<InputMobileContent> {
  TextEditingController _textEditingController;

  bool _errorState = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();
  }

  void checkMobile(String mobile) {
    bool ok = mobileOk(mobile);
    setState(() {
      _errorState = !ok;
    });
    //cache mobile
    if (ok) {}
  }

  bool mobileOk(String mobile) {
    RegExp exp =
        RegExp(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$');
//    RegExp exp = RegExp(
//        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        child: _buildColumn(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkMobile(_textEditingController.text);
          if (!_errorState) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return InputAuthPage(
                    mobile: _textEditingController.text,
                  );
                },
              ),
            );
          }
        },
        child: Icon(Icons.chevron_right),
      ),
    );
  }

  Column _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleText(),
        _buildTipText(context),
        _buildInput(context),
      ],
    );
  }

  Widget _buildTitleText() {
    var text = Text(
      "请您输入手机号",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontStyle: FontStyle.normal,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: text,
    );
  }

  Widget _buildTipText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48),
      child: Text(
        _errorState ? "手机号格式错误" : "手机号",
        style: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: _errorState ? AppColors.input_error : AppColors.input_def,
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      maxLength: 11,
      maxLines: 1,
      controller: _textEditingController,
      onTap: () {},
      onChanged: (string) {
        print("onChanged $string");
        if (string.length == 11) {
          checkMobile(string);
        }
      },
      /* onEditingComplete: () {
        print('onEditingComplete');
      },*/
      onSubmitted: (string) {
        print("onSubmitted $string");
        checkMobile(string);
      },
    );
  }
}
