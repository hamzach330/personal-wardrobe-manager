import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/option_card.dart';
import '../../../shared/widgets/primary_button.dart';

/// Measurement method selection screen
class MeasurementSetupScreen extends StatefulWidget {
  const MeasurementSetupScreen({super.key});

  @override
  State<MeasurementSetupScreen> createState() => _MeasurementSetupScreenState();
}

class _MeasurementSetupScreenState extends State<MeasurementSetupScreen> {
  MeasurementMethod? _selectedMethod;

  void _onMethodSelected(MeasurementMethod method) {
    setState(() => _selectedMethod = method);
  }

  void _startMeasurement() {
    switch (_selectedMethod) {
      case MeasurementMethod.manual:
        context.push(AppRoutes.manualEntry);
        break;
      case MeasurementMethod.import:
        context.push(AppRoutes.importMeasurements);
        break;
      case MeasurementMethod.camera:
        context.push(AppRoutes.cameraMeasure);
        break;
      case null:
        break;
    }
  }

  void _showSkipWarning() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSkipWarningSheet(),
    );
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                AppStrings.measurementTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                AppStrings.measurementSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Option cards
              Row(
                children: [
                  Expanded(
                    child: OptionCard(
                      icon: Icons.edit_outlined,
                      title: AppStrings.manualEntry,
                      description: AppStrings.manualEntryDescription,
                      isSelected: _selectedMethod == MeasurementMethod.manual,
                      onTap: () => _onMethodSelected(MeasurementMethod.manual),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OptionCard(
                      icon: Icons.download_outlined,
                      title: AppStrings.importSizes,
                      description: AppStrings.importDescription,
                      isSelected: _selectedMethod == MeasurementMethod.import,
                      onTap: () => _onMethodSelected(MeasurementMethod.import),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OptionCard(
                      icon: Icons.camera_alt_outlined,
                      title: AppStrings.cameraMeasure,
                      description: AppStrings.cameraDescription,
                      isSelected: _selectedMethod == MeasurementMethod.camera,
                      onTap: () => _onMethodSelected(MeasurementMethod.camera),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Start button
              PrimaryButton(
                text: AppStrings.startMeasurement,
                onPressed: _selectedMethod != null ? _startMeasurement : null,
                isEnabled: _selectedMethod != null,
              ),
              const SizedBox(height: 12),
              // Skip option
              TextButton(
                onPressed: _showSkipWarning,
                child: Text(
                  AppStrings.skipForNow,
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

  Widget _buildSkipWarningSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              color: AppColors.warning,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.skipMeasurementsTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.skipMeasurementsImpact,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: AppStrings.addMeasurements,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            text: AppStrings.skipAnyway,
            onPressed: () {
              Navigator.pop(context);
              context.go(AppRoutes.wardrobeIntake);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

enum MeasurementMethod {
  manual,
  import,
  camera,
}
