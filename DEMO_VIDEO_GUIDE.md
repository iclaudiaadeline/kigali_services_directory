# Demo Video Script & Checklist
## Kigali Services Directory

### Video Requirements
- **Duration**: 7-12 minutes
- **Format**: MP4 or similar
- **Quality**: 720p minimum
- **Audio**: Clear voice narration
- **Screen Recording**: Show both app and Firebase Console

---

## Pre-Recording Checklist

### Before You Start Recording
- [ ] Clean your device's screen (remove test data, notifications)
- [ ] Disable notifications during recording
- [ ] Charge device to 80%+ battery
- [ ] Prepare fresh test account credentials
- [ ] Open Firebase Console in browser (ready to show)
- [ ] Test screen recording setup
- [ ] Prepare code editor with key files open
- [ ] Create script/outline of what to demonstrate

---

## Video Structure (Suggested Timeline)

### Part 1: Introduction (0:00 - 1:00)
**Duration**: ~1 minute

**What to Show**:
- Your name and student ID
- Brief overview of the app
- Show the app running

**Script Example**:
> "Hello, my name is [Name], student ID [ID]. In this demo, I'll be showcasing the Kigali Services Directory mobile application. This app helps Kigali residents find and navigate to essential services like hospitals, restaurants, and tourist attractions. The app uses Firebase Authentication, Cloud Firestore, Google Maps, and Provider state management."

**Checklist**:
- [ ] State your name and student ID
- [ ] Describe app purpose
- [ ] Show app splash/home screen

---

### Part 2: Firebase Console Overview (1:00 - 2:00)
**Duration**: ~1 minute

**What to Show**:
1. Firebase project dashboard
2. Authentication section (empty users list)
3. Firestore database structure
4. Show empty listings collection

**Script Example**:
> "Let me first show you the Firebase backend. Here's our Firebase project. In Authentication, we currently have no users. In Firestore, we have two collections: 'users' for user profiles and 'listings' for service entries. Both collections are currently empty."

**Checklist**:
- [ ] Show Firebase project name
- [ ] Open Authentication tab
- [ ] Open Firestore tab and show collections
- [ ] Explain database structure briefly

---

### Part 3: User Authentication Flow (2:00 - 4:30)
**Duration**: ~2.5 minutes

#### Sign Up (1 minute)
**What to Show**:
1. Sign up screen
2. Fill in registration form
3. Submit and show success message
4. **SWITCH TO FIREBASE CONSOLE**
5. Show new user in Authentication
6. Show user profile created in Firestore 'users' collection

**Code to Show**:
Open `lib/services/auth_service.dart` and show:
```dart
Future<UserCredential?> signUp({
  required String email,
  required String password,
  required String displayName,
}) async {
  // Show the implementation
}
```

**Script Example**:
> "I'll create a new account with email test@example.com. After submitting, notice the success message. Now switching to Firebase Console - you can see the new user appears in Authentication with emailVerified set to false. In Firestore, a user document was automatically created with my profile information."

**Checklist**:
- [ ] Fill and submit sign-up form
- [ ] Show success message
- [ ] Show new user in Firebase Authentication
- [ ] Show new document in Firestore users collection
- [ ] Display auth_service.dart code that handles signup
- [ ] Explain how user profile is created

#### Email Verification (1.5 minutes)
**What to Show**:
1. Email verification screen
2. Open email in inbox (or explain verification link)
3. Click verification link
4. Return to app and show automatic detection
5. **SWITCH TO FIREBASE CONSOLE**
6. Show emailVerified changed to true

**Code to Show**:
Open `lib/screens/auth/email_verification_screen.dart` and show:
```dart
void _startPeriodicCheck() {
  _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
    // Show polling logic
  });
}
```

**Script Example**:
> "The app now requires email verification. I've implemented automatic polling that checks every 3 seconds. When I click the verification link in my email, the app automatically detects it and transitions to the authenticated state. In Firebase, you can see emailVerified is now true."

**Checklist**:
- [ ] Show email verification screen
- [ ] Demonstrate verification link click
- [ ] Show automatic transition to authenticated state
- [ ] Show emailVerified: true in Firebase Console
- [ ] Display email_verification_screen.dart polling code
- [ ] Explain automatic checking mechanism

---

### Part 4: Creating a Listing (4:30 - 6:00)
**Duration**: ~1.5 minutes

**What to Show**:
1. Navigate to "My Listings" or tap "+" button
2. Fill in listing form:
   - Name: "King Faisal Hospital"
   - Category: Hospital
   - Address: "KN Hospital Rd, Kigali"
   - Contact: "+250 788 123 456"
   - Description: "Major healthcare facility"
   - Tap "Use Current Location" for coordinates
3. Submit listing
4. **SWITCH TO FIREBASE CONSOLE** 
5. Show new listing in Firestore
6. Show createdBy field matches user UID

**Code to Show**:
Open `lib/providers/listing_provider.dart` and show:
```dart
Future<bool> createListing(ListingModel listing) async {
  // Show state management
}
```

Open `lib/services/listing_service.dart` and show:
```dart
Future<void> createListing(ListingModel listing) async {
  await _firestore.collection(_collection).add(listing.toMap());
}
```

**Script Example**:
> "I'll create a new listing for King Faisal Hospital. I can use my current location to auto-fill coordinates. After submitting, the listing appears in my listings page. In Firebase, you can see the new document in the listings collection. The createdBy field contains my user UID, which is how we enforce ownership."

**Checklist**:
- [ ] Navigate to create listing screen
- [ ] Fill in all fields
- [ ] Use "Get Current Location" feature
- [ ] Submit listing
- [ ] Show listing appears in directory
- [ ] Show listing in Firebase Firestore
- [ ] Point out createdBy field
- [ ] Display listing_provider.dart createListing code
- [ ] Display listing_service.dart Firestore operation

---

### Part 5: Editing a Listing (6:00 - 7:00)
**Duration**: ~1 minute

**What to Show**:
1. Go to "My Listings"
2. Tap on the listing just created
3. Tap edit icon
4. Change a field (e.g., update contact number)
5. Save changes
6. **SWITCH TO FIREBASE CONSOLE**
7. Show updated field in Firestore

**Code to Show**:
Open `lib/screens/listings/edit_listing_screen.dart` and show update method

**Script Example**:
> "To edit, I'll open my listing and tap the edit icon. I'll update the contact number. After saving, the change is immediately reflected in the app. In Firebase, you can see the updated contact number. The state management system ensures the UI rebuilds automatically."

**Checklist**:
- [ ] Open listing detail
- [ ] Tap edit button
- [ ] Modify at least one field
- [ ] Save changes
- [ ] Show updated listing in app
- [ ] Show updated field in Firebase
- [ ] Display edit_listing_screen.dart code
- [ ] Explain how Provider notifies listeners

---

### Part 6: Deleting a Listing (7:00 - 7:30)
**Duration**: ~30 seconds

**What to Show**:
1. Tap delete button on a listing
2. Confirm deletion dialog
3. Show listing removed from UI
4. **SWITCH TO FIREBASE CONSOLE**
5. Show listing removed from Firestore

**Script Example**:
> "Deleting a listing requires confirmation. After confirming, the listing is immediately removed from both the app and Firebase."

**Checklist**:
- [ ] Initiate delete action
- [ ] Show confirmation dialog
- [ ] Confirm deletion
- [ ] Show listing removed from app
- [ ] Show listing removed from Firebase
- [ ] Briefly explain delete implementation

---

### Part 7: Search and Filtering (7:30 - 8:30)
**Duration**: ~1 minute

**What to Show**:
1. Go to Directory screen
2. Create 2-3 more listings with different categories
3. Use search bar to search by name
4. Show filtered results
5. Clear search
6. Use category filter chips
7. Show category-filtered results
8. **NO NEED FOR FIREBASE CONSOLE** (real-time already demonstrated)

**Code to Show**:
Open `lib/providers/listing_provider.dart` and show:
```dart
void _applyFilters() {
  _filteredListings = _listings.where((listing) {
    // Show filter logic
  }).toList();
}
```

**Script Example**:
> "The search bar filters listings by name in real-time. I can also filter by category using these chips. The filtering happens client-side in the Provider layer, which allows combining search and category filters. As you can see, results update immediately as I type or change filters."

**Checklist**:
- [ ] Type in search bar
- [ ] Show filtered results
- [ ] Clear search
- [ ] Select category filter
- [ ] Show category-filtered results
- [ ] Combine search and category filter
- [ ] Display filter implementation code
- [ ] Explain client-side filtering approach

---

### Part 8: Listing Detail Page & Map (8:30 - 10:00)
**Duration**: ~1.5 minutes

**What to Show**:
1. Tap on a listing to open detail page
2. Show all listing information displayed
3. Point out embedded Google Map with marker
4. Zoom/pan the map
5. Tap "Get Directions" button
6. Show Google Maps app opens with navigation

**Code to Show**:
Open `lib/screens/listings/listing_detail_screen.dart` and show:
```dart
Widget _buildMap() {
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: LatLng(listing.latitude, listing.longitude),
      zoom: 15,
    ),
    markers: {
      // Show marker configuration
    },
  );
}
```

**Script Example**:
> "The detail page shows all information about the listing. The Google Map displays the exact location with a marker. Users can interact with the map. The 'Get Directions' button launches Google Maps for turn-by-turn navigation. This integration uses the url_launcher package to open the native Google Maps app."

**Checklist**:
- [ ] Open listing detail page
- [ ] Show all information displayed correctly
- [ ] Interact with embedded map (zoom/pan)
- [ ] Tap "Get Directions"
- [ ] Show Google Maps opens with route
- [ ] Display listing_detail_screen.dart map code
- [ ] Explain map integration and navigation

---

### Part 9: Map View Screen (10:00 - 10:45)
**Duration**: ~45 seconds

**What to Show**:
1. Navigate to "Map View" tab
2. Show all listings displayed as markers
3. Tap on a marker to see info window
4. Tap info window to open listing detail
5. Show different marker colors for different categories

**Code to Show**:
Open `lib/screens/map/map_view_screen.dart`

**Script Example**:
> "The Map View tab shows all listings on a single map. Different categories have different colored markers: hospitals are red, restaurants are orange, parks are green. Tapping a marker shows basic information, and tapping again opens the full detail page."

**Checklist**:
- [ ] Navigate to Map View tab
- [ ] Show multiple markers on map
- [ ] Tap marker to show info window
- [ ] Open listing from map
- [ ] Point out different marker colors
- [ ] Display map_view_screen.dart code

---

### Part 10: Settings Screen (10:45 - 11:15)
**Duration**: ~30 seconds

**What to Show**:
1. Navigate to Settings tab
2. Show user profile information
3. Toggle location notifications
4. Show toggle state persists (toggle on/off a few times)
5. Tap "About" to show app info
6. Explain sign out button (don't sign out yet)

**Code to Show**:
Open `lib/providers/settings_provider.dart`

**Script Example**:
> "The Settings screen displays the authenticated user's profile from Firebase. The location notification toggle demonstrates state management - the setting persists as I navigate away and back. The Provider pattern makes this functionality straightforward to implement."

**Checklist**:
- [ ] Navigate to Settings
- [ ] Show user profile displayed
- [ ] Toggle notification setting
- [ ] Navigate away and back to show persistence
- [ ] Show About dialog
- [ ] Display settings_provider.dart code

---

### Part 11: Architecture Overview (11:15 - 12:00)
**Duration**: ~45 seconds

**What to Show in Code Editor**:
Show folder structure and quickly navigate through:
1. `lib/models/` - Data models
2. `lib/services/` - Firebase services
3. `lib/providers/` - State management
4. `lib/screens/` - UI screens
5. `lib/widgets/` - Reusable components

**Script Example**:
> "The app follows clean architecture with clear separation of concerns. Models define data structures. Services handle Firebase operations. Providers manage state using the Provider pattern. Screens contain UI logic. This architecture makes the code maintainable and testable. Data flows from Firestore through Services to Providers, which notify the UI to rebuild."

**Checklist**:
- [ ] Show project folder structure
- [ ] Briefly explain each layer
- [ ] Show one example of service → provider → UI flow
- [ ] Mention state management pattern used

---

### Part 12: Conclusion (12:00 - 12:30)
**Duration**: ~30 seconds

**What to Say**:
> "This concludes my demo of the Kigali Services Directory app. I've demonstrated: complete authentication flow with email verification, CRUD operations on listings with real-time Firebase sync, search and category filtering, Google Maps integration with navigation, and a clean architecture using Provider state management. Thank you for watching."

**Checklist**:
- [ ] Summarize key features demonstrated
- [ ] Thank the viewer
- [ ] Ensure video is 7-12 minutes total

---

## Post-Recording Checklist

### Before Submitting
- [ ] Review entire video for audio quality
- [ ] Verify all features were demonstrated
- [ ] Check that Firebase Console was shown for each CRUD operation
- [ ] Ensure code was displayed as required
- [ ] Verify video duration is 7-12 minutes
- [ ] Export in high quality (720p minimum)
- [ ] Test playback on different device
- [ ] Upload to submission platform or cloud storage
- [ ] Include video link in PDF submission

---

## Tips for Recording

### Video Quality
- Use screen recording software (OBS, QuickTime, AZ Screen Recorder)
- Record in highest quality available
- Keep video framerate at 30fps minimum

### Audio Quality
- Use an external microphone if available
- Record in quiet environment
- Speak clearly and at moderate pace
- Pause between sections for natural breaks

### Demonstration Tips
- Keep device in portrait orientation for mobile app
- Use a mouse cursor to point at important elements
- Zoom in on small text when needed
- Take your time - better to go slow than rush

### Common Mistakes to Avoid
- ❌ Not showing Firebase Console updates
- ❌ Speaking too fast or too quietly
- ❌ Not showing code implementation
- ❌ Forgetting to explain state management flow
- ❌ Video too short (under 7 minutes) or too long (over 12 minutes)
- ❌ Not demonstrating email verification
- ❌ Skipping the search/filter feature

---

## Screen Recording Setup

### For Windows:
- OBS Studio (free)
- Xbox Game Bar (built-in: Win + G)
- ShareX (free)

### For macOS:
- QuickTime Player (built-in)
- OBS Studio (free)
- Screen Studio (paid but excellent quality)

### For Android Testing:
- AZ Screen Recorder
- Mobizen Screen Recorder
- Built-in screen recorder (Android 11+)

---

## Grading Rubric Mapping

Make sure your video covers:
- ✅ **Authentication Flow** (5 pts): Show signup, email verification, Firebase Console
- ✅ **CRUD Operations** (5 pts): Create, read, update, delete with Firebase sync
- ✅ **Search & Filter** (4 pts): Demonstrate both features with code
- ✅ **Map Integration** (5 pts): Embedded map and navigation with code
- ✅ **State Management** (10 pts): Explain Provider usage and show code
- ✅ **Code Quality** (7 pts): Show project structure and explain architecture
- ✅ **Demo Explanation** (5 pts): Clear explanations with code display

Total: 41 points covered in video demonstration

---

Good luck with your demo video recording! 🎥
