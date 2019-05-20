import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:flutter_architecture/style/style.dart';

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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: _buildHeadTitle(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: _buildBottom(),
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

  Widget _buildHeadTitle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "应收编号：20171005HX104",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          ".待审批",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.invoice_state_text,
          ),
        )
      ],
    );
  }

  Widget _buildBottom() {
    var textStyle = TextStyle(color: Colors.black, fontSize: 14);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "申请日：",
                    style: textStyle,
                  ),
                  Text(
                    "2019-08-08",
                    style: textStyle,
                  ),
                ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "融资金额：",
                    style: textStyle,
                  ),
                  Text(
                    "￥85,800.00",
                    style: textStyle,
                  )
                ]),
          ],
        ),
        Positioned(
          right: 14,
          bottom: 6,
          child: Icon(Icons.chevron_right, color: Colors.grey),
        ),
      ],
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
    paint.color = Colors.grey;
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
