import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConfig {
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    // TODO: Replace these values with your Firebase project configuration
    apiKey: 'YOUR_API_KEY',
    authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    messagingSenderId: 'YOUR_SENDER_ID',
    appId: 'YOUR_APP_ID',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: firebaseOptions,
      );

      // Initialize anonymous authentication
      await FirebaseAuth.instance.signInAnonymously();
      debugPrint('Firebase: Signed in anonymously');

      // Initialize Firestore with Asia Southeast 1 settings
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      debugPrint(
          'Firebase: Initialized with config: ${firebaseOptions.projectId}');
    } catch (e) {
      debugPrint('Firebase initialization error: $e');
      rethrow;
    }
  }
}
