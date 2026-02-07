import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../auth/presentation/providers/auth_providers.dart';
import '../../../shared/widgets/primary_button.dart';

/// Success celebration screen after onboarding completion
class SuccessCelebrationScreen extends ConsumerStatefulWidget {
  const SuccessCelebrationScreen({super.key});

  @override
  ConsumerState<SuccessCelebrationScreen> createState() =>
      _SuccessCelebrationScreenState();
}

class _SuccessCelebrationScreenState
    extends ConsumerState<SuccessCelebrationScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    // Start animations
    _confettiController.play();
    _animationController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserEntityProvider);
    final name = user?.name ?? 'there';
    final photoUrl = user?.photoUrl;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryLight.withValues(alpha: 0.5),
                  AppColors.backgroundLight,
                ],
              ),
            ),
          ),
          // Floating decorations
          _buildFloatingIcons(),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  // Animated checkmark
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Title
                  Text(
                    AppStrings.youreAllSet,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.agentReady,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // User profile
                  if (photoUrl != null)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              _buildAvatarPlaceholder(name),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                      child: _buildAvatarPlaceholder(name),
                    ),
                  const SizedBox(height: 16),
                  // Items count
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${AppStrings.readyToStyle} 0 ${AppStrings.items}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // CTA
                  PrimaryButton(
                    text: AppStrings.goToWardrobe,
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                  const SizedBox(height: 16),
                  // Note
                  Text(
                    AppStrings.firstOutfitNote,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
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
              emissionFrequency: 0.03,
              numberOfParticles: 30,
              gravity: 0.05,
              colors: const [
                AppColors.primary,
                AppColors.success,
                AppColors.warning,
                AppColors.tertiary,
                Colors.pink,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildFloatingIcons() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: 120,
              left: 30,
              child: _buildFloatingIcon(Icons.checkroom, 0.15),
            ),
            Positioned(
              top: 200,
              right: 40,
              child: _buildFloatingIcon(Icons.shopping_bag, 0.1),
            ),
            Positioned(
              bottom: 300,
              left: 50,
              child: _buildFloatingIcon(Icons.style, 0.12),
            ),
            Positioned(
              bottom: 250,
              right: 30,
              child: _buildFloatingIcon(Icons.auto_awesome, 0.08),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, double opacity) {
    return Icon(
      icon,
      size: 40,
      color: AppColors.primary.withValues(alpha: opacity),
    );
  }
}
