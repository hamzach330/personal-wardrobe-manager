import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../presentation/providers/auth_providers.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/social_button.dart';

/// Social sign up screen
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool _isLoading = false;
  String? _loadingProvider;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _loadingProvider = 'google';
    });

    try {
      context.push(AppRoutes.signupLoading, extra: 'google');
      await ref.read(authControllerProvider.notifier).signInWithGoogle();
      if (mounted) {
        context.go(AppRoutes.profileConfirm);
      }
    } catch (e) {
      if (mounted) {
        context.pop();
        _showError(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingProvider = null;
        });
      }
    }
  }

  Future<void> _signInWithFacebook() async {
    // Not implemented yet in clean architecture, placeholder
    _showError("Facebook sign in not implemented yet");
  }

  Future<void> _signInWithApple() async {
    // Not implemented yet in clean architecture, placeholder
    _showError("Apple sign in not implemented yet");
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Headline
              Text(
                AppStrings.createAccount,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                AppStrings.signUpSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Social buttons
              SocialButton(
                text: AppStrings.continueWithGoogle,
                provider: SocialProvider.google,
                onPressed: _isLoading ? null : _signInWithGoogle,
                isLoading: _loadingProvider == 'google',
              ),
              const SizedBox(height: 12),
              SocialButton(
                text: AppStrings.continueWithFacebook,
                provider: SocialProvider.facebook,
                onPressed: _isLoading ? null : _signInWithFacebook,
                isLoading: _loadingProvider == 'facebook',
              ),
              const SizedBox(height: 12),
              SocialButton(
                text: AppStrings.continueWithApple,
                provider: SocialProvider.apple,
                onPressed: _isLoading ? null : _signInWithApple,
                isLoading: _loadingProvider == 'apple',
              ),
              const SizedBox(height: 24),
              // Divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.outlineVariant),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppStrings.orDivider,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.outlineVariant),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Email option
              SecondaryButton(
                text: AppStrings.signUpWithEmail,
                onPressed: _isLoading
                    ? null
                    : () => context.push(AppRoutes.emailSignup),
              ),
              const SizedBox(height: 24),
              // Privacy note
              Text(
                AppStrings.privacyNote,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textTertiary),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign in (same screen for now)
                    },
                    child: Text(
                      AppStrings.signIn,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
