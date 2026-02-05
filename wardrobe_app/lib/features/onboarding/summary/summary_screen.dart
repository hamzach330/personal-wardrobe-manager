import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/summary_card.dart';

/// Summary and consent screen
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Summary & Consent'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorations
            _buildDecorations(),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Headline
                  Text(
                    AppStrings.summaryTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.reviewSetupSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 32),
                  // Summary card
                  SummaryCard(
                    items: [
                      SummaryItem(
                        label: AppStrings.measurements,
                        status: SummaryStatus.complete,
                      ),
                      SummaryItem(
                        label: AppStrings.wardrobeItems,
                        value: '0 (${AppStrings.readyToAdd})',
                        status: SummaryStatus.incomplete,
                      ),
                      SummaryItem(
                        label: AppStrings.preferences,
                        value: AppStrings.set,
                        status: SummaryStatus.complete,
                      ),
                      SummaryItem(
                        label: AppStrings.dailyReminders,
                        value: AppStrings.on,
                        status: SummaryStatus.complete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Consent section
                  Text(
                    AppStrings.dataStorageConsent,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.agreeToPolicy,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Policy links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPolicyLink(
                        context,
                        AppStrings.termsOfService,
                        () => context.push(AppRoutes.termsOfService),
                      ),
                      const SizedBox(width: 24),
                      _buildPolicyLink(
                        context,
                        AppStrings.privacyPolicy,
                        () => context.push(AppRoutes.privacyPolicy),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Buttons
                  PrimaryButton(
                    text: AppStrings.finishSetup,
                    icon: Icons.check,
                    onPressed: () => context.go(AppRoutes.successCelebration),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.reviewSetup),
                    child: Text(
                      AppStrings.reviewSteps,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorations() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 20,
              child: _buildSparkle(40, AppColors.primary.withValues(alpha: 0.1)),
            ),
            Positioned(
              top: 120,
              right: 40,
              child: _buildSparkle(60, AppColors.primary.withValues(alpha: 0.05)),
            ),
            Positioned(
              bottom: 200,
              left: 40,
              child: _buildSparkle(50, AppColors.tertiary.withValues(alpha: 0.1)),
            ),
            Positioned(
              bottom: 250,
              right: 60,
              child: _buildSparkle(30, AppColors.primary.withValues(alpha: 0.15)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSparkle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildPolicyLink(
    BuildContext context,
    String text,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.open_in_new,
            size: 16,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
