import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/colors.dart';
import '../../../shared/widgets/primary_button.dart';

/// Terms of Service screen
class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      if (!_hasScrolledToBottom) {
        setState(() => _hasScrolledToBottom = true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Terms of Service'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Last updated
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceVariant,
              child: Text(
                'Last updated: February 2026',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      context,
                      '1. Acceptance of Terms',
                      'By downloading, installing, or using the Wardrobe Agent application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the application.',
                    ),
                    _buildSection(
                      context,
                      '2. Service Description',
                      'Wardrobe Agent is a personal wardrobe management application that provides outfit suggestions, wardrobe organization, and shopping recommendations based on your preferences and measurements.',
                    ),
                    _buildSection(
                      context,
                      '3. User Responsibilities',
                      'You are responsible for maintaining the confidentiality of your account credentials. You agree to provide accurate information when creating your profile and using the service. You must not use the service for any unlawful purpose.',
                    ),
                    _buildSection(
                      context,
                      '4. Privacy',
                      'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information. By using the service, you consent to our data practices as described in the Privacy Policy.',
                    ),
                    _buildSection(
                      context,
                      '5. Intellectual Property',
                      'All content, features, and functionality of the application are owned by Wardrobe Agent and are protected by international copyright, trademark, and other intellectual property laws.',
                    ),
                    _buildSection(
                      context,
                      '6. Limitation of Liability',
                      'To the maximum extent permitted by law, Wardrobe Agent shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the service.',
                    ),
                    _buildSection(
                      context,
                      '7. Termination',
                      'We may terminate or suspend your access to the service immediately, without prior notice, for any reason, including breach of these Terms. Upon termination, your right to use the service will cease immediately.',
                    ),
                    _buildSection(
                      context,
                      '8. Contact Us',
                      'If you have any questions about these Terms of Service, please contact us at legal@wardrobeagent.app.',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Agree button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.outlineVariant),
                ),
              ),
              child: PrimaryButton(
                text: 'I agree',
                onPressed: _hasScrolledToBottom ? () => context.pop() : null,
                isEnabled: _hasScrolledToBottom,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
