import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../shared/widgets/permission_card.dart';
import '../../../shared/widgets/primary_button.dart';
import 'permission_denied_sheet.dart';

/// Permissions overview screen
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _measurementsEnabled = true;
  bool _photosEnabled = true;
  bool _locationEnabled = true;

  bool get _allEnabled =>
      _measurementsEnabled && _photosEnabled && _locationEnabled;

  Future<void> _requestPermissions() async {
    // Request camera permission
    if (_photosEnabled) {
      final cameraStatus = await Permission.camera.request();
      final photosStatus = await Permission.photos.request();
      
      if (cameraStatus.isDenied || photosStatus.isDenied) {
        setState(() => _photosEnabled = false);
      }
    }

    // Request location permission
    if (_locationEnabled) {
      final locationStatus = await Permission.locationWhenInUse.request();
      
      if (locationStatus.isDenied) {
        setState(() => _locationEnabled = false);
      }
    }

    _navigateNext();
  }

  void _navigateNext() {
    if (!_allEnabled) {
      _showPermissionDeniedSheet();
    } else {
      context.go(AppRoutes.measurementSetup);
    }
  }

  void _showPermissionDeniedSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PermissionDeniedSheet(
        deniedPermissions: _getDeniedPermissions(),
        onEnablePermissions: () {
          Navigator.pop(context);
          openAppSettings();
        },
        onContinueAnyway: () {
          Navigator.pop(context);
          context.go(AppRoutes.measurementSetup);
        },
      ),
    );
  }

  List<String> _getDeniedPermissions() {
    final denied = <String>[];
    if (!_measurementsEnabled) denied.add('Measurements');
    if (!_photosEnabled) denied.add('Camera & Photos');
    if (!_locationEnabled) denied.add('Location');
    return denied;
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
              // Headline
              Text(
                AppStrings.permissionsTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Permission cards
              PermissionCard(
                icon: Icons.straighten,
                title: AppStrings.measurementsPermission,
                description: AppStrings.measurementsDescription,
                isEnabled: _measurementsEnabled,
                onChanged: (value) {
                  setState(() => _measurementsEnabled = value);
                },
              ),
              const SizedBox(height: 16),
              PermissionCard(
                icon: Icons.camera_alt_outlined,
                title: AppStrings.photosPermission,
                description: AppStrings.photosDescription,
                isEnabled: _photosEnabled,
                onChanged: (value) {
                  setState(() => _photosEnabled = value);
                },
              ),
              const SizedBox(height: 16),
              PermissionCard(
                icon: Icons.location_on_outlined,
                title: AppStrings.locationPermission,
                description: AppStrings.locationDescription,
                isEnabled: _locationEnabled,
                onChanged: (value) {
                  setState(() => _locationEnabled = value);
                },
              ),
              const SizedBox(height: 24),
              // Why we ask link
              TextButton(
                onPressed: () {
                  _showWhyWeAskDialog();
                },
                child: Text(
                  AppStrings.whyWeAsk,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Spacer(),
              // Continue button
              PrimaryButton(
                text: AppStrings.continueButton,
                onPressed: _requestPermissions,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showWhyWeAskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Why we ask for permissions'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• Measurements: Help us recommend clothes that fit you perfectly.\n\n'
              '• Camera & Photos: Add items to your wardrobe by taking photos.\n\n'
              '• Location: Get weather-appropriate outfit suggestions.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
