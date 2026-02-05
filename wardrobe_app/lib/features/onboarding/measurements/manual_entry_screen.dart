import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Manual measurement entry screen
class ManualEntryScreen extends ConsumerStatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  ConsumerState<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends ConsumerState<ManualEntryScreen> {
  bool _isMetric = true;
  bool _isLoading = false;

  // Measurement values
  double _height = 170;
  double _weight = 70;
  double _chest = 95;
  double _waist = 80;
  double _hips = 95;
  double _shoulderWidth = 45;
  double _armLength = 60;
  double _inseam = 80;

  Future<void> _saveMeasurements() async {
    setState(() => _isLoading = true);

    try {
      // Here we would save to Firestore
      // For now, just navigate to success screen
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        context.go(AppRoutes.measurementsSaved);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(AppStrings.enterMeasurements),
        actions: [
          TextButton(
            onPressed: () {
              // Show how to measure dialog
            },
            child: const Text(AppStrings.howToMeasure),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Unit toggle
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildUnitToggle('Metric', _isMetric, () {
                    setState(() => _isMetric = true);
                  }),
                  const SizedBox(width: 12),
                  _buildUnitToggle('Imperial', !_isMetric, () {
                    setState(() => _isMetric = false);
                  }),
                ],
              ),
            ),
            // Measurement form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Body illustration
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.accessibility_new,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Measurements
                    _buildMeasurementRow(
                      AppStrings.height,
                      _height,
                      _isMetric ? 'cm' : 'ft',
                      _isMetric ? 100 : 4,
                      _isMetric ? 220 : 7,
                      (value) => setState(() => _height = value),
                    ),
                    _buildMeasurementRow(
                      AppStrings.weight,
                      _weight,
                      _isMetric ? 'kg' : 'lbs',
                      _isMetric ? 30 : 66,
                      _isMetric ? 150 : 330,
                      (value) => setState(() => _weight = value),
                    ),
                    const Divider(height: 32),
                    _buildMeasurementRow(
                      AppStrings.chest,
                      _chest,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 60 : 24,
                      _isMetric ? 150 : 60,
                      (value) => setState(() => _chest = value),
                    ),
                    _buildMeasurementRow(
                      AppStrings.waist,
                      _waist,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 50 : 20,
                      _isMetric ? 130 : 52,
                      (value) => setState(() => _waist = value),
                    ),
                    _buildMeasurementRow(
                      AppStrings.hips,
                      _hips,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 60 : 24,
                      _isMetric ? 150 : 60,
                      (value) => setState(() => _hips = value),
                    ),
                    const Divider(height: 32),
                    _buildMeasurementRow(
                      AppStrings.shoulderWidth,
                      _shoulderWidth,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 30 : 12,
                      _isMetric ? 60 : 24,
                      (value) => setState(() => _shoulderWidth = value),
                    ),
                    _buildMeasurementRow(
                      AppStrings.armLength,
                      _armLength,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 40 : 16,
                      _isMetric ? 80 : 32,
                      (value) => setState(() => _armLength = value),
                    ),
                    _buildMeasurementRow(
                      AppStrings.inseam,
                      _inseam,
                      _isMetric ? 'cm' : 'in',
                      _isMetric ? 60 : 24,
                      _isMetric ? 100 : 40,
                      (value) => setState(() => _inseam = value),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Save button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: AppStrings.saveMeasurements,
                onPressed: _saveMeasurements,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitToggle(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementRow(
    String label,
    double value,
    String unit,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            color: AppColors.primary,
            onPressed: value > min
                ? () => onChanged(value - 1)
                : null,
          ),
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${value.round()} $unit',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: AppColors.primary,
            onPressed: value < max
                ? () => onChanged(value + 1)
                : null,
          ),
        ],
      ),
    );
  }
}
