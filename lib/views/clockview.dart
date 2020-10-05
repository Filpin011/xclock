import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var datetime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillbrush = Paint()..color = Color(0xFF444974);
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    var outlinebrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;
    var centerbrush = Paint()..color = Color(0xFFEAECFF);
    var seclinebrush = Paint()
      ..color = Colors.orange[300]
      ..strokeWidth = size.width / 60
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    var minlinebrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = size.width / 30
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    var hourlinebrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = size.width / 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius * 0.75, fillbrush);
    canvas.drawCircle(center, radius * 0.75, outlinebrush);

    var minlineX = centerX + radius * 0.6 * cos(datetime.minute * 6 * pi / 180);
    var minlineY = centerY + radius * 0.6 * sin(datetime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minlineX, minlineY), minlinebrush);
    var hourlineX = centerX +
        radius *
            0.4 *
            cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hourlineY = centerY +
        radius *
            0.4 *
            sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourlineX, hourlineY), hourlinebrush);
    var seclineX = centerX + radius * 0.6 * cos(datetime.second * 6 * pi / 180);
    var seclineY = centerY + radius * 0.6 * sin(datetime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(seclineX, seclineY), seclinebrush);

    canvas.drawCircle(center, radius * 0.16, centerbrush);
    var outcircles = radius;
    var innercircles = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outcircles * cos(i * pi / 180);
      var y1 = centerY + outcircles * sin(i * pi / 180);

      var x2 = centerX + innercircles * cos(i * pi / 180);
      var y2 = centerY + innercircles * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
