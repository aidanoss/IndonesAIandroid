import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FlutterTts _flutterTts;
  final FirebaseFunctions _functions;

  List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  bool _isSpeaking = false;

  ChatProvider(this._firestore, this._auth, this._flutterTts)
      : _functions = FirebaseFunctions.instanceFor(region: "asia-southeast1") {
    _initTts();
    _initAuth();
  }

  // Getters
  List<Map<String, dynamic>> get messages => _messages;
  bool get isTyping => _isTyping;
  bool get isSpeaking => _isSpeaking;

  Future<void> _initAuth() async {
    try {
      // Sign in anonymously if not already signed in
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
        debugPrint('Signed in anonymously');
      }
      await _loadMessages();
    } catch (e) {
      debugPrint('Error initializing auth: $e');
    }
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("id-ID");
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  Future<void> _loadMessages() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final snapshot = await _firestore
            .collection("messages")
            .where("userId", isEqualTo: userId)
            .orderBy("timestamp")
            .get();

        _messages = snapshot.docs
            .map((doc) => {
                  "text": doc["text"] as String,
                  "isUser": doc["isUser"] as bool,
                  "timestamp": (doc["timestamp"] as Timestamp).toDate(),
                })
            .toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading messages: $e");
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      debugPrint("No user signed in");
      return;
    }

    setState(true); // Set typing state

    try {
      // Add user message
      final userMessage = {
        "text": text,
        "isUser": true,
        "timestamp": DateTime.now(),
        "userId": userId,
      };

      await _firestore.collection("messages").add(userMessage);
      _messages.add(userMessage);
      notifyListeners();

      // Get AI response
      final aiResponse = await _getAIResponse(text);
      if (aiResponse != null) {
        debugPrint("AI Response received: ${aiResponse["text"]}");

        final aiMessage = {
          "text": aiResponse["text"],
          "isUser": false,
          "timestamp": DateTime.now(),
          "userId": userId,
        };

        await _firestore.collection("messages").add(aiMessage);
        _messages.add(aiMessage);
        notifyListeners();

        // Speak the response if TTS is enabled
        await speakText(aiResponse["text"] as String);
      } else {
        debugPrint("AI Response was null");
      }
    } catch (e) {
      debugPrint("Error sending message: $e");
    } finally {
      setState(false); // Reset typing state
    }
  }

  Future<Map<String, dynamic>?> _getAIResponse(String userMessage) async {
    try {
      debugPrint("Calling Cloud Function getOpenAIKeyV2...");
      final result = await _functions.httpsCallable("getOpenAIKeyV2").call();
      final apiKey = result.data["key"] as String;
      debugPrint("Got API key successfully");

      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: json.encode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content":
                  "Anda adalah asisten AI Indonesia yang menggunakan model GPT-4o Mini. Selalu berikan respons dalam bahasa Indonesia yang sopan dan membantu."
            },
            {"role": "user", "content": userMessage},
          ],
          "max_tokens": 150,
          "temperature": 0.7,
        }),
      );

      debugPrint("OpenAI API Response Status: ${response.statusCode}");
      debugPrint("OpenAI API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final aiMessage = data["choices"][0]["message"]["content"];
        debugPrint("Extracted AI message: $aiMessage");
        return {
          "text": aiMessage,
          "isUser": false,
          "timestamp": DateTime.now(),
        };
      } else {
        debugPrint("Failed to get AI response: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error getting AI response: $e");
      return null;
    }
  }

  Future<void> speakText(String text) async {
    if (_isSpeaking) {
      await stopSpeaking();
    }

    _isSpeaking = true;
    notifyListeners();

    try {
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint("Error speaking text: $e");
      _isSpeaking = false;
      notifyListeners();
    }
  }

  Future<void> stopSpeaking() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      notifyListeners();
    }
  }

  void setState(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
