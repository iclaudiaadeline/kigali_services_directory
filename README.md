# Kigali Services Directory

A Flutter application that will guide the Kigali residents to find their ways to the key facilities in the community such as hospitals, police stations, libraries, restaurants, parks, and tourist attractions in the community.

The application is a combination of Firebase Authentication, Cloud Firestore and maps to visualize location, and follows a clean architecture and Provider state management.

##  Features


1. **Authentication**
  - Registration of email and passwords.
  - Secure login and logout
  - confirmation of emails before accessing the application.
  - Firestore User profile.

2. **Location Listings (CRUD)**
   - Add offerings of new services/places.
   - Read and browse all listings
   - Update your own listings
   - Delete your own listings
   - Real-time Firestore sync

3.**Search & Filtering**
   - Search listings by name
   - By category (Hospital, Police Station, Library, Restaurant, Café, Park, Tourist Attraction, Utility Office)
   - Dynamic real-time filtering


4.**Google Maps Integration**
   - Incorporated detail page maps.
   - Location indicators of each listing.
   - Map view of all services
   - Voice guided directions using Google Maps.
   - Current location support


5. **Navigation**
   - Bottom menu with 4 screens:
     - Directory (Search listings)
     - My Listings (Listings made by User)
     - Map View (All listings on map)
     - Settings (Profile and preferences)


6. **Settings**
   - User profile display
   - Location-based notification toggle
   - Sign out functionality

##  Architecture

### Project Structure

```
lib/
├── models/
│   ├── user_model.dart          # User data model
│   ├── listing_model.dart       # Listing data model
│   └── category.dart            # Category enum
├── services/
│   ├── auth_service.dart        # Firebase Auth operations
│   └── listing_service.dart     # Firestore CRUD operations
├── providers/
│   ├── auth_provider.dart       # Authentication state management
│   ├── listing_provider.dart    # Listings state management
│   └── settings_provider.dart   # Settings state management
├── screens/
│   ├── auth/
│   │   ├── auth_wrapper.dart
│   │   ├── sign_in_screen.dart
│   │   ├── sign_up_screen.dart
│   │   └── email_verification_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── directory/
│   │   └── directory_screen.dart
│   ├── listings/
│   │   ├── my_listings_screen.dart
│   │   ├── listing_detail_screen.dart
│   │   ├── create_listing_screen.dart
│   │   └── edit_listing_screen.dart
│   ├── map/
│   │   └── map_view_screen.dart
│   └── settings/
│       └── settings_screen.dart
├── widgets/
│   └── listing_card.dart        # Reusable listing card widget
└── main.dart                     # App entry point
```

### State Management

This application uses **Provider** for state management with a clear separation of concerns:

- **Services Layer**: Direct Firebase/Firestore operations
- **Provider Layer**: Business logic and state exposure
- **UI Layer**: Widgets that consume providers and display data

#### Flow Example (Creating a Listing):
1. User submits form in `CreateListingScreen`
2. UI calls `ListingProvider.createListing()`
3. Provider calls `ListingService.createListing()`
4. Service writes to Firestore
5. Firestore stream automatically updates
6. Provider notifies listeners
7. UI rebuilds with new data

##  Firestore Database Structure

### Collections

#### `users`
```json
{
  "uid": "string",
  "email": "string",
  "displayName": "string",
  "emailVerified": "boolean",
  "createdAt": "timestamp"
}
```

#### `listings`
```json
{
  "name": "string",
  "category": "string (enum value)",
  "address": "string",
  "contactNumber": "string",
  "description": "string",
  "latitude": "number",
  "longitude": "number",
  "createdBy": "string (user UID)",
  "timestamp": "timestamp"
}
```

### Security Rules

Recommended Firestore security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    match /listings/{listingId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.createdBy;
      allow update, delete: if request.auth != null && request.auth.uid == resource.data.createdBy;
    }
  }
}
```

##  Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Firebase account
- Google Maps API key
- Android Studio / VS Code
- Physical device or emulator

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd kigali_services_directory
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### A. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Name it "Kigali Services Directory"
4. Enable Google Analytics (optional)

#### B. Add Android App
1. In Firebase Console, click Android icon
2. Register app with package name: `com.example.kigali_services_directory`
3. Download `google-services.json`
4. Place in `android/app/`

#### C. Add iOS App
1. Click iOS icon in Firebase Console
2. Register with Bundle ID: `com.example.kigaliServicesDirectory`
3. Download `GoogleService-Info.plist`
4. Place in `ios/Runner/`

#### D. Enable Authentication
1. Go to Authentication > Sign-in method
2. Enable Email/Password
3. Enable email verification

#### E. Create Firestore Database
1. Go to Firestore Database
2. Click "Create database"
3. Start in test mode (then add security rules)
4. Choose your region (closest to Rwanda)

### 4. Google Maps API Setup


5. Restrict key (optional but recommended)

#### B. Configure Android

Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
  <application ...>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
    ...
  </application>
</manifest>
```

#### C. Configure iOS

Edit `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 5. Android Configuration

Edit `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

Add permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### 6. iOS Configuration

Edit `ios/Podfile`:

```ruby
platform :ios, '12.0'
```

Add to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs your location to show nearby services</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs your location to show nearby services</string>
```

### 7. Run the App

```bash
# Check for issues
flutter doctor

# Run on connected device
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

##  Testing

### Test Credentials
Create a test account through the app's sign-up screen.

### Sample Listings

You can create sample listings with these Kigali locations:

1. **Kigali Convention Centre**
   - Category: Tourist Attraction
   - Coordinates: -1.9505, 30.0940


##  Usage Guide

### Creating a Listing
1. Sign in to your account
2. Navigate to "My Listings" or "Directory"
3. Tap the "+" button
4. Fill in all required fields
5. Use "Use Current Location" for coordinates
6. Tap "Create Listing"

### Searching & Filtering
1. Go to "Directory" tab
2. Use search bar to search by name
3. Select category chips to filter
4. Tap "All" to clear category filter

### Viewing on Map
1. Tap any listing to view details
2. See embedded map with marker
3. Tap "Get Directions" for navigation
4. Or use "Map View" tab to see all listings

### Editing/Deleting
1. Go to "My Listings"
2. Tap a listing you created
3. Use edit icon or options menu
4. Confirm deletion when prompted

##  Technologies Used

- **Flutter** - UI framework
- **Firebase Authentication** - User authentication
- **Cloud Firestore** - Cloud database
- **Google Maps Flutter** - Map integration
- **Provider** - State management
- **Geolocator** - Location services
- **URL Launcher** - External navigation

##  Known Issues & Limitations

1. Search is case-insensitive but requires exact substring matches
2. Location permissions must be granted manually on iOS
3. App requires internet connection for all functionality
4. Email verification link expires after 24 hours



##  License

This project is for educational purposes as part of a mobile development course.

##  Author

Adeline Claudia IRADUKUNDA
a.iradukund3@alustudent.com

##  Acknowledgments

- Firebase for backend infrastructure
- Google Maps Platform for mapping services
- Flutter team for the amazing framework

---

