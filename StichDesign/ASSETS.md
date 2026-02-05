# Personal Wardrobe Manager - Design Assets

**Stitch Project ID:** `12877963741463217078`  
**Project Title:** Personal Wardrobe Manager - Onboarding  
**Generated:** February 5, 2026

---

## Logo

| File | Description |
|------|-------------|
| `wardrobe-manager-logo.png` | App icon with hanger + wardrobe design in purple gradient |

---

## Screen Screenshots

| File | Screen | Description |
|------|--------|-------------|
| `screenshots/00-splash-screen.png` | Splash Screen | Animated splash with logo, app name, and loading indicator |
| `screenshots/01-welcome-value-proposition.png` | Screen 1 | Welcome hero with "Meet your Personal Wardrobe Agent" |
| `screenshots/01B-social-signup.png` | Screen 1B | Social sign-up with Google, Facebook, Apple options |
| `screenshots/02-data-permissions.png` | Screen 2 | Permissions overview (Measurements, Photos, Location) |
| `screenshots/03-measurement-setup.png` | Screen 3 | Measurement method selection (Manual, Import, Camera) |
| `screenshots/04-wardrobe-intake.png` | Screen 4 | Wardrobe intake intro with 3-step process |
| `screenshots/05-style-preferences.png` | Screen 5 | Style preferences with chips and reminder toggle |
| `screenshots/06-summary-consent.png` | Screen 6 | Setup summary with consent and finish CTA |

---

## HTML Code

Each screen has a corresponding HTML file that can be used for development reference or preview:

| File | Screen |
|------|--------|
| `html/00-splash-screen.html` | Splash Screen |
| `html/01-welcome-value-proposition.html` | Welcome & Value Proposition |
| `html/01B-social-signup.html` | Social Sign Up |
| `html/02-data-permissions.html` | Data & Permissions Overview |
| `html/03-measurement-setup.html` | Measurement Setup |
| `html/04-wardrobe-intake.html` | Wardrobe Intake Intro |
| `html/05-style-preferences.html` | Style Preferences & Routine |
| `html/06-summary-consent.html` | Summary & Consent |

---

## Design System

- **Theme:** Material 3 Light
- **Font:** Plus Jakarta Sans
- **Primary Color:** `#6750A4` (Purple)
- **Background:** `#FFFFFF` (White)
- **Text:** `#1D1B20` (Dark)
- **Device:** Mobile (iOS)
- **Dimensions:** 780 × 1768 px (2x scale)

---

## Prototype Flow

```
Splash → Screen 1 (Welcome) → Screen 1B (Sign Up) → Screen 2 (Permissions) → Screen 3 → Screen 4 → Screen 5 → Screen 6 → Home
```

---

## Sub-Flow Screens

Detailed sub-screens for each parent screen, organized below their parent in Stitch:

### Screen 1B (Social Sign Up) Sub-Flows

| File | Sub-Screen | Description |
|------|------------|-------------|
| `screenshots/subflows/01B-a-signup-loading.png` | Loading State | Spinner shown during social auth |
| `screenshots/subflows/01B-b-email-signup-form.png` | Email Form | Name, email, password registration |
| `screenshots/subflows/01B-c-profile-confirm.png` | Profile Confirm | "Is this you?" confirmation |

### Screen 2 (Permissions) Sub-Flows

| File | Sub-Screen | Description |
|------|------------|-------------|
| `screenshots/subflows/02-a-permission-denied.png` | Denied Warning | Warning when permissions skipped |
| `screenshots/subflows/02-b-camera-permission-dialog.png` | Camera Dialog | iOS system camera permission |
| `screenshots/subflows/02-c-location-permission-dialog.png` | Location Dialog | iOS system location permission |

### Screen 3 (Measurement Setup) Sub-Flows

| File | Sub-Screen | Description |
|------|------------|-------------|
| `screenshots/subflows/03-a-manual-entry-form.png` | Manual Entry | Body measurements input form |
| `screenshots/subflows/03-b-import-measurements.png` | Import Sizes | Apple Wallet/receipts import |
| `screenshots/subflows/03-c-camera-measure-step1.png` | Camera Guide | Full body photo capture |
| `screenshots/subflows/03-d-measurement-processing.png` | AI Processing | Body scan analysis in progress |
| `screenshots/subflows/03-e-skip-warning.png` | Skip Warning | Bottom sheet skip confirmation |
| `screenshots/subflows/03-f-measurements-saved.png` | Success | Measurements saved celebration |

### Screen 4 (Wardrobe Intake) Sub-Flows

| File | Sub-Screen | Description |
|------|------------|-------------|
| `screenshots/subflows/04-a-camera-capture.png` | Camera Capture | Clothing item photography |
| `screenshots/subflows/04-b-gallery-picker.png` | Gallery Picker | Multi-select photo import |
| `screenshots/subflows/04-c-ai-tagging-progress.png` | AI Tagging | Item analysis in progress |
| `screenshots/subflows/04-d-tag-editing.png` | Tag Editing | Review/edit AI-detected tags |
| `screenshots/subflows/04-e-item-saved.png` | Item Saved | Success with next actions |

### Screen 6 (Summary & Consent) Sub-Flows

| File | Sub-Screen | Description |
|------|------------|-------------|
| `screenshots/subflows/06-a-terms-of-service.png` | Terms of Service | Full legal document |
| `screenshots/subflows/06-b-privacy-policy.png` | Privacy Policy | Data privacy documentation |
| `screenshots/subflows/06-c-review-setup.png` | Review Steps | Editable setup summary |
| `screenshots/subflows/06-d-success-celebration.png` | Success | Confetti celebration screen |
| `screenshots/subflows/06-e-home-dashboard.png` | Home Preview | Main dashboard destination |

---

## Complete Flow Diagram

```
SPLASH SCREEN
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 1: Welcome                                                            │
│     └─► Get Started                                                          │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 1B: Social Sign Up                                                    │
│     ├─► Google/Facebook/Apple ──► Loading ──► Profile Confirm               │
│     └─► Email Sign Up ──► Email Form ──► Profile Confirm                    │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 2: Data & Permissions                                                 │
│     ├─► Toggle ON ──► Camera/Location Dialogs ──► Continue                  │
│     └─► Skip ──► Permission Denied Warning                                   │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 3: Measurement Setup                                                  │
│     ├─► Manual Entry ──► Form ──► Saved Success                             │
│     ├─► Import Sizes ──► Apple/Receipts ──► Saved Success                   │
│     ├─► Camera Measure ──► Capture ──► Processing ──► Saved Success         │
│     └─► Skip ──► Skip Warning ──► Continue                                   │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 4: Wardrobe Intake                                                    │
│     ├─► Add Item ──► Camera Capture ──► AI Tagging ──► Tag Edit ──► Saved   │
│     └─► Import Gallery ──► Gallery Picker ──► AI Tagging ──► Tag Edit       │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 5: Style Preferences                                                  │
│     └─► Select chips + Reminder toggle ──► Next                              │
└─────────────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCREEN 6: Summary & Consent                                                  │
│     ├─► Review Steps ──► Edit any section                                    │
│     ├─► Terms of Service ──► Read/Agree                                      │
│     ├─► Privacy Policy ──► Read                                              │
│     └─► Finish Setup ──► Success Celebration ──► Home Dashboard              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Total Screen Count

| Category | Count |
|----------|-------|
| Main Screens | 8 |
| Sub-Flow Screens | 22 |
| **Total** | **30 screens** |

---

## Usage

To preview HTML screens, open them in a browser. For development, use the screenshots as reference and implement the designs using the HTML structure as a guide.
