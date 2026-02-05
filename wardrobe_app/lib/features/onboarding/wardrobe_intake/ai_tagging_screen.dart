import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/garment_model.dart';
import '../../../shared/services/ml_service.dart';

/// AI tagging progress screen
class AiTaggingScreen extends StatefulWidget {
  final String imagePath;

  const AiTaggingScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<AiTaggingScreen> createState() => _AiTaggingScreenState();
}

class _AiTaggingScreenState extends State<AiTaggingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  int _currentStep = 0;
  GarmentTagResult? _result;

  final List<ProcessingStep> _steps = [
    const ProcessingStep(
      label: AppStrings.detectingGarment,
      icon: Icons.checkroom,
    ),
    const ProcessingStep(
      label: AppStrings.identifyingColor,
      icon: Icons.palette,
    ),
    const ProcessingStep(
      label: AppStrings.recognizingBrand,
      icon: Icons.style,
    ),
    const ProcessingStep(
      label: AppStrings.suggestingOccasions,
      icon: Icons.event,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    // Simulate ML processing steps
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) {
        setState(() => _currentStep = i + 1);
      }
    }

    // Simulate ML result (in real app, use MLService)
    _result = GarmentTagResult(
      category: GarmentCategory.shirt,
      color: 'Navy Blue',
      tags: ['Cotton', 'Casual', 'Button-down'],
      confidence: 0.85,
    );

    // Navigate to tag editing
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.go(
        AppRoutes.tagEditing,
        extra: {
          'imagePath': widget.imagePath,
          'tags': {
            'category': _result!.category.name,
            'color': _result!.color,
            'tags': _result!.tags,
          },
        },
      );
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              // Image preview with scanning overlay
              Stack(
                alignment: Alignment.center,
                children: [
                  // Image
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: widget.imagePath.isNotEmpty
                          ? Image.file(
                              File(widget.imagePath),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ),
                  ),
                  // Scanning animation
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.3),
                          Colors.transparent,
                          Colors.transparent,
                          AppColors.primary.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Title
              Text(
                AppStrings.analyzingItem,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 32),
              // Progress indicator
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: _currentStep / _steps.length,
                  strokeWidth: 4,
                  backgroundColor: AppColors.surfaceVariant,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              // Step checklist
              ..._steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                return _buildStepRow(
                  step.label,
                  step.icon,
                  index < _currentStep
                      ? StepStatus.complete
                      : index == _currentStep
                          ? StepStatus.inProgress
                          : StepStatus.pending,
                );
              }),
              const Spacer(),
              // Cancel button
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.checkroom,
        size: 64,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildStepRow(String label, IconData icon, StepStatus status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _buildStatusIcon(status),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: status == StepStatus.pending
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontWeight: status == StepStatus.complete
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(StepStatus status) {
    switch (status) {
      case StepStatus.complete:
        return const Icon(
          Icons.check_circle,
          color: AppColors.success,
          size: 24,
        );
      case StepStatus.inProgress:
        return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        );
      case StepStatus.pending:
        return const Icon(
          Icons.radio_button_unchecked,
          color: AppColors.outline,
          size: 24,
        );
    }
  }
}

class ProcessingStep {
  final String label;
  final IconData icon;

  const ProcessingStep({
    required this.label,
    required this.icon,
  });
}

enum StepStatus {
  complete,
  inProgress,
  pending,
}
