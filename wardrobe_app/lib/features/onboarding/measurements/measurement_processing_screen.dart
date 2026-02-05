import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

/// Processing screen for body measurement analysis
class MeasurementProcessingScreen extends StatefulWidget {
  final String? imagePath;

  const MeasurementProcessingScreen({
    super.key,
    this.imagePath,
  });

  @override
  State<MeasurementProcessingScreen> createState() =>
      _MeasurementProcessingScreenState();
}

class _MeasurementProcessingScreenState
    extends State<MeasurementProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  int _currentStep = 0;
  
  final List<ProcessingStep> _steps = [
    ProcessingStep(
      label: AppStrings.detectingLandmarks,
      icon: Icons.person_pin,
    ),
    ProcessingStep(
      label: AppStrings.calculatingProportions,
      icon: Icons.calculate,
    ),
    ProcessingStep(
      label: AppStrings.generatingMeasurements,
      icon: Icons.straighten,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    
    _startProcessing();
  }

  Future<void> _startProcessing() async {
    // Simulate ML processing steps
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() => _currentStep = i + 1);
      }
    }
    
    // Navigate to success
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.go(AppRoutes.measurementsSaved);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Title
              Text(
                AppStrings.analyzingMeasurements,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Progress indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: (_currentStep) / _steps.length,
                      strokeWidth: 8,
                      backgroundColor: AppColors.surfaceVariant,
                      color: AppColors.primary,
                    ),
                  ),
                  // Animated icon
                  RotationTransition(
                    turns: _progressController,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.accessibility_new,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              // Step checklist
              ..._steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                return _buildStepRow(
                  step.label,
                  step.icon,
                  index < _currentStep
                      ? StepStatus.complete
                      : index == _currentStep - 1
                          ? StepStatus.inProgress
                          : StepStatus.pending,
                );
              }),
              const Spacer(),
              // Status text
              Text(
                AppStrings.almostDone,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
