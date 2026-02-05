import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

/// Card widget for permission toggle
class PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isEnabled;
  final ValueChanged<bool>? onChanged;

  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isEnabled,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEnabled ? AppColors.primary : AppColors.outlineVariant,
          width: isEnabled ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.primaryLight
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isEnabled ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Toggle switch
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.all(
              isEnabled ? Colors.white : AppColors.outline,
            ),
            trackColor: WidgetStateProperty.all(
              isEnabled ? AppColors.primary : AppColors.surfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
