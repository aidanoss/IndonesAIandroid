import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConfig {
  static const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyDAkVmgNW6_W7qDCtSJdihcBZvLCwHPvI4',
    authDomain: 'indonesai-vcs.firebaseapp.com',
    projectId: 'indonesai-vcs',
    storageBucket: 'indonesai-vcs.appspot.com',
    messagingSenderId: '884875073251',
    appId: '1:884875073251:web:81981a8f5217695295d7d6',
    measurementId: 'G-QEQQY8CGH1',
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
