import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DashSemicircle extends StatelessWidget {
  ///圆弧半径
  final double radius;
  final double width;

  /// 虚线颜色
  final Color dashColor;

  ///圆弧颜色
  final Color semicircleColor;

  const DashSemicircle(
      {Key key,
      this.radius = 8.0,
      this.width = double.infinity,
      this.dashColor = Colors.grey,
      this.semicircleColor = const Color(0xFFF8F9FE)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 2 * radius,
      child: CustomPaint(
        size: Size(width, 2 * radius),
        painter: _DashPainter(dashColor, semicircleColor),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color dashColor;
  final Color semicircleColor;

  _DashPainter(this.dashColor, this.semicircleColor);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;
    final circlePaint = Paint();
//    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    // 注意这一句
//    canvas.clipRect(rect);
//    paint.color = Colors.white;
//    canvas.drawRect(rect, paint);
    circlePaint.color = semicircleColor;
    canvas.drawCircle(Offset(0, size.height / 2), radius, circlePaint);
    canvas.drawCircle(Offset(size.width, size.height / 2), radius, circlePaint);
    _drawDash(canvas, size);
  }

  void _drawDash(Canvas canvas, Size size) {
    final radius = size.height / 2;
    var dashPaint = Paint();
    dashPaint.color = dashColor;
    dashPaint.style = PaintingStyle.stroke;
    dashPaint.strokeWidth = 1;

    var startPoint = Offset(0, size.height / 2);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx + radius, startPoint.dy);
    path.lineTo(endPoint.dx - radius, endPoint.dy);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[5.0, 5.0]),
      ),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
