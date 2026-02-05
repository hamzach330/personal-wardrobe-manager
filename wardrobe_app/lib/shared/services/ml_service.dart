import 'package:flutter/foundation.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../data/models/garment_model.dart';

/// ML Service for body measurements and garment tagging
class MLService {
  // Pose detection
  late PoseDetector _poseDetector;
  
  // Image labeling
  late ImageLabeler _imageLabeler;

  MLService() {
    _initializeDetectors();
  }

  void _initializeDetectors() {
    // Initialize pose detector
    final poseOptions = PoseDetectorOptions(
      mode: PoseDetectionMode.single,
      model: PoseDetectionModel.accurate,
    );
    _poseDetector = PoseDetector(options: poseOptions);

    // Initialize image labeler
    final labelOptions = ImageLabelerOptions(confidenceThreshold: 0.5);
    _imageLabeler = ImageLabeler(options: labelOptions);
  }

  /// Analyze body measurements from an image
  Future<MeasurementResult?> analyzeBodyMeasurements(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final poses = await _poseDetector.processImage(inputImage);

      if (poses.isEmpty) {
        return null;
      }

      final pose = poses.first;
      return _calculateMeasurements(pose);
    } catch (e) {
      debugPrint('Error analyzing body measurements: $e');
      return null;
    }
  }

  MeasurementResult _calculateMeasurements(Pose pose) {
    // Get key landmarks
    final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
    final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
    final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
    final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
    final leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle];
    final rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle];
    // Note: nose landmark available for future head-to-toe measurements
    // final nose = pose.landmarks[PoseLandmarkType.nose];

    // Calculate distances (in pixels, need calibration for real measurements)
    double? shoulderWidth;
    if (leftShoulder != null && rightShoulder != null) {
      shoulderWidth = _distance(leftShoulder, rightShoulder);
    }

    double? hipWidth;
    if (leftHip != null && rightHip != null) {
      hipWidth = _distance(leftHip, rightHip);
    }

    double? torsoLength;
    if (leftShoulder != null && leftHip != null) {
      torsoLength = _distance(leftShoulder, leftHip);
    }

    double? legLength;
    if (leftHip != null && leftAnkle != null) {
      legLength = _distance(leftHip, leftAnkle);
    }

    // Calculate confidence score based on landmark visibility
    final landmarks = [
      leftShoulder,
      rightShoulder,
      leftHip,
      rightHip,
      leftAnkle,
      rightAnkle,
    ];
    final visibleCount = landmarks.where((l) => l != null).length;
    final confidence = visibleCount / landmarks.length;

    return MeasurementResult(
      shoulderWidth: shoulderWidth,
      hipWidth: hipWidth,
      torsoLength: torsoLength,
      legLength: legLength,
      confidence: confidence,
    );
  }

  double _distance(PoseLandmark a, PoseLandmark b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    return (dx * dx + dy * dy);
  }

  /// Analyze garment from an image
  Future<GarmentTagResult> analyzeGarment(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final labels = await _imageLabeler.processImage(inputImage);

      // Extract relevant garment information
      GarmentCategory? category;
      String? color;
      List<String> tags = [];
      double confidence = 0.0;

      for (final label in labels) {
        final labelText = label.label.toLowerCase();
        
        // Try to determine category
        category ??= _mapLabelToCategory(labelText);

        // Collect tags
        if (label.confidence > 0.5) {
          tags.add(label.label);
          if (label.confidence > confidence) {
            confidence = label.confidence;
          }
        }
      }

      // Default category if not detected
      category ??= GarmentCategory.other;

      return GarmentTagResult(
        category: category,
        color: color ?? 'Unknown',
        tags: tags,
        confidence: confidence,
      );
    } catch (e) {
      debugPrint('Error analyzing garment: $e');
      return GarmentTagResult(
        category: GarmentCategory.other,
        color: 'Unknown',
        tags: [],
        confidence: 0.0,
      );
    }
  }

  GarmentCategory? _mapLabelToCategory(String label) {
    final categoryMapping = {
      't-shirt': GarmentCategory.tShirt,
      'tshirt': GarmentCategory.tShirt,
      'shirt': GarmentCategory.shirt,
      'blouse': GarmentCategory.blouse,
      'sweater': GarmentCategory.sweater,
      'hoodie': GarmentCategory.hoodie,
      'jacket': GarmentCategory.jacket,
      'coat': GarmentCategory.coat,
      'blazer': GarmentCategory.blazer,
      'pants': GarmentCategory.pants,
      'trousers': GarmentCategory.pants,
      'jeans': GarmentCategory.jeans,
      'shorts': GarmentCategory.shorts,
      'skirt': GarmentCategory.skirt,
      'dress': GarmentCategory.dress,
      'suit': GarmentCategory.suit,
      'shoes': GarmentCategory.shoes,
      'sneakers': GarmentCategory.sneakers,
      'boots': GarmentCategory.boots,
      'sandals': GarmentCategory.sandals,
      'bag': GarmentCategory.bag,
      'handbag': GarmentCategory.bag,
      'watch': GarmentCategory.watch,
      'jewelry': GarmentCategory.jewelry,
      'hat': GarmentCategory.hat,
      'cap': GarmentCategory.hat,
      'scarf': GarmentCategory.scarf,
      'belt': GarmentCategory.belt,
    };

    for (final entry in categoryMapping.entries) {
      if (label.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }

  void dispose() {
    _poseDetector.close();
    _imageLabeler.close();
  }
}

/// Result of body measurement analysis
class MeasurementResult {
  final double? shoulderWidth;
  final double? hipWidth;
  final double? torsoLength;
  final double? legLength;
  final double confidence;

  const MeasurementResult({
    this.shoulderWidth,
    this.hipWidth,
    this.torsoLength,
    this.legLength,
    required this.confidence,
  });
}

/// Result of garment analysis
class GarmentTagResult {
  final GarmentCategory category;
  final String color;
  final List<String> tags;
  final double confidence;

  const GarmentTagResult({
    required this.category,
    required this.color,
    required this.tags,
    required this.confidence,
  });
}
