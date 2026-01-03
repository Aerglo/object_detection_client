import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/models/detection_object.dart';
import '../data/repositories/detection_repository.dart';

class DetectionState {
  final File? imageFile;
  final ui.Image? uiImage;
  final List<DetectionObject> detections;
  final bool isLoading;
  final String? errorMessage;

  DetectionState({
    this.imageFile,
    this.uiImage,
    this.detections = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  DetectionState copyWith({
    File? imageFile,
    ui.Image? uiImage,
    List<DetectionObject>? detections,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DetectionState(
      imageFile: imageFile ?? this.imageFile,
      uiImage: uiImage ?? this.uiImage,
      detections: detections ?? this.detections,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class DetectionNotifier extends StateNotifier<DetectionState> {
  final DetectionRepository _repository;

  DetectionNotifier(this._repository) : super(DetectionState());

  Future<void> processImage(File file) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final data = await file.readAsBytes();
      final uiImage = await decodeImageFromList(data);

      state = state.copyWith(imageFile: file, uiImage: uiImage, detections: []);

      final results = await _repository.uploadImage(file);

      state = state.copyWith(detections: results, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void clear() {
    state = DetectionState();
  }
}

final detectionProvider =
    StateNotifierProvider<DetectionNotifier, DetectionState>((ref) {
      final repository = ref.watch(detectionRepositoryProvider);
      return DetectionNotifier(repository);
    });
