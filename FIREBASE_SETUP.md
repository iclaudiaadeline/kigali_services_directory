# Firebase Setup Instructions

## IMPORTANT: Complete These Steps Before Running the App

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: **Kigali Services Directory**
4. Accept terms and click "Continue"
5. Disable/Enable Google Analytics (your choice)
6. Click "Create project"
7. Wait for project creation, then click "Continue"

### 2. Register Android App

1. In Firebase project, click Android icon (🤖)
2. **Android package name**: `com.example.kigali_services_directory`
3. **App nickname** (optional): Kigali Services
4. Click "Register app"
5. **Download `google-services.json`**
6. Place the file in: `android/app/google-services.json`
7. Click "Next" through the remaining steps
8. Click "Continue to console"

### 3. Register iOS App

1. In Firebase project, click iOS icon (🍎)
2. **iOS bundle ID**: `com.example.kigaliServicesDirectory`
3. **App nickname** (optional): Kigali Services
4. Click "Register app"
5. **Download `GoogleService-Info.plist`**
6. Place the file in: `ios/Runner/GoogleService-Info.plist`
7. Click "Next" through the remaining steps
8. Click "Continue to console"

### 4. Enable Firebase Authentication

1. In Firebase Console, click "Authentication" in left sidebar
2. Click "Get started"
3. Click "Sign-in method" tab
4. Click "Email/Password"
5. **Enable** the first toggle (Email/Password)
6. **Enable** "Email link (passwordless sign-in)" if desired
7. Click "Save"

### 5. Create Firestore Database

1. In Firebase Console, click "Firestore Database" in left sidebar
2. Click "Create database"
3. **Start in test mode** (we'll add security rules later)
4. Select location: **Choose closest to Rwanda** (e.g., europe-west1)
5. Click "Enable"

### 6. Add Firestore Security Rules

1. In Firestore Database, click "Rules" tab
2. Replace the existing rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Listings collection
    match /listings/{listingId} {
      // Anyone authenticated can read
      allow read: if request.auth != null;
      
      // Only authenticated users can create, and they must set their own UID as createdBy
      allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.createdBy;
      
      // Only the creator can update or delete
      allow update, delete: if request.auth != null && 
                              request.auth.uid == resource.data.createdBy;
    }
  }
}
```

3. Click "Publish"

### 7. Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project or create new one
3. Click "APIs & Services" > "Library"
4. Search and enable:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Directions API
5. Click "Credentials" in left sidebar
6. Click "Create Credentials" > "API Key"
7. **Copy the API key**
8. Click "Restrict Key" (recommended):
   - Application restrictions: Set to Android/iOS apps
   - API restrictions: Select the 3 APIs above
9. Click "Save"

### 8. Add Google Maps Key to App

#### Android
Edit `android/app/src/main/AndroidManifest.xml`:
- Find `YOUR_GOOGLE_MAPS_API_KEY_HERE`
- Replace with your actual API key

#### iOS
Edit `ios/Runner/AppDelegate.swift`:
- Find `YOUR_GOOGLE_MAPS_API_KEY_HERE`
- Replace with your actual API key

### 9. Verify Setup

Run these checks before building:

```bash
# Check that Firebase config files exist
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist

# Get Flutter packages
flutter pub get

# Run the app
flutter run
```

### Troubleshooting

**"google-services.json not found"**
- Ensure file is in `android/app/` directory
- File name must be exactly `google-services.json`

**"Firebase app not initialized"**
- Ensure Firebase config files are in correct locations
- Clean and rebuild: `flutter clean && flutter pub get`

**"Execution failed for task ':app:processDebugGoogleServices'"**
- Verify `google-services.json` is valid JSON
- Re-download from Firebase Console

**Google Maps not showing**
- Verify API key is correct in both AndroidManifest.xml and AppDelegate.swift
- Ensure Maps SDK is enabled in Google Cloud Console
- Check that API key restrictions allow your app

**Location permission denied**
- On Android: Check AndroidManifest.xml has location permissions
- On iOS: Check Info.plist has location usage descriptions
- Grant permissions manually in device settings

### Need Help?

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Google Maps Flutter Plugin](https://pub.dev/packages/google_maps_flutter)
