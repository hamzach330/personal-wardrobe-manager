import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/primary_button.dart';

/// Profile confirmation screen after social auth
class ProfileConfirmScreen extends ConsumerWidget {
  const ProfileConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final name = user?.displayName ?? 'User';
    final email = user?.email ?? '';
    final photoUrl = user?.photoURL;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success checkmark
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.success,
                  size: 32,
                ),
              ),
              const SizedBox(height: 32),
              // Profile photo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: photoUrl != null
                      ? Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholderAvatar(name),
                        )
                      : _buildPlaceholderAvatar(name),
                ),
              ),
              const SizedBox(height: 24),
              // Welcome text
              Text(
                '${AppStrings.welcomeUser}$name!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 32),
              // Is this you?
              Text(
                AppStrings.isThisYou,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const Spacer(),
              // Buttons
              PrimaryButton(
                text: AppStrings.yesContinue,
                onPressed: () => context.go(AppRoutes.permissions),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                text: AppStrings.useDifferentAccount,
                onPressed: () async {
                  await ref.read(authStateNotifierProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(AppRoutes.signup);
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderAvatar(String name) {
    return Container(
      color: AppColors.primaryLight,
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
