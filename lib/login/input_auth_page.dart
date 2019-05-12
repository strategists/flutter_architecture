import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:flutter_architecture/widget/button.dart';
import 'package:flutter_architecture/widget/timer_text.dart';
import 'package:flutter_architecture/shelf.dart';
import 'package:rxdart/rxdart.dart';

class InputAuthPage extends StatefulWidget {
  final String mobile;

  const InputAuthPage({Key key, @required this.mobile})
      : assert(mobile != null),
        super(key: key);

  @override
  _InputAuthPageState createState() {
    return _InputAuthPageState();
  }
}

class _InputAuthPageState extends State<InputAuthPage> {
  /// Default max pin length.
  static final int _pinLength = 4;

  String _mobile;

  /// Control the input text field.
  PinEditingController _pinEditingController =
      PinEditingController(pinLength: _pinLength, autoDispose: false);

  /// Control whether show the obscureCode.
  bool _obscureEnable = false;

  PinEntryType _pinEntryType = PinEntryType.underline;
  Color _solidColor = Colors.purpleAccent;
  bool _solidEnable = false;

  var _errorState = false;
  var _clickable = true;
  TimerValueNotifier notifier = TimerValueNotifier(false);

  /// Set a random pin to the textField.
  void _setPinValue() {
    _pinEditingController.text = _generateRandomPin();
  }

  String _generateRandomPin() {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < _pinLength; i++) {
      sb.write("$i");
    }
    return sb.toString();
  }

  @override
  void initState() {
    _pinEditingController.addListener(() {
      debugPrint('changed pin:${_pinEditingController.text}');
      if (checkCode(_pinEditingController.text)) {
        Future.delayed(const Duration(seconds: 1), gotoShelfPage);
      }
    });
    _mobile = widget.mobile;
    super.initState();
  }

   @override
  void reassemble() {
    super.reassemble();
    _clickable = true;
  }

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  bool checkCode(String code) {
    ///todo remote check
    if (code.length == 4) {
      return true;
    } else {
      return false;
    }
  }

  void gotoShelfPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Shelf()),
    );
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
        child: _buildColumn(context),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleText(),
        _buildSubText(),
        _buildTipText(),
        _buildPinInput(),
        _buildFetchCodeContainer(),
      ],
    );
  }

  Widget _buildTitleText() {
    var text = Text(
      "请您输入验证码",
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

  Widget _buildSubText() {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text("验证码已经发送到：$_mobile"),
    );
  }

  Widget _buildTipText() {
    return Padding(
      padding: EdgeInsets.only(top: 38),
      child: Text(
        _errorState ? "验证码错误或已过期" : "4位数字验证码",
        style: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: _errorState ? AppColors.input_error : AppColors.input_def,
        ),
      ),
    );
  }

  Widget _buildPinInput() {
    return Container(
      width: 150,
      child: PinInputTextField(
        pinLength: _pinLength,
        decoration: UnderlineDecoration(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          enteredColor: AppColors.input_def,
          color: AppColors.input_def,
          lineHeight: 1.0,
        ),
        pinEditingController: _pinEditingController,
        autoFocus: true,
        textInputAction: TextInputAction.done,
        onSubmit: (pin) {
          debugPrint('submit pin:$pin');
        },
      ),
    );
  }

  Widget _buildFetchCodeContainer() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_buildTimerText(), _buildTextButton()],
      ),
    );
  }

  Widget _buildTimerText() {
    return TimerText(
      countdown: 5,
      data: notifier,
      onFinish: () {
        setState(() => _clickable = !_clickable);
      },
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      available: _clickable,
      onTap: () {
        setState(() {
          _clickable = !_clickable;
          notifier.value = true;
        });
      },
      text: "语音获取",
      textColor: AppColors.fetch_code_text,
    );
  }
}
