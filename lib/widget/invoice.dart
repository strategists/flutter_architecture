import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() {
    return _InvoiceState();
  }
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    var customPaint = CustomPaint(
      size: Size(200, 200),
      painter: _SeparatePainter(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Icon(Icons.contacts),
            ),
          ),
          Expanded(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.yellowAccent),
              child: Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
    return Container(
//      color: Colors.red,
      width: 360,
      height: 112,
      child: Card(
        child: customPaint,
      ),
    );
  }
}

class _SeparatePainter extends CustomPainter {
  final red = Color.fromRGBO(255, 0, 0, 1);
  final blue = Color.fromRGBO(0, 0, 255, 1);

  final semicircle = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    // 注意这一句
//    canvas.clipRect(rect);
//    paint.color = Colors.white;
//    canvas.drawRect(rect, paint);
    paint.color = Colors.black;
    canvas.drawCircle(Offset(0, size.height / 3), semicircle, paint);
    canvas.drawCircle(Offset(size.width, size.height / 3), semicircle, paint);
    _drawDash(canvas, size);
  }

  void _drawDash(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    var startPoint = Offset(0, size.height / 3);
    var controlPoint1 = Offset(size.width / 4, size.height / 3);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, size.height / 3);

    var path = Path();
    path.moveTo(startPoint.dx + semicircle, startPoint.dy);
//    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(endPoint.dx - semicircle, endPoint.dy);
//    canvas.drawPath(path, paint);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[5.0, 5.0]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
