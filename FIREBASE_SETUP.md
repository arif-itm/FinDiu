# Firebase Setup Instructions for FinDiu

## Prerequisites
- Flutter SDK installed
- Firebase CLI installed (`npm install -g firebase-tools`)
- Google account for Firebase Console

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create a project"
3. Project name: `findiu-2025` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Enable Authentication

1. In Firebase Console, go to Authentication
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable the following providers:
   - **Email/Password**: Enable this provider
   - **Google**: Enable this provider
     - Add your project's OAuth 2.0 client IDs
     - For Android: You'll need the SHA-1 fingerprint

## Step 3: Create Firestore Database

1. In Firebase Console, go to Firestore Database
2. Click "Create database"
3. **Start in test mode** (for development)
4. Choose a location (preferably closest to your users)
5. Click "Done"

## Step 4: Configure Firebase for Flutter

### Web Configuration
1. In Firebase Console, go to Project Settings
2. Click "Add app" → Web
3. App nickname: `FinDiu Web`
4. Copy the configuration object
5. Replace the values in `lib/firebase_options.dart` (web section)

### Android Configuration
1. In Firebase Console, go to Project Settings
2. Click "Add app" → Android
3. Android package name: `com.findiu.app` (or your package name)
4. App nickname: `FinDiu Android`
5. Download `google-services.json`
6. Place it in `android/app/`
7. Replace the values in `lib/firebase_options.dart` (android section)

### iOS Configuration
1. In Firebase Console, go to Project Settings
2. Click "Add app" → iOS
3. iOS bundle ID: `com.findiu.app` (or your bundle ID)
4. App nickname: `FinDiu iOS`
5. Download `GoogleService-Info.plist`
6. Place it in `ios/Runner/`
7. Replace the values in `lib/firebase_options.dart` (ios section)

## Step 5: Get Android SHA-1 Fingerprint (for Google Sign-in)

```bash
# For debug builds
cd android
./gradlew signingReport

# Copy the SHA1 from the debug key
# Add it to Firebase Console → Project Settings → Your Android app → SHA certificate fingerprints
```

## Step 6: Configure Gemini AI

1. Go to [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Create a new API key
3. Copy the API key
4. Replace `YOUR_GEMINI_API_KEY` in:
   - `lib/config/app_config.dart`
   - `lib/services/gemini_service.dart`

## Step 7: Update Configuration Files

### Update firebase_options.dart
Replace all `YOUR_*` placeholders with actual values from Firebase Console.

### Update app_config.dart
```dart
static const String firebaseProjectId = 'your-actual-project-id';
static const String geminiApiKey = 'your-actual-gemini-api-key';
```

## Step 8: Deploy Firestore Security Rules

```bash
firebase deploy --only firestore:rules
```

## Step 9: Test the Setup

```bash
flutter run
```

## Production Deployment

### Update Firestore Rules for Production
1. Replace the test rules in `firestore.rules` with production rules
2. Deploy: `firebase deploy --only firestore:rules`

### Environment Configuration
```dart
// In app_config.dart
static const bool isDevelopment = false; // Set to false for production
```

## Security Checklist

- [ ] Firestore rules restrict access to authenticated users only
- [ ] API keys are properly configured
- [ ] SHA-1 fingerprints added for Android
- [ ] Google Sign-in properly configured
- [ ] Production rules deployed
- [ ] Test all authentication flows

## Troubleshooting

### Common Issues:

1. **Google Sign-in not working on Android**
   - Ensure SHA-1 fingerprint is added to Firebase Console
   - Check that package name matches exactly

2. **Firestore permission denied**
   - Check that Firestore rules allow access for authenticated users
   - Ensure user is properly authenticated

3. **API key issues**
   - Verify API keys are correct and not expired
   - Check that APIs are enabled in Google Cloud Console

### Debug Commands:
```bash
# Check Firebase project
firebase projects:list

# Check current project
firebase use

# Test Firestore rules
firebase firestore:rules:test
```

## Support

For issues with this setup, please check:
1. [Firebase Documentation](https://firebase.google.com/docs)
2. [FlutterFire Documentation](https://firebase.flutter.dev)
3. Project issues or contact support
