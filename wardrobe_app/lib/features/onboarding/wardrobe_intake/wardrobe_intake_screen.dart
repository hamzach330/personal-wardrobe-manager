import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/primary_button.dart';

/// Wardrobe intake intro screen
class WardrobeIntakeScreen extends StatelessWidget {
  const WardrobeIntakeScreen({super.key});

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
            children: [
              const SizedBox(height: 24),
              // Title
              Text(
                AppStrings.wardrobeIntroTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Step illustration
              _buildStepFlow(context),
              const SizedBox(height: 40),
              // Description
              Text(
                AppStrings.wardrobeIntroContent,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Info pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.addLaterNote,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              PrimaryButton(
                text: AppStrings.addFirstItem,
                onPressed: () => context.push(AppRoutes.cameraCapture),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                text: AppStrings.importFromGallery,
                onPressed: () => context.push(AppRoutes.galleryPicker),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go(AppRoutes.preferences),
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

  Widget _buildStepFlow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStep(
          context,
          Icons.camera_alt_outlined,
          AppStrings.wardrobeIntroStep1,
          1,
        ),
        _buildArrow(),
        _buildStep(
          context,
          Icons.label_outline,
          AppStrings.wardrobeIntroStep2,
          2,
        ),
        _buildArrow(),
        _buildStep(
          context,
          Icons.checkroom_outlined,
          AppStrings.wardrobeIntroStep3,
          3,
        ),
      ],
    );
  }

  Widget _buildStep(
    BuildContext context,
    IconData icon,
    String label,
    int number,
  ) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Icon(
        Icons.arrow_forward,
        color: AppColors.outline,
        size: 20,
      ),
    );
  }
}
