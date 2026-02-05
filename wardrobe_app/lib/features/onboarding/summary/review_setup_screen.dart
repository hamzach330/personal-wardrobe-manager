import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Review setup screen with editable sections
class ReviewSetupScreen extends StatelessWidget {
  const ReviewSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Review your setup'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceVariant,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Setup 80% complete',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Text('4/5'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.8,
                      backgroundColor: AppColors.outline.withValues(alpha: 0.3),
                      color: AppColors.primary,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
            // Editable cards
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildEditableCard(
                      context,
                      'Profile',
                      Icons.person_outline,
                      [
                        _buildCardRow(context, 'Name', 'John Doe'),
                        _buildCardRow(context, 'Email', 'john@example.com'),
                      ],
                      () {
                        // Edit profile
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildEditableCard(
                      context,
                      'Measurements',
                      Icons.straighten,
                      [
                        _buildCardRow(context, 'Height', '170 cm'),
                        _buildCardRow(context, 'Chest', '95 cm'),
                        _buildCardRow(context, 'Waist', '80 cm'),
                      ],
                      () => context.push(AppRoutes.manualEntry),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableCard(
                      context,
                      'Wardrobe',
                      Icons.checkroom,
                      [
                        _buildCardRow(context, 'Items added', '0'),
                      ],
                      () => context.push(AppRoutes.wardrobeIntake),
                      actionText: 'Add more',
                      isIncomplete: true,
                    ),
                    const SizedBox(height: 16),
                    _buildEditableCard(
                      context,
                      'Preferences',
                      Icons.tune,
                      [
                        _buildCardRow(context, 'Style', 'Casual, Minimal'),
                        _buildCardRow(context, 'Occasions', 'Work, Weekend'),
                      ],
                      () => context.push(AppRoutes.preferences),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableCard(
                      context,
                      'Notifications',
                      Icons.notifications_outlined,
                      [
                        _buildCardRow(context, 'Daily reminder', 'On, 7:00 AM'),
                      ],
                      () {
                        // Edit notifications
                      },
                      showToggle: true,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  PrimaryButton(
                    text: AppStrings.finishSetup,
                    onPressed: () => context.go(AppRoutes.successCelebration),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      // Save and exit
                    },
                    child: Text(
                      'Save and exit',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
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

  Widget _buildEditableCard(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> rows,
    VoidCallback onEdit, {
    String actionText = 'Edit',
    bool isIncomplete = false,
    bool showToggle = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isIncomplete ? AppColors.warning : AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isIncomplete
                      ? AppColors.warningLight
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isIncomplete ? AppColors.warning : AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              if (showToggle)
                Switch(
                  value: true,
                  onChanged: (value) {},
                )
              else
                TextButton(
                  onPressed: onEdit,
                  child: Text(
                    actionText,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildCardRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
