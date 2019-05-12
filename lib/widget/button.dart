import 'package:flutter/material.dart';

class CompositeButton extends StatefulWidget {
  @override
  _CompositeButtonState createState() {
    return _CompositeButtonState();
  }
}

class _CompositeButtonState extends State<CompositeButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton();
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
