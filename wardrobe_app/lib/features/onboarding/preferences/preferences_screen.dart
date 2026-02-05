import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/selectable_chip.dart';

/// Style preferences screen
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<String> _selectedStyleVibes = [];
  final List<String> _selectedFitPriorities = [];
  final List<String> _selectedOccasions = [];
  bool _dailyReminder = true;

  final List<String> _styleVibeOptions = [
    AppStrings.minimal,
    AppStrings.street,
    AppStrings.business,
    AppStrings.casual,
    AppStrings.bold,
  ];

  final List<String> _fitPriorityOptions = [
    AppStrings.comfort,
    AppStrings.tailored,
    AppStrings.sustainable,
    AppStrings.trendy,
  ];

  final List<String> _occasionOptions = [
    AppStrings.work,
    AppStrings.weekend,
    AppStrings.formal,
    AppStrings.travel,
  ];

  bool get _isValid {
    return _selectedStyleVibes.isNotEmpty &&
        _selectedFitPriorities.isNotEmpty &&
        _selectedOccasions.isNotEmpty;
  }

  void _toggleOption(List<String> list, String option) {
    setState(() {
      if (list.contains(option)) {
        list.remove(option);
      } else {
        list.add(option);
      }
    });
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      AppStrings.preferencesTitle,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 32),
                    // Style Vibes
                    SelectableChipGroup(
                      title: AppStrings.styleVibes,
                      options: _styleVibeOptions,
                      selectedOptions: _selectedStyleVibes,
                      onOptionToggle: (option) =>
                          _toggleOption(_selectedStyleVibes, option),
                    ),
                    const SizedBox(height: 32),
                    // Fit Priorities
                    SelectableChipGroup(
                      title: AppStrings.fitPriorities,
                      options: _fitPriorityOptions,
                      selectedOptions: _selectedFitPriorities,
                      onOptionToggle: (option) =>
                          _toggleOption(_selectedFitPriorities, option),
                    ),
                    const SizedBox(height: 32),
                    // Occasions
                    SelectableChipGroup(
                      title: AppStrings.occasionsLabel,
                      options: _occasionOptions,
                      selectedOptions: _selectedOccasions,
                      onOptionToggle: (option) =>
                          _toggleOption(_selectedOccasions, option),
                    ),
                    const SizedBox(height: 32),
                    // Daily reminder toggle
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _dailyReminder
                                  ? AppColors.primaryLight
                                  : AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: _dailyReminder
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              AppStrings.dailyReminder,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Switch(
                            value: _dailyReminder,
                            onChanged: (value) {
                              setState(() => _dailyReminder = value);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Helper text
                    Text(
                      AppStrings.selectAtLeastOne,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Next button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: AppStrings.next,
                onPressed: _isValid ? () => context.go(AppRoutes.summary) : null,
                isEnabled: _isValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
