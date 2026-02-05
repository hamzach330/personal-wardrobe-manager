import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../shared/widgets/option_card.dart';
import '../../../shared/widgets/primary_button.dart';

/// Import measurements from external sources
class ImportMeasurementsScreen extends StatefulWidget {
  const ImportMeasurementsScreen({super.key});

  @override
  State<ImportMeasurementsScreen> createState() => _ImportMeasurementsScreenState();
}

class _ImportMeasurementsScreenState extends State<ImportMeasurementsScreen> {
  bool _isLoading = false;
  ImportSource? _selectedSource;

  Future<void> _startImport() async {
    if (_selectedSource == null) return;

    setState(() => _isLoading = true);

    try {
      // Simulate import process
      await Future.delayed(const Duration(seconds: 2));
      
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
        title: const Text('Import your sizes'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Source selection cards
              HorizontalOptionCard(
                icon: Icons.health_and_safety_outlined,
                title: 'Apple Health / Wallet',
                description: 'Sync height and weight from your health data',
                onTap: () => setState(() => _selectedSource = ImportSource.appleHealth),
                trailing: _selectedSource == ImportSource.appleHealth
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              HorizontalOptionCard(
                icon: Icons.email_outlined,
                title: 'Email Receipts',
                description: 'Scan order confirmations for size info',
                onTap: () => setState(() => _selectedSource = ImportSource.emailReceipts),
                trailing: _selectedSource == ImportSource.emailReceipts
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              // Connected accounts section
              if (_selectedSource != null) ...[
                Text(
                  'Connected accounts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedSource == ImportSource.appleHealth
                            ? Icons.favorite
                            : Icons.email,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedSource == ImportSource.appleHealth
                              ? 'Apple Health'
                              : 'user@email.com',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              // Privacy badge
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your data stays on device',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Import button
              PrimaryButton(
                text: 'Start import',
                onPressed: _selectedSource != null ? _startImport : null,
                isEnabled: _selectedSource != null,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ImportSource {
  appleHealth,
  emailReceipts,
}
