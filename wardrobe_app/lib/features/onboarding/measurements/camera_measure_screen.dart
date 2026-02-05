import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

/// Camera-based body measurement screen
class CameraMeasureScreen extends StatefulWidget {
  const CameraMeasureScreen({super.key});

  @override
  State<CameraMeasureScreen> createState() => _CameraMeasureScreenState();
}

class _CameraMeasureScreenState extends State<CameraMeasureScreen> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      // Use front camera for selfie
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      
      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_isCapturing) return;

    setState(() => _isCapturing = true);

    try {
      final image = await _controller!.takePicture();
      
      if (mounted) {
        context.go(AppRoutes.measurementProcessing, extra: image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to capture: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera preview
            if (_isInitialized && _controller != null)
              Positioned.fill(
                child: CameraPreview(_controller!),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            // Overlay
            Positioned.fill(
              child: _buildOverlay(),
            ),
            // Top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildTopBar(),
            ),
            // Bottom controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return CustomPaint(
      painter: BodyOutlinePainter(),
      child: Container(),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Step 1 of 4',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.9),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          const Text(
            AppStrings.fullBodyPhoto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          // Distance indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.straighten, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                const Text(
                  AppStrings.standDistance,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Tip
          Text(
            AppStrings.wearFittedClothing,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          // Capture button
          GestureDetector(
            onTap: _isCapturing ? null : _capturePhoto,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _isCapturing ? AppColors.primary : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: _isCapturing
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for body outline overlay
class BodyOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw body outline guide
    final centerX = size.width / 2;
    final topY = size.height * 0.15;
    final bottomY = size.height * 0.85;
    
    // Head circle
    canvas.drawCircle(
      Offset(centerX, topY + 30),
      25,
      paint,
    );

    // Body outline path
    final path = Path()
      // Shoulders
      ..moveTo(centerX - 50, topY + 70)
      ..lineTo(centerX + 50, topY + 70)
      // Right arm
      ..moveTo(centerX + 50, topY + 70)
      ..lineTo(centerX + 70, topY + 150)
      // Body right
      ..moveTo(centerX + 50, topY + 70)
      ..lineTo(centerX + 40, topY + 200)
      ..lineTo(centerX + 35, bottomY - 50)
      // Right leg
      ..lineTo(centerX + 30, bottomY)
      // Left leg
      ..moveTo(centerX - 30, bottomY)
      ..lineTo(centerX - 35, bottomY - 50)
      // Body left
      ..lineTo(centerX - 40, topY + 200)
      ..lineTo(centerX - 50, topY + 70)
      // Left arm
      ..moveTo(centerX - 50, topY + 70)
      ..lineTo(centerX - 70, topY + 150);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
