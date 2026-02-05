import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

/// Selectable chip for preferences
class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Chip group for selecting multiple options
class SelectableChipGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<String> onOptionToggle;

  const SelectableChipGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onOptionToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            return SelectableChip(
              label: option,
              isSelected: selectedOptions.contains(option),
              onTap: () => onOptionToggle(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
