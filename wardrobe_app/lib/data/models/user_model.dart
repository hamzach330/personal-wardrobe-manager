import 'package:cloud_firestore/cloud_firestore.dart';

/// User profile model
class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool onboardingComplete;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
    this.onboardingComplete = false,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] as String?,
      email: data['email'] as String?,
      photoUrl: data['photoUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      onboardingComplete: data['onboardingComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'onboardingComplete': onboardingComplete,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? onboardingComplete,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}
