import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wardrobe_app/features/auth/domain/entities/user_entity.dart';
import 'package:wardrobe_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:wardrobe_app/features/auth/domain/usecases/sign_in_with_email.dart';

import 'sign_in_with_email_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInWithEmail useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInWithEmail(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tUser = UserEntity(
    id: '1',
    email: tEmail,
    name: 'Test User',
    createdAt: DateTime.now(), // Added required field
  );

  test('should call signInWithEmail from repository', () async {
    // Arrange
    when(
      mockAuthRepository.signInWithEmail(tEmail, tPassword),
    ).thenAnswer((_) async => tUser);

    // Act
    final result = await useCase(tEmail, tPassword);

    // Assert
    expect(result, tUser);
    verify(mockAuthRepository.signInWithEmail(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should throw an exception when sign in fails', () async {
    // Arrange
    when(
      mockAuthRepository.signInWithEmail(tEmail, tPassword),
    ).thenThrow(Exception('Sign in failed'));

    // Act & Assert
    expect(() => useCase(tEmail, tPassword), throwsA(isA<Exception>()));
  });
}
