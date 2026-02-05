import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_screen.dart';
import '../features/auth/screens/welcome_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/signup_loading_screen.dart';
import '../features/auth/screens/email_signup_screen.dart';
import '../features/auth/screens/profile_confirm_screen.dart';
import '../features/onboarding/permissions/permissions_screen.dart';
import '../features/onboarding/measurements/measurement_setup_screen.dart';
import '../features/onboarding/measurements/manual_entry_screen.dart';
import '../features/onboarding/measurements/import_measurements_screen.dart';
import '../features/onboarding/measurements/camera_measure_screen.dart';
import '../features/onboarding/measurements/measurement_processing_screen.dart';
import '../features/onboarding/measurements/measurements_saved_screen.dart';
import '../features/onboarding/wardrobe_intake/wardrobe_intake_screen.dart';
import '../features/onboarding/wardrobe_intake/camera_capture_screen.dart';
import '../features/onboarding/wardrobe_intake/gallery_picker_screen.dart';
import '../features/onboarding/wardrobe_intake/ai_tagging_screen.dart';
import '../features/onboarding/wardrobe_intake/tag_editing_screen.dart';
import '../features/onboarding/wardrobe_intake/item_saved_screen.dart';
import '../features/onboarding/preferences/preferences_screen.dart';
import '../features/onboarding/summary/summary_screen.dart';
import '../features/onboarding/summary/terms_of_service_screen.dart';
import '../features/onboarding/summary/privacy_policy_screen.dart';
import '../features/onboarding/summary/review_setup_screen.dart';
import '../features/onboarding/summary/success_celebration_screen.dart';
import '../features/home/home_screen.dart';
import '../shared/providers/auth_provider.dart';

/// Route paths
class AppRoutes {
  AppRoutes._();

  // Splash
  static const String splash = '/';

  // Auth
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String signupLoading = '/signup/loading';
  static const String emailSignup = '/signup/email';
  static const String profileConfirm = '/signup/confirm';

  // Onboarding - Permissions
  static const String permissions = '/onboarding/permissions';

  // Onboarding - Measurements
  static const String measurementSetup = '/onboarding/measurements';
  static const String manualEntry = '/onboarding/measurements/manual';
  static const String importMeasurements = '/onboarding/measurements/import';
  static const String cameraMeasure = '/onboarding/measurements/camera';
  static const String measurementProcessing = '/onboarding/measurements/processing';
  static const String measurementsSaved = '/onboarding/measurements/saved';

  // Onboarding - Wardrobe Intake
  static const String wardrobeIntake = '/onboarding/wardrobe';
  static const String cameraCapture = '/onboarding/wardrobe/camera';
  static const String galleryPicker = '/onboarding/wardrobe/gallery';
  static const String aiTagging = '/onboarding/wardrobe/tagging';
  static const String tagEditing = '/onboarding/wardrobe/edit';
  static const String itemSaved = '/onboarding/wardrobe/saved';

  // Onboarding - Preferences
  static const String preferences = '/onboarding/preferences';

  // Onboarding - Summary
  static const String summary = '/onboarding/summary';
  static const String termsOfService = '/onboarding/terms';
  static const String privacyPolicy = '/onboarding/privacy';
  static const String reviewSetup = '/onboarding/review';
  static const String successCelebration = '/onboarding/success';

  // Main App
  static const String home = '/home';
}

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Handle auth-based redirects here if needed
      return null;
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.signupLoading,
        builder: (context, state) => SignupLoadingScreen(
          provider: state.extra as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.emailSignup,
        builder: (context, state) => const EmailSignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileConfirm,
        builder: (context, state) => const ProfileConfirmScreen(),
      ),

      // Permissions
      GoRoute(
        path: AppRoutes.permissions,
        builder: (context, state) => const PermissionsScreen(),
      ),

      // Measurements
      GoRoute(
        path: AppRoutes.measurementSetup,
        builder: (context, state) => const MeasurementSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.manualEntry,
        builder: (context, state) => const ManualEntryScreen(),
      ),
      GoRoute(
        path: AppRoutes.importMeasurements,
        builder: (context, state) => const ImportMeasurementsScreen(),
      ),
      GoRoute(
        path: AppRoutes.cameraMeasure,
        builder: (context, state) => const CameraMeasureScreen(),
      ),
      GoRoute(
        path: AppRoutes.measurementProcessing,
        builder: (context, state) => MeasurementProcessingScreen(
          imagePath: state.extra as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.measurementsSaved,
        builder: (context, state) => const MeasurementsSavedScreen(),
      ),

      // Wardrobe Intake
      GoRoute(
        path: AppRoutes.wardrobeIntake,
        builder: (context, state) => const WardrobeIntakeScreen(),
      ),
      GoRoute(
        path: AppRoutes.cameraCapture,
        builder: (context, state) => const CameraCaptureScreen(),
      ),
      GoRoute(
        path: AppRoutes.galleryPicker,
        builder: (context, state) => const GalleryPickerScreen(),
      ),
      GoRoute(
        path: AppRoutes.aiTagging,
        builder: (context, state) => AiTaggingScreen(
          imagePath: state.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.tagEditing,
        builder: (context, state) => TagEditingScreen(
          imagePath: (state.extra as Map<String, dynamic>)['imagePath'] as String,
          detectedTags: (state.extra as Map<String, dynamic>)['tags'] as Map<String, dynamic>?,
        ),
      ),
      GoRoute(
        path: AppRoutes.itemSaved,
        builder: (context, state) => const ItemSavedScreen(),
      ),

      // Preferences
      GoRoute(
        path: AppRoutes.preferences,
        builder: (context, state) => const PreferencesScreen(),
      ),

      // Summary
      GoRoute(
        path: AppRoutes.summary,
        builder: (context, state) => const SummaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.termsOfService,
        builder: (context, state) => const TermsOfServiceScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.reviewSetup,
        builder: (context, state) => const ReviewSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.successCelebration,
        builder: (context, state) => const SuccessCelebrationScreen(),
      ),

      // Home
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});
