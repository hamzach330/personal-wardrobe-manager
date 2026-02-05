import 'package:cloud_firestore/cloud_firestore.dart';

/// Body measurement model
class MeasurementModel {
  final String userId;
  final double? height; // in cm
  final double? weight; // in kg
  final double? chest;
  final double? waist;
  final double? hips;
  final double? shoulderWidth;
  final double? armLength;
  final double? inseam;
  final MeasurementUnit heightUnit;
  final MeasurementUnit weightUnit;
  final MeasurementSource source;
  final double? confidenceScore;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MeasurementModel({
    required this.userId,
    this.height,
    this.weight,
    this.chest,
    this.waist,
    this.hips,
    this.shoulderWidth,
    this.armLength,
    this.inseam,
    this.heightUnit = MeasurementUnit.cm,
    this.weightUnit = MeasurementUnit.kg,
    this.source = MeasurementSource.manual,
    this.confidenceScore,
    this.createdAt,
    this.updatedAt,
  });

  factory MeasurementModel.empty(String userId) {
    return MeasurementModel(
      userId: userId,
      createdAt: DateTime.now(),
    );
  }

  factory MeasurementModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MeasurementModel(
      userId: doc.id,
      height: (data['height'] as num?)?.toDouble(),
      weight: (data['weight'] as num?)?.toDouble(),
      chest: (data['chest'] as num?)?.toDouble(),
      waist: (data['waist'] as num?)?.toDouble(),
      hips: (data['hips'] as num?)?.toDouble(),
      shoulderWidth: (data['shoulderWidth'] as num?)?.toDouble(),
      armLength: (data['armLength'] as num?)?.toDouble(),
      inseam: (data['inseam'] as num?)?.toDouble(),
      heightUnit: MeasurementUnit.values.firstWhere(
        (e) => e.name == data['heightUnit'],
        orElse: () => MeasurementUnit.cm,
      ),
      weightUnit: MeasurementUnit.values.firstWhere(
        (e) => e.name == data['weightUnit'],
        orElse: () => MeasurementUnit.kg,
      ),
      source: MeasurementSource.values.firstWhere(
        (e) => e.name == data['source'],
        orElse: () => MeasurementSource.manual,
      ),
      confidenceScore: (data['confidenceScore'] as num?)?.toDouble(),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'height': height,
      'weight': weight,
      'chest': chest,
      'waist': waist,
      'hips': hips,
      'shoulderWidth': shoulderWidth,
      'armLength': armLength,
      'inseam': inseam,
      'heightUnit': heightUnit.name,
      'weightUnit': weightUnit.name,
      'source': source.name,
      'confidenceScore': confidenceScore,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    };
  }

  MeasurementModel copyWith({
    String? userId,
    double? height,
    double? weight,
    double? chest,
    double? waist,
    double? hips,
    double? shoulderWidth,
    double? armLength,
    double? inseam,
    MeasurementUnit? heightUnit,
    MeasurementUnit? weightUnit,
    MeasurementSource? source,
    double? confidenceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MeasurementModel(
      userId: userId ?? this.userId,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      chest: chest ?? this.chest,
      waist: waist ?? this.waist,
      hips: hips ?? this.hips,
      shoulderWidth: shoulderWidth ?? this.shoulderWidth,
      armLength: armLength ?? this.armLength,
      inseam: inseam ?? this.inseam,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      source: source ?? this.source,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasBasicMeasurements {
    return height != null && weight != null;
  }

  bool get hasDetailedMeasurements {
    return chest != null && waist != null && hips != null;
  }

  /// Convert height to display format based on unit
  String get displayHeight {
    if (height == null) return '--';
    if (heightUnit == MeasurementUnit.ft) {
      final totalInches = height! / 2.54;
      final feet = (totalInches / 12).floor();
      final inches = (totalInches % 12).round();
      return '$feet\'$inches"';
    }
    return '${height!.round()} cm';
  }

  /// Convert weight to display format based on unit
  String get displayWeight {
    if (weight == null) return '--';
    if (weightUnit == MeasurementUnit.lbs) {
      return '${(weight! * 2.205).round()} lbs';
    }
    return '${weight!.round()} kg';
  }
}

enum MeasurementUnit {
  cm,
  ft,
  kg,
  lbs,
}

enum MeasurementSource {
  manual,
  imported,
  camera,
}
