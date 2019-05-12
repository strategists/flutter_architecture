import 'dart:async';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  final TimerValueNotifier data;
  final VoidCallback onFinish;

  TimerText({
    this.countdown: 60,
    this.data,
    this.onFinish,
  });

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  bool _running = false;

  @override
  void initState() {
    super.initState();
    widget.data.addListener(_startTimer);
    _seconds = widget.countdown;
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _running = widget.data.value;
    print(_running);
    if (!widget.data.value) {
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _running = false;
        widget.data.value = false;
        _seconds = widget.countdown;
        widget.onFinish();
        setState(() {});
        return;
      }
      _seconds--;
      setState(() {});
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 墨水瓶（`InkWell`）组件，响应触摸的矩形区域。
    return _running
        ? Text(
            "$_seconds s后重新获取",
            style: TextStyle(color: Colors.grey),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }
}

class TimerValueNotifier extends ValueNotifier<bool> {
  TimerValueNotifier(bool value) : super(value);
}
