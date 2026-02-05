import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

/// Loading screen during social authentication
class SignupLoadingScreen extends StatelessWidget {
  final String? provider;

  const SignupLoadingScreen({
    super.key,
    this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Provider icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getProviderIcon(),
                  size: 40,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              // Loading spinner
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              // Loading text
              Text(
                AppStrings.signingIn,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getProviderIcon() {
    switch (provider) {
      case 'google':
        return Icons.g_mobiledata;
      case 'facebook':
        return Icons.facebook;
      case 'apple':
        return Icons.apple;
      default:
        return Icons.person_outline;
    }
  }
}
