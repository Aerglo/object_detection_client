import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/detection_object.dart';

final detectionRepositoryProvider = Provider((ref) => DetectionRepository());

class DetectionRepository {
  final String _baseUrl =
      "https://imaergloooo-object-detection-api.hf.space//api/detect/";

  Future<List<DetectionObject>> uploadImage(File image) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);

        List<dynamic> list = jsonResponse['detections'];
        return list.map((e) => DetectionObject.fromJson(e)).toList();
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection Failed: $e');
    }
  }
}
