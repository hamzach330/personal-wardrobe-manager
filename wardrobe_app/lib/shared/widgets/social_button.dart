import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

/// Social authentication button
class SocialButton extends StatelessWidget {
  final String text;
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.text,
    required this.provider,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: provider == SocialProvider.google
                ? const BorderSide(color: AppColors.outline)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: _foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (provider) {
      case SocialProvider.google:
        return Colors.white;
      case SocialProvider.facebook:
        return AppColors.facebookBlue;
      case SocialProvider.apple:
        return AppColors.appleBlack;
    }
  }

  Color get _foregroundColor {
    switch (provider) {
      case SocialProvider.google:
        return AppColors.textPrimary;
      case SocialProvider.facebook:
        return Colors.white;
      case SocialProvider.apple:
        return Colors.white;
    }
  }

  Widget _buildIcon() {
    switch (provider) {
      case SocialProvider.google:
        return Image.network(
          'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
          width: 24,
          height: 24,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.g_mobiledata,
            size: 24,
            color: AppColors.googleRed,
          ),
        );
      case SocialProvider.facebook:
        return const Icon(Icons.facebook, size: 24);
      case SocialProvider.apple:
        return const Icon(Icons.apple, size: 24);
    }
  }
}

enum SocialProvider {
  google,
  facebook,
  apple,
}
