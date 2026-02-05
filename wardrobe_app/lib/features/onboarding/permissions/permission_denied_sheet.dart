import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Bottom sheet warning when permissions are denied
class PermissionDeniedSheet extends StatelessWidget {
  final List<String> deniedPermissions;
  final VoidCallback onEnablePermissions;
  final VoidCallback onContinueAnyway;

  const PermissionDeniedSheet({
    super.key,
    required this.deniedPermissions,
    required this.onEnablePermissions,
    required this.onContinueAnyway,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Warning icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warning,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          // Title
          Text(
            AppStrings.featuresLimited,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Denied permissions list
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: deniedPermissions.map((permission) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.close,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        permission,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          // Buttons
          PrimaryButton(
            text: AppStrings.enablePermissions,
            onPressed: onEnablePermissions,
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            text: AppStrings.continueAnyway,
            onPressed: onContinueAnyway,
          ),
          const SizedBox(height: 16),
          // Note
          Text(
            AppStrings.enableLaterNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
