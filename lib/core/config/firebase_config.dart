import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;

class FirebaseConfig {
  static FirebaseOptions get firebaseOptions {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyDAkVmgNW6_W7qDCtSJdihcBZvLCwHPvI4", // Web API key
        authDomain: "indonesai-vcs.firebaseapp.com",
        projectId: "indonesai-vcs",
        storageBucket: "indonesai-vcs.appspot.com",
        messagingSenderId: "884875073251", // Project number
        appId: "1:884875073251:web:a1b2c3d4e5f6g7h8" // Web app ID (you may need to get the exact value from Firebase console)
      );
    }
    
    // Platform-specific configurations can be added here
    return const FirebaseOptions(
      apiKey: "AIzaSyDAkVmgNW6_W7qDCtSJdihcBZvLCwHPvI4", // Same API key for other platforms
      projectId: "indonesai-vcs",
      messagingSenderId: "884875073251",
      appId: "1:884875073251:android:a1b2c3d4e5f6g7h8" // Android app ID (you may need to get the exact value from Firebase console)
    );
  }

  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: firebaseOptions,
      );
      debugPrint('Firebase initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
      rethrow;
    }
  }
}
