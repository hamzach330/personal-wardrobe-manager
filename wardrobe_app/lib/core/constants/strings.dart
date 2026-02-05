/// App string constants for consistent text throughout the app
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Wardrobe Agent';
  static const String appTagline = 'Your Personal Wardrobe Assistant';

  // Welcome Screen
  static const String welcomeTitle = 'Meet your Personal Wardrobe Agent';
  static const String welcomeSubtitle =
      'Organize your wardrobe, get smart outfit suggestions, and shop with confidence.';
  static const String getStarted = 'Get Started';
  static const String signIn = 'Sign in';
  static const String termsFooter = 'By continuing you agree to Terms & Privacy';

  // Sign Up Screen
  static const String createAccount = 'Create your account';
  static const String signUpSubtitle =
      'Sign up to save your wardrobe and get personalized recommendations';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String continueWithApple = 'Continue with Apple';
  static const String signUpWithEmail = 'Sign up with email';
  static const String orDivider = 'or';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String privacyNote =
      'We\'ll only use your name and profile picture to personalize your experience';

  // Email Sign Up
  static const String fullName = 'Full Name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String passwordHint = 'At least 8 characters';
  static const String createAccountButton = 'Create Account';

  // Profile Confirm
  static const String welcomeUser = 'Welcome, ';
  static const String isThisYou = 'Is this you?';
  static const String yesContinue = 'Yes, continue';
  static const String useDifferentAccount = 'Use different account';

  // Permissions Screen
  static const String permissionsTitle = 'What we\'ll need to personalize your agent';
  static const String measurementsPermission = 'Measurements';
  static const String measurementsDescription =
      'Your body measurements for perfect fit recommendations';
  static const String photosPermission = 'Wardrobe Photos';
  static const String photosDescription =
      'Photos of your clothes to build your digital closet';
  static const String locationPermission = 'Location & Weather';
  static const String locationDescription =
      'Your location for weather-appropriate outfit suggestions';
  static const String continueButton = 'Continue';
  static const String whyWeAsk = 'Why we ask for this';

  // Permission Denied Warning
  static const String featuresLimited = 'Some features will be limited';
  static const String enablePermissions = 'Enable permissions';
  static const String continueAnyway = 'Continue anyway';
  static const String enableLaterNote = 'You can enable these later in Settings';

  // Measurement Setup
  static const String measurementTitle = 'Let\'s capture your fit';
  static const String measurementSubtitle =
      'Accurate measurements unlock perfect-fit shopping suggestions.';
  static const String manualEntry = 'Manual Entry';
  static const String manualEntryDescription = 'Enter sizes yourself';
  static const String importSizes = 'Import Sizes';
  static const String importDescription = 'From Apple Wallet or receipts';
  static const String cameraMeasure = 'Camera Measure';
  static const String cameraDescription = 'Guided measurement session';
  static const String startMeasurement = 'Start measurement';
  static const String skipForNow = 'Skip for now';

  // Manual Entry Form
  static const String enterMeasurements = 'Enter your measurements';
  static const String height = 'Height';
  static const String weight = 'Weight';
  static const String chest = 'Chest/Bust';
  static const String waist = 'Waist';
  static const String hips = 'Hips';
  static const String shoulderWidth = 'Shoulder width';
  static const String armLength = 'Arm length';
  static const String inseam = 'Inseam';
  static const String howToMeasure = 'How to measure';
  static const String saveMeasurements = 'Save measurements';

  // Camera Measurement
  static const String fullBodyPhoto = 'Full body photo';
  static const String standDistance = 'Stand 6 feet away';
  static const String wearFittedClothing = 'Wear fitted clothing for accuracy';
  static const String analyzingMeasurements = 'Analyzing your measurements';
  static const String almostDone = 'Almost done...';
  static const String detectingLandmarks = 'Detecting body landmarks';
  static const String calculatingProportions = 'Calculating proportions';
  static const String generatingMeasurements = 'Generating measurements';

  // Skip Warning
  static const String skipMeasurementsTitle = 'Skip measurements?';
  static const String skipMeasurementsImpact =
      'Without measurements, you\'ll miss out on fit recommendations, size filtering, and sizing alerts.';
  static const String addMeasurements = 'Add measurements';
  static const String skipAnyway = 'Skip anyway';

  // Measurements Saved
  static const String measurementsSaved = 'Measurements saved!';
  static const String editMeasurements = 'Edit measurements';

  // Wardrobe Intake
  static const String wardrobeIntroTitle = 'Build your digital closet';
  static const String wardrobeIntroStep1 = 'Snap item';
  static const String wardrobeIntroStep2 = 'Tag details';
  static const String wardrobeIntroStep3 = 'Save to wardrobe';
  static const String wardrobeIntroContent =
      'Our AI auto-tags colors, categories, and occasions. You\'ll get smart outfit combinations in seconds.';
  static const String addFirstItem = 'Add first item';
  static const String importFromGallery = 'Import from gallery';
  static const String addLaterNote = 'You can add items later from the Home tab.';

  // Camera Capture
  static const String layItemFlat = 'Lay item flat on a plain surface';
  static const String goodLightingHelps = 'Good lighting helps with color detection';

  // Gallery Picker
  static const String selectPhotos = 'Select photos';
  static const String allPhotos = 'All Photos';
  static const String recents = 'Recents';
  static const String albums = 'Albums';
  static const String clothingDetected = 'Clothing detected';
  static const String itemsSelected = 'items selected';

  // AI Tagging
  static const String analyzingItem = 'Analyzing your item...';
  static const String detectingGarment = 'Detecting garment type';
  static const String identifyingColor = 'Identifying color palette';
  static const String recognizingBrand = 'Recognizing brand/style';
  static const String suggestingOccasions = 'Suggesting occasions';

  // Tag Editing
  static const String editItemDetails = 'Edit item details';
  static const String category = 'Category';
  static const String color = 'Color';
  static const String brand = 'Brand';
  static const String season = 'Season';
  static const String occasions = 'Occasions';
  static const String fit = 'Fit';
  static const String addCustomTag = '+ Add custom tag';
  static const String notes = 'Notes';
  static const String saveToWardrobe = 'Save to wardrobe';
  static const String retakePhoto = 'Retake photo';

  // Item Saved
  static const String itemSaved = 'Item saved!';
  static const String whatsNext = 'What\'s next?';
  static const String addAnotherItem = 'Add another item';
  static const String continueSetup = 'Continue setup';
  static const String itemsInWardrobe = 'items in your wardrobe';

  // Preferences Screen
  static const String preferencesTitle = 'Dial in your style';
  static const String styleVibes = 'Style Vibes';
  static const String fitPriorities = 'Fit Priorities';
  static const String occasionsLabel = 'Occasions';
  static const String dailyReminder = 'Send daily outfit reminders at 7 AM';
  static const String next = 'Next';
  static const String selectAtLeastOne =
      'Select at least one from each category. You can edit later.';

  // Style Vibes Options
  static const String minimal = 'Minimal';
  static const String street = 'Street';
  static const String business = 'Business';
  static const String casual = 'Casual';
  static const String bold = 'Bold';

  // Fit Priorities Options
  static const String comfort = 'Comfort';
  static const String tailored = 'Tailored';
  static const String sustainable = 'Sustainable';
  static const String trendy = 'Trendy';

  // Occasions Options
  static const String work = 'Work';
  static const String weekend = 'Weekend';
  static const String formal = 'Formal';
  static const String travel = 'Travel';

  // Summary Screen
  static const String summaryTitle = 'You\'re all set!';
  static const String reviewSetupSubtitle = 'Review your setup before finishing.';
  static const String measurements = 'Measurements';
  static const String wardrobeItems = 'Wardrobe items';
  static const String preferences = 'Preferences';
  static const String dailyReminders = 'Daily reminders';
  static const String set = 'Set';
  static const String on = 'On';
  static const String off = 'Off';
  static const String readyToAdd = 'ready to add';
  static const String dataStorageConsent =
      'Here\'s what we\'ll store and how we\'ll use it';
  static const String agreeToPolicy =
      'By tapping Finish setup, you agree to our policies regarding data storage and usage.';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String finishSetup = 'Finish setup';
  static const String reviewSteps = 'Review steps';

  // Success Celebration
  static const String youreAllSet = 'You\'re all set!';
  static const String agentReady = 'Your personal wardrobe agent is ready';
  static const String readyToStyle = 'Ready to style your';
  static const String items = 'items';
  static const String goToWardrobe = 'Go to my wardrobe';
  static const String firstOutfitNote =
      'We\'ll send your first outfit suggestion tomorrow at 7 AM';

  // Home Dashboard
  static const String goodMorning = 'Good morning';
  static const String goodAfternoon = 'Good afternoon';
  static const String goodEvening = 'Good evening';
  static const String todaysOutfit = 'Today\'s Outfit';
  static const String wearThis = 'Wear this';
  static const String shuffle = 'Shuffle';
  static const String yourWardrobe = 'Your Wardrobe';
  static const String styleTips = 'Style Tips';
  static const String addItem = 'Add item';

  // Bottom Navigation
  static const String home = 'Home';
  static const String closet = 'Closet';
  static const String outfits = 'Outfits';
  static const String shop = 'Shop';
  static const String profile = 'Profile';

  // Error Messages
  static const String somethingWentWrong = 'Something went wrong';
  static const String tryAgain = 'Try again';
  static const String noInternetConnection = 'No internet connection';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String requiredField = 'This field is required';

  // Loading States
  static const String loading = 'Loading...';
  static const String signingIn = 'Signing you in...';
  static const String saving = 'Saving...';
  static const String processing = 'Processing...';
}
