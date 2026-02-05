import 'package:cloud_firestore/cloud_firestore.dart';

/// Garment/clothing item model
class GarmentModel {
  final String id;
  final String userId;
  final String imageUrl;
  final String? thumbnailUrl;
  final GarmentCategory category;
  final String color;
  final String? colorHex;
  final String? brand;
  final List<Season> seasons;
  final List<Occasion> occasions;
  final GarmentFit? fit;
  final List<String> tags;
  final String? notes;
  final int wearCount;
  final DateTime? lastWorn;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const GarmentModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.thumbnailUrl,
    required this.category,
    required this.color,
    this.colorHex,
    this.brand,
    this.seasons = const [],
    this.occasions = const [],
    this.fit,
    this.tags = const [],
    this.notes,
    this.wearCount = 0,
    this.lastWorn,
    required this.createdAt,
    this.updatedAt,
  });

  factory GarmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GarmentModel(
      id: doc.id,
      userId: data['userId'] as String,
      imageUrl: data['imageUrl'] as String,
      thumbnailUrl: data['thumbnailUrl'] as String?,
      category: GarmentCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => GarmentCategory.other,
      ),
      color: data['color'] as String,
      colorHex: data['colorHex'] as String?,
      brand: data['brand'] as String?,
      seasons: (data['seasons'] as List<dynamic>?)
              ?.map((e) => Season.values.firstWhere(
                    (s) => s.name == e,
                    orElse: () => Season.allYear,
                  ))
              .toList() ??
          [],
      occasions: (data['occasions'] as List<dynamic>?)
              ?.map((e) => Occasion.values.firstWhere(
                    (o) => o.name == e,
                    orElse: () => Occasion.casual,
                  ))
              .toList() ??
          [],
      fit: data['fit'] != null
          ? GarmentFit.values.firstWhere(
              (f) => f.name == data['fit'],
              orElse: () => GarmentFit.regular,
            )
          : null,
      tags: (data['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      notes: data['notes'] as String?,
      wearCount: data['wearCount'] as int? ?? 0,
      lastWorn: data['lastWorn'] != null
          ? (data['lastWorn'] as Timestamp).toDate()
          : null,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'category': category.name,
      'color': color,
      'colorHex': colorHex,
      'brand': brand,
      'seasons': seasons.map((e) => e.name).toList(),
      'occasions': occasions.map((e) => e.name).toList(),
      'fit': fit?.name,
      'tags': tags,
      'notes': notes,
      'wearCount': wearCount,
      'lastWorn': lastWorn != null ? Timestamp.fromDate(lastWorn!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    };
  }

  GarmentModel copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    String? thumbnailUrl,
    GarmentCategory? category,
    String? color,
    String? colorHex,
    String? brand,
    List<Season>? seasons,
    List<Occasion>? occasions,
    GarmentFit? fit,
    List<String>? tags,
    String? notes,
    int? wearCount,
    DateTime? lastWorn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      category: category ?? this.category,
      color: color ?? this.color,
      colorHex: colorHex ?? this.colorHex,
      brand: brand ?? this.brand,
      seasons: seasons ?? this.seasons,
      occasions: occasions ?? this.occasions,
      fit: fit ?? this.fit,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      wearCount: wearCount ?? this.wearCount,
      lastWorn: lastWorn ?? this.lastWorn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Display name for the category
  String get categoryDisplayName {
    switch (category) {
      case GarmentCategory.tShirt:
        return 'T-Shirt';
      case GarmentCategory.shirt:
        return 'Shirt';
      case GarmentCategory.blouse:
        return 'Blouse';
      case GarmentCategory.sweater:
        return 'Sweater';
      case GarmentCategory.hoodie:
        return 'Hoodie';
      case GarmentCategory.jacket:
        return 'Jacket';
      case GarmentCategory.coat:
        return 'Coat';
      case GarmentCategory.blazer:
        return 'Blazer';
      case GarmentCategory.pants:
        return 'Pants';
      case GarmentCategory.jeans:
        return 'Jeans';
      case GarmentCategory.shorts:
        return 'Shorts';
      case GarmentCategory.skirt:
        return 'Skirt';
      case GarmentCategory.dress:
        return 'Dress';
      case GarmentCategory.suit:
        return 'Suit';
      case GarmentCategory.shoes:
        return 'Shoes';
      case GarmentCategory.sneakers:
        return 'Sneakers';
      case GarmentCategory.boots:
        return 'Boots';
      case GarmentCategory.sandals:
        return 'Sandals';
      case GarmentCategory.bag:
        return 'Bag';
      case GarmentCategory.watch:
        return 'Watch';
      case GarmentCategory.jewelry:
        return 'Jewelry';
      case GarmentCategory.hat:
        return 'Hat';
      case GarmentCategory.scarf:
        return 'Scarf';
      case GarmentCategory.belt:
        return 'Belt';
      case GarmentCategory.other:
        return 'Other';
    }
  }
}

enum GarmentCategory {
  // Tops
  tShirt,
  shirt,
  blouse,
  sweater,
  hoodie,

  // Outerwear
  jacket,
  coat,
  blazer,

  // Bottoms
  pants,
  jeans,
  shorts,
  skirt,

  // Full body
  dress,
  suit,

  // Footwear
  shoes,
  sneakers,
  boots,
  sandals,

  // Accessories
  bag,
  watch,
  jewelry,
  hat,
  scarf,
  belt,

  // Other
  other,
}

enum Season {
  spring,
  summer,
  fall,
  winter,
  allYear,
}

enum Occasion {
  work,
  casual,
  formal,
  weekend,
  travel,
  sport,
  party,
  date,
}

enum GarmentFit {
  tight,
  slim,
  regular,
  relaxed,
  oversized,
}
