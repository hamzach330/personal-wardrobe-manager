import 'package:equatable/equatable.dart';

/// User entity representing a user in the domain layer.
/// This is a pure Dart object without any infrastructure dependencies.
class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool onboardingComplete;

  const UserEntity({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
    this.onboardingComplete = false,
  });

  /// Creates a copy of this user with the given fields replaced with the new values.
  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? onboardingComplete,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    photoUrl,
    createdAt,
    updatedAt,
    onboardingComplete,
  ];
}
