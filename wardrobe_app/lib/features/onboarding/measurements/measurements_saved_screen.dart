import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Measurements saved success screen
class MeasurementsSavedScreen extends StatefulWidget {
  const MeasurementsSavedScreen({super.key});

  @override
  State<MeasurementsSavedScreen> createState() =>
      _MeasurementsSavedScreenState();
}

class _MeasurementsSavedScreenState extends State<MeasurementsSavedScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  // Success checkmark
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.success,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Title
                  Text(
                    AppStrings.measurementsSaved,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Summary card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        _buildMeasurementRow('Height', '170 cm'),
                        const Divider(height: 24),
                        _buildMeasurementRow('Chest', '95 cm'),
                        const Divider(height: 24),
                        _buildMeasurementRow('Waist', '80 cm'),
                        const Divider(height: 24),
                        _buildMeasurementRow('Hips', '95 cm'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Continue button
                  PrimaryButton(
                    text: AppStrings.continueButton,
                    onPressed: () => context.go(AppRoutes.wardrobeIntake),
                  ),
                  const SizedBox(height: 12),
                  // Edit option
                  TextButton(
                    onPressed: () => context.go(AppRoutes.manualEntry),
                    child: Text(
                      AppStrings.editMeasurements,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                AppColors.primary,
                AppColors.success,
                AppColors.warning,
                AppColors.tertiary,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
