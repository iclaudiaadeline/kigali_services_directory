# Submission Checklist
## Individual Assignment 2 - Kigali Services Directory

### Student Information
- **Name**: ___________________________
- **Student ID**: ___________________________
- **Submission Date**: ___________________________

---

## 📋 Pre-Submission Checklist

### 1. Code Implementation ✅

#### Firebase Integration
- [ ] Firebase project created
- [ ] `google-services.json` in `android/app/` (DO NOT commit to Git)
- [ ] `GoogleService-Info.plist` in `ios/Runner/` (DO NOT commit to Git)
- [ ] Google Maps API key configured in AndroidManifest.xml
- [ ] Google Maps API key configured in AppDelegate.swift
- [ ] Firebase Authentication enabled in console
- [ ] Cloud Firestore database created
- [ ] Firestore security rules implemented

#### Authentication Features
- [ ] Sign up with email/password works
- [ ] Email verification enforced before app access
- [ ] Email verification link sends successfully
- [ ] Automatic verification detection works
- [ ] Sign in with verified email works
- [ ] Sign out functionality works
- [ ] User profile created in Firestore on signup
- [ ] Error messages are user-friendly

#### CRUD Operations
- [ ] Create listing - saves to Firestore
- [ ] Read listings - displays from Firestore
- [ ] Update listing - modifies in Firestore
- [ ] Delete listing - removes from Firestore
- [ ] Only listing creator can edit/delete their listings
- [ ] Real-time updates work (changes reflect immediately)
- [ ] Loading states displayed during operations
- [ ] Error handling implemented for all operations

#### Search & Filtering
- [ ] Search by name works (case-insensitive)
- [ ] Category filter works
- [ ] Can combine search and category filter
- [ ] Clear filters works
- [ ] Results update in real-time

#### Map Integration
- [ ] Google Maps displays on detail page
- [ ] Marker shows correct location
- [ ] "Get Directions" button works
- [ ] Opens Google Maps app with navigation
- [ ] Map View tab shows all listings
- [ ] Different marker colors for different categories
- [ ] Tapping marker opens listing detail

#### Navigation & UI
- [ ] Bottom navigation bar works
- [ ] 4 tabs: Directory, My Listings, Map View, Settings
- [ ] All screens accessible and functional
- [ ] Settings shows user profile
- [ ] Notification toggle works
- [ ] App has consistent styling
- [ ] No UI errors or crashes

#### State Management
- [ ] Provider pattern implemented correctly
- [ ] Services layer separates Firebase operations
- [ ] No direct Firebase calls in UI widgets
- [ ] Loading states managed through providers
- [ ] Error states managed through providers
- [ ] Automatic UI updates when data changes

---

### 2. GitHub Repository 📦

#### Repository Setup
- [ ] Repository created on GitHub
- [ ] Repository is public or accessible by instructor
- [ ] Meaningful repository name (e.g., "kigali-services-directory")
- [ ] At least 10 commits showing progressive development
- [ ] Commit messages are descriptive
- [ ] `.gitignore` prevents Firebase config files from being committed

#### Repository Contents
- [ ] All source code in `lib/` directory
- [ ] `pubspec.yaml` with correct dependencies
- [ ] `android/` and `ios/` configuration files
- [ ] README.md file is complete and detailed
- [ ] FIREBASE_SETUP.md with setup instructions
- [ ] No sensitive API keys or credentials committed

#### README.md Must Include:
- [ ] App description and features
- [ ] Setup instructions (Firebase, Google Maps)
- [ ] Firestore database structure explained
- [ ] State management approach described
- [ ] Screenshots or demo link
- [ ] How to run the project
- [ ] Technologies used
- [ ] Your contact information

---

### 3. Demo Video 🎥

#### Video Requirements
- [ ] Duration is between 7-12 minutes
- [ ] Video quality is 720p or higher
- [ ] Audio is clear and audible
- [ ] Face/voice narration present
- [ ] Screen shows both app and Firebase Console

#### Content Demonstrated
- [ ] **Authentication**: Signup, email verification, sign in
- [ ] **Creating**: Create at least 2 listings
- [ ] **Reading**: Browse directory
- [ ] **Updating**: Edit a listing
- [ ] **Deleting**: Delete a listing
- [ ] **Search**: Search by name
- [ ] **Filter**: Filter by category
- [ ] **Detail Page**: Open listing detail with map
- [ ] **Navigation**: Launch Google Maps directions
- [ ] **Map View**: Show all listings on map
- [ ] **Settings**: Display profile and toggle

#### Firebase Console Shown
- [ ] Show empty database before creating listings
- [ ] Show Authentication users list
- [ ] Show Firestore after creating listing
- [ ] Show Firestore after editing listing
- [ ] Show Firestore after deleting listing
- [ ] Demonstrate real-time sync between app and console

#### Code Explanation
- [ ] Show project folder structure
- [ ] Display auth_service.dart
- [ ] Display listing_service.dart
- [ ] Display auth_provider.dart
- [ ] Display listing_provider.dart
- [ ] Explain how state flows from Firebase → Service → Provider → UI
- [ ] Describe clean architecture approach

#### Video Delivery
- [ ] Video uploaded to YouTube, Google Drive, or OneDrive
- [ ] Video link is accessible (public or shared with instructor)
- [ ] Video link included in PDF submission
- [ ] Video tested on different device for playback

---

### 4. Implementation Reflection PDF 📄

#### Document Structure
- [ ] Student name and ID on first page
- [ ] Professional formatting
- [ ] At least 3 pages (excluding screenshots)
- [ ] Converted to PDF format

#### Content Requirements
- [ ] Discussion of Firebase integration experience
- [ ] **At least 2** authentication challenges documented
- [ ] **At least 2** Firestore integration challenges documented
- [ ] Each challenge includes:
  - [ ] Description of the problem
  - [ ] Error message or symptom
  - [ ] Screenshot of error
  - [ ] Solution implemented
  - [ ] Code snippets showing solution
  - [ ] Outcome/result
- [ ] Reflection on state management approach
- [ ] Overall development experience summary
- [ ] What you learned
- [ ] What you'd do differently

#### Screenshots Included
- [ ] At least 6 screenshots showing errors/solutions
- [ ] Firebase Console screenshots
- [ ] Error message screenshots
- [ ] Code screenshots
- [ ] All screenshots are clear and readable

---

### 5. Design Summary Document 📊

#### Document Structure
- [ ] Student name and ID on first page
- [ ] 1-2 pages as specified
- [ ] Professional formatting
- [ ] Converted to PDF format

#### Content Requirements
- [ ] Firestore database structure explained
  - [ ] Collections described (users, listings)
  - [ ] Document schema for each collection
  - [ ] Field types and purposes
  - [ ] Security rules explained
- [ ] Listing model documentation
  - [ ] All fields explained
  - [ ] Category enum described
  - [ ] Timestamp handling explained
- [ ] State management implementation
  - [ ] Why Provider was chosen
  - [ ] How providers are structured
  - [ ] Data flow diagram or explanation
  - [ ] How UI updates automatically
- [ ] Design trade-offs discussed
  - [ ] Client-side vs server-side filtering
  - [ ] Single collection vs multiple collections
  - [ ] State management pattern choice
- [ ] Technical challenges encountered
  - [ ] How they were overcome
  - [ ] Lessons learned

---

### 6. Final PDF Submission 📑

Create a **single PDF** containing all of the following in order:

#### Page 1: Cover Page
- [ ] Assignment title: "Individual Assignment 2"
- [ ] App name: "Kigali Services Directory"
- [ ] Your full name
- [ ] Student ID
- [ ] Course name and code
- [ ] Instructor name
- [ ] Submission date

#### Section 1: Implementation Reflection (3-4 pages)
- [ ] Copy content from IMPLEMENTATION_REFLECTION.md
- [ ] Include all screenshots
- [ ] Format professionally

#### Section 2: GitHub Repository Link
- [ ] Full GitHub repository URL
- [ ] Brief statement about commit history
- [ ] Note about README completeness

#### Section 3: Demo Video Link
- [ ] Direct link to video
- [ ] Video duration noted
- [ ] Brief description of content covered

#### Section 4: Design Summary (1-2 pages)
- [ ] Copy content from DESIGN_SUMMARY.md
- [ ] Include any relevant diagrams
- [ ] Format professionally

#### PDF Properties
- [ ] Total combined PDF is 5-8 pages
- [ ] All links are clickable
- [ ] All images are clear
- [ ] File size under 10MB
- [ ] File named: `[YourName]_IndividualAssignment2.pdf`

---

## 🧪 Testing Checklist

Before recording demo video, test everything:

### Fresh Install Test
- [ ] Clone repository on clean machine
- [ ] Follow README setup instructions
- [ ] Add Firebase configuration files
- [ ] Run `flutter pub get`
- [ ] Run `flutter run`
- [ ] App works without errors

### Feature Testing
- [ ] Create new test account
- [ ] Verify email
- [ ] Create 3 different listings
- [ ] Edit one listing
- [ ] Delete one listing
- [ ] Search for listings
- [ ] Filter by each category
- [ ] Open detail page
- [ ] Launch navigation
- [ ] View Map View tab
- [ ] Toggle settings
- [ ] Sign out and sign in again

### Database Verification
- [ ] All operations reflect in Firebase Console
- [ ] Security rules prevent unauthorized access
- [ ] Timestamps are correct
- [ ] User profiles exist for all users

---

## 🚨 Common Issues to Avoid

### DO NOT:
- ❌ Commit Firebase config files to Git
- ❌ Commit API keys to Git
- ❌ Submit video longer than 12 minutes or shorter than 7 minutes
- ❌ Skip showing Firebase Console in video
- ❌ Forget to show code implementation in video
- ❌ Submit incomplete reflection (needs at least 4 challenges)
- ❌ Forget to test app before recording
- ❌ Use test mode Firestore rules in production
- ❌ Have your app crash during demo video
- ❌ Rush through video explanation

### DO:
- ✅ Test everything before recording
- ✅ Speak clearly and explain thoroughly
- ✅ Show Firebase Console for every CRUD operation
- ✅ Display relevant code sections
- ✅ Keep video within time limits
- ✅ Make repository public or share with instructor
- ✅ Include meaningful commit messages
- ✅ Test PDF links work before submitting
- ✅ Proofread all documents
- ✅ Submit on time!

---

## 📤 Submission Method

### Check Your Submission Requirements:
- Platform: ___________________________
- Due Date: ___________________________
- Time: ___________________________
- File Format: ___________________________

### Final Submission Includes:
1. [ ] Single PDF document (cover + reflection + links + design summary)
2. [ ] GitHub repository URL in PDF
3. [ ] Demo video link in PDF
4. [ ] Video is accessible
5. [ ] Repository is accessible

---

## ✅ Pre-Submission Final Check

### 24 Hours Before Deadline:
- [ ] All code is complete and pushed to GitHub
- [ ] Demo video is recorded and uploaded
- [ ] PDF document is complete
- [ ] All links are tested and working
- [ ] Asked a friend to review your submission

### 1 Hour Before Deadline:
- [ ] Test all links one more time
- [ ] Verify video plays correctly
- [ ] Verify repository is accessible
- [ ] Read through PDF one last time
- [ ] Submit with time to spare!

---

## 🎯 Grading Alignment

Your submission should cover:

| Criterion | Points | Check |
|-----------|--------|-------|
| State Management & Clean Architecture | 10 | [ ] |
| Code Quality & Repository | 7 | [ ] |
| Authentication | 5 | [ ] |
| CRUD Operations | 5 | [ ] |
| Search & Filtering | 4 | [ ] |
| Map Integration | 5 | [ ] |
| Navigation & Settings | 4 | [ ] |
| Deliverables Quality | 5 | [ ] |
| Demo Video Explanation | 5 | [ ] |
| **TOTAL** | **50** | [ ] |

---

## 📞 Need Help?

If you encounter issues:
1. Check README.md for common solutions
2. Check FIREBASE_SETUP.md for setup issues
3. Review error messages in console
4. Search Firebase/Flutter documentation
5. Check Stack Overflow for similar issues
6. Ask instructor during office hours

---

**Good luck with your submission! 🚀**

---

## Signature

I confirm that I have:
- Completed all required features
- Tested the application thoroughly
- Recorded a comprehensive demo video
- Written complete documentation
- Checked all submission requirements

**Student Signature**: _____________________  
**Date**: _____________________
