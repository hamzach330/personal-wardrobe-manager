import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

/// Summary card with status items
class SummaryCard extends StatelessWidget {
  final List<SummaryItem> items;

  const SummaryCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _buildSummaryRow(context, item),
              if (index < items.length - 1) ...[
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppColors.outlineVariant),
                const SizedBox(height: 16),
              ],
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, SummaryItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Row(
          children: [
            if (item.value != null)
              Text(
                item.value!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: item.status == SummaryStatus.complete
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            const SizedBox(width: 8),
            _buildStatusIcon(item.status),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIcon(SummaryStatus status) {
    switch (status) {
      case SummaryStatus.complete:
        return const Icon(
          Icons.check_circle,
          color: AppColors.success,
          size: 24,
        );
      case SummaryStatus.incomplete:
        return const Icon(
          Icons.radio_button_unchecked,
          color: AppColors.outline,
          size: 24,
        );
      case SummaryStatus.warning:
        return const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warning,
          size: 24,
        );
    }
  }
}

class SummaryItem {
  final String label;
  final String? value;
  final SummaryStatus status;

  const SummaryItem({
    required this.label,
    this.value,
    required this.status,
  });
}

enum SummaryStatus {
  complete,
  incomplete,
  warning,
}
