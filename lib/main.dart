import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'core/config/firebase_config.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/app_provider.dart';
import 'core/providers/chat_provider.dart';
import 'core/providers/chat_history_provider.dart';
import 'features/navigation/presentation/screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with web configuration
    await Firebase.initializeApp(
      options: FirebaseConfig.firebaseOptions,
    );

    // Initialize Text-to-Speech
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage('id-ID');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(1.0);

    // Initialize Firebase services
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    // Ensure user is signed in anonymously
    if (auth.currentUser == null) {
      try {
        await auth.signInAnonymously();
        debugPrint('Signed in anonymously');
      } catch (e) {
        debugPrint('Anonymous sign-in error: $e');
      }
    }

    runApp(MyApp(
      flutterTts: flutterTts,
      firestore: firestore,
      auth: auth,
    ));
  } catch (e) {
    debugPrint('Initialization error: $e');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  final FlutterTts flutterTts;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  const MyApp({
    super.key,
    required this.flutterTts,
    required this.firestore,
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(firestore, auth, flutterTts),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatHistoryProvider(
            firestore,
            auth.currentUser?.uid ?? '',
          ),
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appProvider.themeMode,
            home: const MainNavigation(),
            builder: (context, child) {
              // Apply font scale based on settings
              final mediaQuery = MediaQuery.of(context);
              final scale = appProvider.getFontSizeValue();

              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(scale),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  AppConstants.errorGeneric,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart app
                    main();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.indonesianRed,
                    foregroundColor: AppTheme.indonesianWhite,
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
