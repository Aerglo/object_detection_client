import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/detection_provider.dart';
import 'widgets/detection_painter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detectionState = ref.watch(detectionProvider);

    Future<void> pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        ref
            .read(detectionProvider.notifier)
            .processImage(File(pickedFile.path));
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            ),
          ),
        ),
        title: const Text(
          "AI Object Detector",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (detectionState.uiImage != null)
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              onPressed: () => ref.read(detectionProvider.notifier).clear(),
            ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: _buildImageArea(context, detectionState)),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildControlBar(
              context,
              pickImage,
              detectionState.isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageArea(BuildContext context, DetectionState state) {
    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    if (state.uiImage == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.center_focus_weak_rounded,
              size: 120,
              color: Colors.white.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            Text(
              "No Image Selected",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 5.0,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: state.uiImage!.width.toDouble(),
                height: state.uiImage!.height.toDouble(),
                child: CustomPaint(
                  painter: DetectionPainter(
                    image: state.uiImage!,
                    detections: state.isLoading ? [] : state.detections,
                  ),

                  child: state.isLoading
                      ? Container(
                          color: Colors.black45,
                          child: const Center(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                strokeWidth: 8,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControlBar(
    BuildContext context,
    Function(ImageSource) onPick,
    bool isLoading,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E).withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.camera_alt_rounded,
            label: "Camera",
            onTap: isLoading ? null : () => onPick(ImageSource.camera),
            isPrimary: true,
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          _buildActionButton(
            icon: Icons.photo_library_rounded,
            label: "Gallery",
            onTap: isLoading ? null : () => onPick(ImageSource.gallery),
            isPrimary: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool isPrimary,
  }) {
    final color = onTap == null
        ? Colors.grey
        : (isPrimary ? Colors.lightBlueAccent : Colors.white);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
