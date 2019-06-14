import 'package:flutter/material.dart';



class SolidButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final double round;
  final double width;
  final double height;

  const SolidButton({
    Key key,
    this.text,
    this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.round = 18,
    this.width,
    this.height = 36,
  })  : assert(onPressed != null),
        super(key: key);

  @override
  _SolidButtonState createState() {
    return _SolidButtonState();
  }
}

class _SolidButtonState extends State<SolidButton> {
  @override
  Widget build(BuildContext context) {
    return widget.width != null && widget.height != null
        ? SizedBox(
            width: widget.width,
            height: widget.height,
            child: _buildRaisedButton(),
          )
        : _buildRaisedButton();
  }

  RaisedButton _buildRaisedButton() {
    return RaisedButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: TextStyle(color: widget.textColor),
      ),
      textColor: widget.textColor,
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.round),
        ),
      ),
    );
  }
}

class TextButton extends StatefulWidget {
  final bool available;
  final String text;
  final Color textColor;
  final Color disableTextColor;
  final VoidCallback onTap;

  const TextButton({
    Key key,
    this.available = true,
    @required this.text,
    this.textColor = Colors.blueAccent,
    this.disableTextColor = Colors.grey,
    this.onTap,
  })  : assert(text != null),
        super(key: key);

  @override
  _TextButtonState createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  @override
  Widget build(BuildContext context) {
    var text = Text(
      widget.text,
      style: TextStyle(
        color: widget.available ? widget.textColor : widget.disableTextColor,
      ),
    );
    return InkWell(
      onTap: widget.available ? widget.onTap : null,
      child: SizedBox(
        width: 68,
        height: 28,
        child: Center(
          child: text,
        ),
      ),
    );
  }
}

class SpecificButton extends RaisedButton {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final double radius;

  SpecificButton(
    this.text, {
    this.textColor = Colors.white,
    this.radius = 18,
    this.onPressed,
    this.backgroundColor = Colors.blue,
  }) : super(
          onPressed: onPressed,
//          textTheme: ButtonTextTheme.primary,
          textColor: textColor,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        );
}
