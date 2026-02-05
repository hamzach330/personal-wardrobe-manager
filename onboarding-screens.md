# Onboarding Flow – Screen Specs

Use these specs when designing the onboarding screens. Each section includes layout, content, interactions, sub-flows, and notes.

**Stitch Project ID:** `12877963741463217078`  
**Total Screens:** 30 (8 main + 22 sub-flows)  
**Assets Location:** `StichDesign/screenshots/`

---

## Screen 0 – Animated Splash Screen
- **Purpose**: Brand introduction while app loads.
- **Logo**: Centered wardrobe/hanger icon in purple (#6750A4) with shimmer effect.
- **App Name**: "Wardrobe" in elegant serif, "Agent" as sans-serif subtitle.
- **Background**: Soft gradient from white to light lavender (#F5F0FF).
- **Decorations**: Floating clothing silhouettes in translucent grey.
- **Loading**: Thin purple progress bar at bottom.
- **Animation Sequence**:
  1. Logo fades in and scales up (0.3s)
  2. Shimmer effect pulses (0.5s)
  3. App name fades in (0.3s delay)
  4. Progress bar completes → transition to Screen 1

---

## Screen 1 – Welcome & Value Proposition
- **Goal**: Hook the user, set expectations, drive "Get Started".
- **Hero**: Title "Meet your Personal Wardrobe Agent", subtitle describing the 3 pillars (Organize wardrobe, Smart outfits, Confident shopping).
- **Illustration**: Stylish hero art centered above CTA (full-bleed gradient with wardrobe elements).
- **Primary CTA**: `Get Started` → Screen 1B
- **Secondary**: Text link `Sign in` → auth flow
- **Footer**: Privacy note "By continuing you agree to Terms & Privacy".

---

## Screen 1B – Social Sign Up *(NEW)*
- **Goal**: Capture user identity with minimal friction.
- **Headline**: "Create your account"
- **Subtitle**: "Sign up to save your wardrobe and get personalized recommendations"
- **Social Buttons** (stacked):
  1. `Continue with Google` – white background, Google icon
  2. `Continue with Facebook` – Facebook blue (#1877F2)
  3. `Continue with Apple` – black background, Apple icon
- **Divider**: "or" separator
- **Email Option**: `Sign up with email` outlined button
- **Privacy Note**: "We'll only use your name and profile picture to personalize your experience"
- **Footer**: "Already have an account? Sign in"

### Sub-Flows:

#### 1B-A: Sign Up Loading State
- Centered purple spinner
- Text: "Signing you in..."
- Generic social icon above

#### 1B-B: Email Sign Up Form
- Back arrow navigation
- Form fields: Full Name, Email, Password, Confirm Password
- Password hint: "At least 8 characters"
- CTA: `Create Account`
- Footer: "Already have an account? Sign in"

#### 1B-C: Profile Confirmation
- Success checkmark animation
- Large circular profile photo (from social account)
- "Welcome, [Name]!" with email below
- "Is this you?" prompt
- Primary: `Yes, continue` → Screen 2
- Secondary: `Use different account`

---

## Screen 2 – Data & Permissions Overview
- **Headline**: "What we'll need to personalize your agent"
- **Stacked Cards** (3):
  1. **Measurements** – body icon – "Your body measurements for perfect fit recommendations"
  2. **Wardrobe Photos** – camera icon – "Photos of your clothes to build your digital closet"
  3. **Location & Weather** – location pin – "Your location for weather-appropriate outfit suggestions"
- Each card has toggle switch (purple when ON)
- **CTA**: `Continue` (enabled when toggles ON)
- **Details link**: "Why we ask for this"
- **Interaction**: Allow skip with reduced personalization warning

### Sub-Flows:

#### 2-A: Permission Denied Warning
- Amber warning icon
- Title: "Some features will be limited"
- Bullet list of impact per denied permission
- Card showing denied items with ✗ marks
- Primary: `Enable permissions`
- Secondary: `Continue anyway`
- Note: "You can enable these later in Settings"

#### 2-B: Camera Permission Dialog
- iOS system dialog overlay
- App icon + "Wardrobe Agent Would Like to Access the Camera"
- Description explaining photo capture purpose
- Buttons: `Don't Allow` | `Allow`

#### 2-C: Location Permission Dialog
- iOS system dialog overlay
- "Allow Wardrobe Agent to use your location?"
- Weather-based outfit explanation
- Buttons: `Allow Once` | `Allow While Using App` | `Don't Allow`

---

## Screen 3 – Measurement Setup
- **Title**: "Let's capture your fit"
- **Supporting text**: "Accurate measurements unlock perfect-fit shopping suggestions."
- **Option Cards** (3 horizontal):
  1. **Manual Entry** – keyboard icon – "Enter sizes yourself"
  2. **Import Sizes** – import icon – "From Apple Wallet or receipts"
  3. **Camera Measure** – camera icon – "Guided measurement session"
- **CTA**: `Start measurement`
- **Secondary**: "Skip for now" (with accuracy warning)

### Sub-Flows:

#### 3-A: Manual Entry Form
- Back arrow + "Enter your measurements"
- Body silhouette illustration with measurement points
- Scrollable form fields with +/- steppers:
  - Height (cm/ft toggle)
  - Weight (kg/lbs toggle)
  - Chest/Bust, Waist, Hips
  - Shoulder width, Arm length, Inseam
- "How to measure" help links
- CTA: `Save measurements`

#### 3-B: Import Measurements
- Title: "Import your sizes"
- Source cards:
  1. Apple Health/Wallet – height/weight sync
  2. Email Receipts – scan order confirmations
- "Connected accounts" section
- Privacy badge: "Your data stays on device"
- CTA: `Start import`

#### 3-C: Camera Guided Measurement (Step 1)
- Progress: Step 1 of 4
- Title: "Full body photo"
- Camera viewfinder with body outline overlay
- Distance indicator: "Stand 6 feet away"
- Level indicator for phone alignment
- Tips: "Wear fitted clothing for accuracy"
- Large capture button

#### 3-D: Measurement Processing
- Title: "Analyzing your measurements"
- Circular progress (75%) with body scan animation
- Status checklist:
  - ✓ Detecting body landmarks
  - ✓ Calculating proportions
  - ⟳ Generating measurements (in progress)
- "Almost done..." status

#### 3-E: Skip Measurement Warning
- Bottom sheet dialog
- Amber info icon
- Title: "Skip measurements?"
- Impact list (fit recommendations, size filtering, sizing alerts)
- Primary: `Add measurements`
- Secondary: `Skip anyway`

#### 3-F: Measurements Saved Success
- Confetti + checkmark animation
- "Measurements saved!"
- Summary card (Height, Chest, Waist, Hips)
- CTA: `Continue` → Screen 4
- Secondary: "Edit measurements"

---

## Screen 4 – Wardrobe Intake Intro
- **Stepper illustration** (3 steps): "Snap item → Tag details → Save to wardrobe"
- **Content**: "Our AI auto-tags colors, categories, and occasions. You'll get smart outfit combinations in seconds."
- **CTA**: `Add first item` → Camera capture
- **Secondary**: `Import from gallery` → Gallery picker
- **Info pill**: "You can add items later from the Home tab."

### Sub-Flows:

#### 4-A: Camera Capture
- Dark camera interface
- Rectangular clothing frame guide overlay
- Tip: "Lay item flat on a plain surface"
- Flash toggle (top left), Switch camera (top right)
- Gallery thumbnail (bottom left)
- Large circular capture button
- Helper: "Good lighting helps with color detection"

#### 4-B: Gallery Picker
- Title bar: "Select photos" with Cancel/Done(n)
- Tabs: All Photos | Recents | Albums
- Filter pill: "Clothing detected" (AI-filtered)
- 3-column photo grid
- Selected photos show purple checkmark + number
- Bottom bar: "n items selected"

#### 4-C: AI Tagging in Progress
- Clothing photo with scanning animation overlay
- "Analyzing your item..."
- Progress checklist:
  - ✓ Detecting garment type
  - ✓ Identifying color palette
  - ⟳ Recognizing brand/style
  - ○ Suggesting occasions
- Circular progress indicator
- Cancel option

#### 4-D: Tag Editing
- Back arrow + "Edit item details"
- Large item photo
- AI-detected tags as editable chips:
  - Category: dropdown (Shirt, Pants, etc.)
  - Color: color chip (Navy Blue)
  - Brand: text input
  - Season: multi-select chips
  - Occasions: multi-select (Work, Casual, etc.)
  - Fit: dropdown
- `+ Add custom tag` button
- Notes text area
- CTA: `Save to wardrobe`
- Secondary: `Retake photo`

#### 4-E: Item Saved Success
- Checkmark + confetti
- "Item saved!"
- Preview card of saved item
- "What's next?" section:
  1. `Add another item` (outlined)
  2. `Continue setup` (filled purple) → Screen 5
- Progress: "You have n items in your wardrobe"

---

## Screen 5 – Preferences & Routine
- **Headline**: "Dial in your style"
- **Chip Categories**:
  - **Style Vibes**: Minimal, Street, Business, Casual, Bold
  - **Fit Priorities**: Comfort, Tailored, Sustainable, Trendy
  - **Occasions**: Work, Weekend, Formal, Travel
- Selected chips: purple filled; Unselected: outlined
- **Toggle**: "Send daily outfit reminders at 7 AM"
- **CTA**: `Next` → Screen 6
- **Helper**: "Select at least one from each category. You can edit later."
- **Interaction**: Require at least one chip per category to proceed

---

## Screen 6 – Summary & Consent
- **Headline**: "You're all set!"
- **Summary Card**:
  - Measurements ✅
  - Wardrobe items: n
  - Preferences: Set ✅
  - Daily reminders: On/Off
- **Copy**: "Here's what we'll store and how we'll use it."
- **Links**: Terms of Service, Privacy Policy
- **CTA**: `Finish setup` → Success celebration
- **Secondary**: `Review steps` → Review screen

### Sub-Flows:

#### 6-A: Terms of Service
- Back arrow + "Terms of Service"
- Last updated: February 2026
- Scrollable sections (1-8): Acceptance, Service Description, Responsibilities, Privacy, IP, Liability, Termination, Contact
- Share/Print icon
- Sticky footer: `I agree` (active after scroll)

#### 6-B: Privacy Policy
- Back arrow + "Privacy Policy"
- Effective date
- Sections with icons:
  - What We Collect
  - How We Use Your Data
  - Data Storage & Security
  - Third-Party Services
  - Your Rights & Choices
  - Data Retention
  - Contact Us
- Highlight box: "Your photos never leave your device" (shield icon)
- Link: "Download my data"

#### 6-C: Review Your Setup
- Title: "Review your setup"
- Progress: "Setup 80% complete"
- Editable cards:
  1. Profile (photo, name, email) – Edit
  2. Measurements (stats) – Edit
  3. Wardrobe (item count) – Add more
  4. Preferences (style chips) – Edit
  5. Notifications (reminder time) – Toggle
- CTA: `Finish setup`
- Secondary: `Save and exit`

#### 6-D: Success Celebration
- Full-screen confetti burst
- Animated purple checkmark
- "You're all set!"
- "Your personal wardrobe agent is ready"
- User profile photo
- Stat: "Ready to style your n items"
- Floating clothing icons animation
- CTA: `Go to my wardrobe` → Home Dashboard
- Note: "We'll send your first outfit suggestion tomorrow at 7 AM"

#### 6-E: Home Dashboard (Destination)
- Greeting: "Good morning, [Name]!" + weather badge
- **Today's Outfit** card: AI-suggested combination with `Wear this` / `Shuffle`
- **Quick Stats**: Items | Outfits | Worn today
- **Your Wardrobe**: Horizontal scroll of thumbnails + Add item card
- **Style Tips**: AI insight card
- **Bottom Nav**: Home (active), Closet, Outfits, Shop, Profile
- **FAB**: "+ Add item"

---

## Layout & Visual Guidance

- **Theme**: Material 3 Light
- **Font**: Plus Jakarta Sans
- **Colors**:
  - Background: #FFFFFF
  - Text: #1D1B20
  - Accent/Primary: #6750A4
  - Secondary: #F5F0FF (light lavender)
- **Spacing**: 16px horizontal padding
- **Typography**: display-small, title-medium, body-large
- **Device**: Mobile (iOS), 780 × 1768 px (2x scale)
- **Roundness**: 12px corners (cards, buttons)

---

## Complete Prototype Flow

```
SPLASH (0)
    │
    ▼
WELCOME (1) ──► Get Started
    │
    ▼
SOCIAL SIGN UP (1B)
    ├─► Google/Facebook/Apple ──► Loading (1B-A) ──► Profile Confirm (1B-C)
    └─► Email ──► Email Form (1B-B) ──► Profile Confirm (1B-C)
    │
    ▼
PERMISSIONS (2)
    ├─► Toggles ON ──► Camera Dialog (2-B) ──► Location Dialog (2-C) ──► Continue
    └─► Skip ──► Permission Warning (2-A) ──► Continue anyway
    │
    ▼
MEASUREMENT SETUP (3)
    ├─► Manual ──► Form (3-A) ──► Success (3-F)
    ├─► Import ──► Import Screen (3-B) ──► Success (3-F)
    ├─► Camera ──► Capture (3-C) ──► Processing (3-D) ──► Success (3-F)
    └─► Skip ──► Warning (3-E) ──► Continue
    │
    ▼
WARDROBE INTAKE (4)
    ├─► Add Item ──► Camera (4-A) ──► AI Tagging (4-C) ──► Tag Edit (4-D) ──► Saved (4-E)
    └─► Import ──► Gallery (4-B) ──► AI Tagging (4-C) ──► Tag Edit (4-D) ──► Saved (4-E)
    │
    ▼
PREFERENCES (5) ──► Select chips + Toggle ──► Next
    │
    ▼
SUMMARY (6)
    ├─► Terms of Service (6-A)
    ├─► Privacy Policy (6-B)
    ├─► Review Steps (6-C) ──► Edit sections
    └─► Finish Setup ──► Success (6-D) ──► Home Dashboard (6-E)
```

---

## Asset Files Reference

| Screen | Main File | Sub-Flow Files |
|--------|-----------|----------------|
| Splash | `00-splash-screen.png` | — |
| Welcome | `01-welcome-value-proposition.png` | — |
| Sign Up | `01B-social-signup.png` | `01B-a-signup-loading.png`, `01B-b-email-signup-form.png`, `01B-c-profile-confirm.png` |
| Permissions | `02-data-permissions.png` | `02-a-permission-denied.png`, `02-b-camera-permission-dialog.png`, `02-c-location-permission-dialog.png` |
| Measurements | `03-measurement-setup.png` | `03-a-manual-entry-form.png`, `03-b-import-measurements.png`, `03-c-camera-measure-step1.png`, `03-d-measurement-processing.png`, `03-e-skip-warning.png`, `03-f-measurements-saved.png` |
| Wardrobe | `04-wardrobe-intake.png` | `04-a-camera-capture.png`, `04-b-gallery-picker.png`, `04-c-ai-tagging-progress.png`, `04-d-tag-editing.png`, `04-e-item-saved.png` |
| Preferences | `05-style-preferences.png` | — |
| Summary | `06-summary-consent.png` | `06-a-terms-of-service.png`, `06-b-privacy-policy.png`, `06-c-review-setup.png`, `06-d-success-celebration.png`, `06-e-home-dashboard.png` |

---

Use this doc as the reference while implementing the onboarding flow. All designs are available in the `StichDesign/` folder.
