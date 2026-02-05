import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/colors.dart';

/// Privacy Policy screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Privacy Policy'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Effective date
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Effective Date: February 2026',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionWithIcon(
                context,
                Icons.data_usage,
                'What We Collect',
                'We collect information you provide directly, including your name, email, profile photo, body measurements, wardrobe photos, and style preferences. We also collect usage data to improve our recommendations.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.settings_applications,
                'How We Use Your Data',
                'We use your data to provide personalized outfit suggestions, fit recommendations, and shopping guidance. Your measurements help us suggest sizes that fit. Your style preferences shape our recommendations.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.security,
                'Data Storage & Security',
                'Your data is stored securely using industry-standard encryption. Wardrobe photos are stored with access controls. We use Firebase for secure authentication and data storage.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.share,
                'Third-Party Services',
                'We use analytics services to understand app usage. We may use AI services for garment recognition. We do not sell your personal information to third parties.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.gavel,
                'Your Rights & Choices',
                'You can access, update, or delete your data at any time through the app settings. You can opt out of marketing communications. You can request a copy of your data.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.timer,
                'Data Retention',
                'We retain your data as long as your account is active. If you delete your account, we will delete your data within 30 days. Some data may be retained for legal compliance.',
              ),
              _buildSectionWithIcon(
                context,
                Icons.mail,
                'Contact Us',
                'If you have questions about this Privacy Policy, please contact us at privacy@wardrobeagent.app.',
              ),
              const SizedBox(height: 24),
              // Privacy highlight box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your photos never leave your device without your permission',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Download data link
              TextButton.icon(
                onPressed: () {
                  // Download data functionality
                },
                icon: const Icon(Icons.download),
                label: const Text('Download my data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithIcon(
    BuildContext context,
    IconData icon,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
