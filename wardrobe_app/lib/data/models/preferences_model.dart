import 'package:cloud_firestore/cloud_firestore.dart';

/// User style preferences model
class PreferencesModel {
  final String userId;
  final List<StyleVibe> styleVibes;
  final List<FitPriority> fitPriorities;
  final List<PreferredOccasion> occasions;
  final bool dailyReminder;
  final int reminderHour;
  final int reminderMinute;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PreferencesModel({
    required this.userId,
    this.styleVibes = const [],
    this.fitPriorities = const [],
    this.occasions = const [],
    this.dailyReminder = true,
    this.reminderHour = 7,
    this.reminderMinute = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory PreferencesModel.empty(String userId) {
    return PreferencesModel(
      userId: userId,
      createdAt: DateTime.now(),
    );
  }

  factory PreferencesModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PreferencesModel(
      userId: doc.id,
      styleVibes: (data['styleVibes'] as List<dynamic>?)
              ?.map((e) => StyleVibe.values.firstWhere(
                    (v) => v.name == e,
                    orElse: () => StyleVibe.casual,
                  ))
              .toList() ??
          [],
      fitPriorities: (data['fitPriorities'] as List<dynamic>?)
              ?.map((e) => FitPriority.values.firstWhere(
                    (f) => f.name == e,
                    orElse: () => FitPriority.comfort,
                  ))
              .toList() ??
          [],
      occasions: (data['occasions'] as List<dynamic>?)
              ?.map((e) => PreferredOccasion.values.firstWhere(
                    (o) => o.name == e,
                    orElse: () => PreferredOccasion.weekend,
                  ))
              .toList() ??
          [],
      dailyReminder: data['dailyReminder'] as bool? ?? true,
      reminderHour: data['reminderHour'] as int? ?? 7,
      reminderMinute: data['reminderMinute'] as int? ?? 0,
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
      'styleVibes': styleVibes.map((e) => e.name).toList(),
      'fitPriorities': fitPriorities.map((e) => e.name).toList(),
      'occasions': occasions.map((e) => e.name).toList(),
      'dailyReminder': dailyReminder,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    };
  }

  PreferencesModel copyWith({
    String? userId,
    List<StyleVibe>? styleVibes,
    List<FitPriority>? fitPriorities,
    List<PreferredOccasion>? occasions,
    bool? dailyReminder,
    int? reminderHour,
    int? reminderMinute,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PreferencesModel(
      userId: userId ?? this.userId,
      styleVibes: styleVibes ?? this.styleVibes,
      fitPriorities: fitPriorities ?? this.fitPriorities,
      occasions: occasions ?? this.occasions,
      dailyReminder: dailyReminder ?? this.dailyReminder,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isComplete {
    return styleVibes.isNotEmpty &&
        fitPriorities.isNotEmpty &&
        occasions.isNotEmpty;
  }

  String get reminderTimeFormatted {
    final hour = reminderHour > 12 ? reminderHour - 12 : reminderHour;
    final period = reminderHour >= 12 ? 'PM' : 'AM';
    final minute = reminderMinute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}

enum StyleVibe {
  minimal,
  street,
  business,
  casual,
  bold,
}

enum FitPriority {
  comfort,
  tailored,
  sustainable,
  trendy,
}

enum PreferredOccasion {
  work,
  weekend,
  formal,
  travel,
}

extension StyleVibeExtension on StyleVibe {
  String get displayName {
    switch (this) {
      case StyleVibe.minimal:
        return 'Minimal';
      case StyleVibe.street:
        return 'Street';
      case StyleVibe.business:
        return 'Business';
      case StyleVibe.casual:
        return 'Casual';
      case StyleVibe.bold:
        return 'Bold';
    }
  }
}

extension FitPriorityExtension on FitPriority {
  String get displayName {
    switch (this) {
      case FitPriority.comfort:
        return 'Comfort';
      case FitPriority.tailored:
        return 'Tailored';
      case FitPriority.sustainable:
        return 'Sustainable';
      case FitPriority.trendy:
        return 'Trendy';
    }
  }
}

extension PreferredOccasionExtension on PreferredOccasion {
  String get displayName {
    switch (this) {
      case PreferredOccasion.work:
        return 'Work';
      case PreferredOccasion.weekend:
        return 'Weekend';
      case PreferredOccasion.formal:
        return 'Formal';
      case PreferredOccasion.travel:
        return 'Travel';
    }
  }
}
