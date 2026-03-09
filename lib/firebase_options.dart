// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7crTkGuhbv3tCNKz8DsKz8W6GaB9mz8I',
    appId: '1:699762977359:web:21296c605c29d9e377d83a',
    messagingSenderId: '699762977359',
    projectId: 'kigali-services-director-bc9e1',
    authDomain: 'kigali-services-director-bc9e1.firebaseapp.com',
    storageBucket: 'kigali-services-director-bc9e1.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAd7foNCQ07lG3-aqtQ5mUE75C7AdDRuPo',
    appId: '1:699762977359:android:acfbaae223a15aad77d83a',
    messagingSenderId: '699762977359',
    projectId: 'kigali-services-director-bc9e1',
    storageBucket: 'kigali-services-director-bc9e1.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7crTkGuhbv3tCNKz8DsKz8W6GaB9mz8I',
    appId: '1:699762977359:web:3661d565a9019acb77d83a',
    messagingSenderId: '699762977359',
    projectId: 'kigali-services-director-bc9e1',
    authDomain: 'kigali-services-director-bc9e1.firebaseapp.com',
    storageBucket: 'kigali-services-director-bc9e1.firebasestorage.app',
  );
}
