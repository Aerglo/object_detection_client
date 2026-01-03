import 'dart:ui';

class DetectionObject {
  final String label;
  final double confidence;
  final Rect box;

  DetectionObject({
    required this.label,
    required this.confidence,
    required this.box,
  });

  factory DetectionObject.fromJson(Map<String, dynamic> json) {
    final boxJson = json['box'];
    return DetectionObject(
      label: json['label'],
      confidence: (json['confidence'] as num).toDouble(),
      box: Rect.fromLTRB(
        (boxJson['x1'] as num).toDouble(),
        (boxJson['y1'] as num).toDouble(),
        (boxJson['x2'] as num).toDouble(),
        (boxJson['y2'] as num).toDouble(),
      ),
    );
  }
}
