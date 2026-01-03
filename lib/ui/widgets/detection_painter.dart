import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../data/models/detection_object.dart';

class DetectionPainter extends CustomPainter {
  final ui.Image image;
  final List<DetectionObject> detections;

  DetectionPainter({required this.image, required this.detections});

  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.width, size.height),
      image: image,
      fit: BoxFit.contain,
    );

    final double scaleFactor = size.width / 1000.0;

    final double activeScale = scaleFactor < 0.5 ? 0.5 : scaleFactor;

    final Color primaryColor = Colors.lightBlueAccent;

    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0 * activeScale
      ..color = primaryColor
      ..strokeCap = StrokeCap.round;

    final TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 24 * activeScale,
      fontWeight: FontWeight.w900,
      fontFamily: 'Roboto',
    );

    for (var detection in detections) {
      canvas.drawRect(detection.box, borderPaint);

      final String labelText =
          ' ${detection.label.toUpperCase()} ${(detection.confidence * 100).toInt()}% ';

      final textSpan = TextSpan(text: labelText, style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      double textX = detection.box.left;
      double textY = detection.box.top - textPainter.height - (5 * activeScale);

      if (textY < 0) {
        textY = detection.box.top + (5 * activeScale);
      }

      final Paint bgPaint = Paint()
        ..color = primaryColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(textX, textY, textPainter.width, textPainter.height),
          Radius.circular(8 * activeScale),
        ),
        bgPaint,
      );

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant DetectionPainter oldDelegate) => true;
}
