import 'package:flutter_test/flutter_test.dart';
import 'package:wardrobe_app/data/models/garment_model.dart';
import 'package:wardrobe_app/data/models/measurement_model.dart';
import 'package:wardrobe_app/data/models/preferences_model.dart';
import 'package:wardrobe_app/data/models/user_model.dart';

void main() {
  group('MeasurementModel', () {
    test('creates empty measurement model', () {
      final measurement = MeasurementModel.empty('user123');

      expect(measurement.userId, 'user123');
      expect(measurement.height, isNull);
      expect(measurement.weight, isNull);
      expect(measurement.hasBasicMeasurements, isFalse);
    });

    test('hasBasicMeasurements returns true when height and weight set', () {
      final measurement = MeasurementModel(
        userId: 'user123',
        height: 170,
        weight: 70,
      );

      expect(measurement.hasBasicMeasurements, isTrue);
    });

    test('hasDetailedMeasurements returns true with chest, waist, hips', () {
      final measurement = MeasurementModel(
        userId: 'user123',
        chest: 95,
        waist: 80,
        hips: 95,
      );

      expect(measurement.hasDetailedMeasurements, isTrue);
    });

    test('displayHeight formats correctly in cm', () {
      final measurement = MeasurementModel(
        userId: 'user123',
        height: 175,
        heightUnit: MeasurementUnit.cm,
      );

      expect(measurement.displayHeight, '175 cm');
    });

    test('displayWeight formats correctly in kg', () {
      final measurement = MeasurementModel(
        userId: 'user123',
        weight: 72,
        weightUnit: MeasurementUnit.kg,
      );

      expect(measurement.displayWeight, '72 kg');
    });

    test('copyWith creates new instance with updated values', () {
      final original = MeasurementModel(
        userId: 'user123',
        height: 170,
        weight: 70,
      );

      final updated = original.copyWith(height: 175);

      expect(updated.height, 175);
      expect(updated.weight, 70);
      expect(updated.userId, 'user123');
    });

    test('toFirestore converts to map correctly', () {
      final measurement = MeasurementModel(
        userId: 'user123',
        height: 170,
        weight: 70,
        source: MeasurementSource.manual,
      );

      final map = measurement.toFirestore();

      expect(map['height'], 170);
      expect(map['weight'], 70);
      expect(map['source'], 'manual');
    });
  });

  group('GarmentModel', () {
    test('categoryDisplayName returns correct string', () {
      final garment = GarmentModel(
        id: 'garment123',
        userId: 'user123',
        imageUrl: 'https://example.com/image.jpg',
        category: GarmentCategory.tShirt,
        color: 'Blue',
        createdAt: DateTime.now(),
      );

      expect(garment.categoryDisplayName, 'T-Shirt');
    });

    test('copyWith creates new instance with updated values', () {
      final original = GarmentModel(
        id: 'garment123',
        userId: 'user123',
        imageUrl: 'https://example.com/image.jpg',
        category: GarmentCategory.shirt,
        color: 'Blue',
        createdAt: DateTime.now(),
      );

      final updated = original.copyWith(color: 'Red');

      expect(updated.color, 'Red');
      expect(updated.category, GarmentCategory.shirt);
    });

    test('toFirestore includes all required fields', () {
      final garment = GarmentModel(
        id: 'garment123',
        userId: 'user123',
        imageUrl: 'https://example.com/image.jpg',
        category: GarmentCategory.jeans,
        color: 'Indigo',
        seasons: [Season.fall, Season.winter],
        occasions: [Occasion.casual],
        createdAt: DateTime.now(),
      );

      final map = garment.toFirestore();

      expect(map['userId'], 'user123');
      expect(map['imageUrl'], 'https://example.com/image.jpg');
      expect(map['category'], 'jeans');
      expect(map['color'], 'Indigo');
      expect(map['seasons'], ['fall', 'winter']);
      expect(map['occasions'], ['casual']);
    });
  });

  group('PreferencesModel', () {
    test('creates empty preferences model', () {
      final prefs = PreferencesModel.empty('user123');

      expect(prefs.userId, 'user123');
      expect(prefs.styleVibes, isEmpty);
      expect(prefs.fitPriorities, isEmpty);
      expect(prefs.occasions, isEmpty);
      expect(prefs.dailyReminder, isTrue);
    });

    test('isComplete returns true when all categories filled', () {
      final prefs = PreferencesModel(
        userId: 'user123',
        styleVibes: [StyleVibe.casual],
        fitPriorities: [FitPriority.comfort],
        occasions: [PreferredOccasion.work],
      );

      expect(prefs.isComplete, isTrue);
    });

    test('isComplete returns false when categories empty', () {
      final prefs = PreferencesModel(
        userId: 'user123',
        styleVibes: [],
        fitPriorities: [],
        occasions: [],
      );

      expect(prefs.isComplete, isFalse);
    });

    test('reminderTimeFormatted returns correct string', () {
      final prefs = PreferencesModel(
        userId: 'user123',
        reminderHour: 7,
        reminderMinute: 0,
      );

      expect(prefs.reminderTimeFormatted, '7:00 AM');

      final evening = PreferencesModel(
        userId: 'user123',
        reminderHour: 19,
        reminderMinute: 30,
      );

      expect(evening.reminderTimeFormatted, '7:30 PM');
    });

    test('toFirestore includes all fields', () {
      final prefs = PreferencesModel(
        userId: 'user123',
        styleVibes: [StyleVibe.minimal, StyleVibe.business],
        fitPriorities: [FitPriority.tailored],
        occasions: [PreferredOccasion.work, PreferredOccasion.formal],
        dailyReminder: true,
        reminderHour: 8,
        reminderMinute: 30,
      );

      final map = prefs.toFirestore();

      expect(map['styleVibes'], ['minimal', 'business']);
      expect(map['fitPriorities'], ['tailored']);
      expect(map['occasions'], ['work', 'formal']);
      expect(map['dailyReminder'], true);
      expect(map['reminderHour'], 8);
      expect(map['reminderMinute'], 30);
    });
  });

  group('UserModel', () {
    test('copyWith creates new instance with updated values', () {
      final original = UserModel(
        id: 'user123',
        name: 'John Doe',
        email: 'john@example.com',
        createdAt: DateTime(2024, 1, 1),
      );

      final updated = original.copyWith(name: 'Jane Doe');

      expect(updated.name, 'Jane Doe');
      expect(updated.email, 'john@example.com');
      expect(updated.id, 'user123');
    });

    test('toFirestore includes all fields', () {
      final user = UserModel(
        id: 'user123',
        name: 'John Doe',
        email: 'john@example.com',
        photoUrl: 'https://example.com/photo.jpg',
        createdAt: DateTime(2024, 1, 1),
        onboardingComplete: true,
      );

      final map = user.toFirestore();

      expect(map['name'], 'John Doe');
      expect(map['email'], 'john@example.com');
      expect(map['photoUrl'], 'https://example.com/photo.jpg');
      expect(map['onboardingComplete'], true);
    });
  });
}
