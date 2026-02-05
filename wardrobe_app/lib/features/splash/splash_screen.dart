import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/constants/colors.dart';

/// Animated splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Logo fade in (0.0 - 0.3)
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Logo scale up (0.0 - 0.3)
    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Text fade in (0.3 - 0.5)
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
      ),
    );

    // Progress bar (0.5 - 1.0)
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToWelcome();
      }
    });
  }

  void _navigateToWelcome() {
    context.go(AppRoutes.welcome);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.splashGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo and App Name
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoFadeAnimation.value,
                    child: Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: _buildLogo(),
              ),
              const SizedBox(height: 24),
              // App Name
              AnimatedBuilder(
                animation: _textFadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textFadeAnimation.value,
                    child: child,
                  );
                },
                child: _buildAppName(),
              ),
              const Spacer(flex: 2),
              // Floating decorations
              _buildFloatingDecorations(),
              const Spacer(),
              // Progress bar
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: AppColors.primaryLight,
                        color: AppColors.primary,
                        minHeight: 3,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.checkroom_rounded,
        size: 64,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAppName() {
    return Column(
      children: [
        Text(
          'Wardrobe',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
        ),
        Text(
          'Agent',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildFloatingDecorations() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 40,
            top: 0,
            child: _buildFloatingIcon(Icons.dry_cleaning_outlined, 0.3),
          ),
          Positioned(
            right: 60,
            top: 20,
            child: _buildFloatingIcon(Icons.shopping_bag_outlined, 0.2),
          ),
          Positioned(
            left: 100,
            bottom: 0,
            child: _buildFloatingIcon(Icons.style_outlined, 0.25),
          ),
          Positioned(
            right: 100,
            bottom: 10,
            child: _buildFloatingIcon(Icons.auto_awesome, 0.15),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, double opacity) {
    return Icon(
      icon,
      size: 32,
      color: AppColors.outline.withValues(alpha: opacity),
    );
  }
}
