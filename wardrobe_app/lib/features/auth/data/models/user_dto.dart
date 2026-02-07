import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

/// Data Transfer Object for User.
/// Handles serialization between Firestore and Domain Entity.
class UserDto {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool onboardingComplete;

  const UserDto({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
    this.onboardingComplete = false,
  });

  factory UserDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserDto(
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

  UserEntity toDomain() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      onboardingComplete: onboardingComplete,
    );
  }

  factory UserDto.fromDomain(UserEntity entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photoUrl: entity.photoUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      onboardingComplete: entity.onboardingComplete,
    );
  }
}
