import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

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

  /// Default Text style.
  static final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
  );

  /// Control the input text field.
  PinEditingController _pinEditingController =
      PinEditingController(pinLength: _pinLength, autoDispose: false);

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration = UnderlineDecoration(
    textStyle: _textStyle,
    enteredColor: Colors.deepOrange,
  );

  /// Control whether show the obscureCode.
  bool _obscureEnable = false;

  PinEntryType _pinEntryType = PinEntryType.underline;
  Color _solidColor = Colors.purpleAccent;
  bool _solidEnable = false;

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
    });
    super.initState();
  }

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
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
        _buildPinInput(),
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

  Widget _buildPinInput() {
    return Container(
      child: PinInputTextField(
        pinLength: _pinLength,
        decoration: _pinDecoration,
        pinEditingController: _pinEditingController,
        autoFocus: true,
        textInputAction: TextInputAction.go,
        onSubmit: (pin) {
          debugPrint('submit pin:$pin');
        },
      ),
    );
  }
}
