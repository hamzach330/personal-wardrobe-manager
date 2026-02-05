import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Welcome screen with value proposition
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Hero Image Section
            Expanded(
              flex: 5,
              child: _buildHeroSection(context),
            ),
            // Content Section
            Expanded(
              flex: 4,
              child: _buildContentSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryLight.withValues(alpha: 0.5),
            AppColors.backgroundLight,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decorations
          Positioned(
            top: 40,
            left: 20,
            child: _buildDecorationCircle(60, AppColors.primary.withValues(alpha: 0.1)),
          ),
          Positioned(
            top: 80,
            right: 40,
            child: _buildDecorationCircle(40, AppColors.secondary.withValues(alpha: 0.1)),
          ),
          Positioned(
            bottom: 60,
            left: 60,
            child: _buildDecorationCircle(50, AppColors.tertiary.withValues(alpha: 0.1)),
          ),
          // Main illustration
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.checkroom_rounded,
                      size: 100,
                      color: AppColors.primary.withValues(alpha: 0.8),
                    ),
                    Positioned(
                      right: 30,
                      top: 30,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDecorationCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        children: [
          // Headline
          Text(
            AppStrings.welcomeTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            AppStrings.welcomeSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // Buttons
          PrimaryButton(
            text: AppStrings.getStarted,
            onPressed: () => context.push(AppRoutes.signup),
          ),
          const SizedBox(height: 12),
          TertiaryButton(
            text: AppStrings.signIn,
            onPressed: () => context.push(AppRoutes.signup),
          ),
          const SizedBox(height: 16),
          // Footer
          Text(
            AppStrings.termsFooter,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
