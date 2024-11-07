import 'package:cloud_functions/cloud_functions.dart';

class EnvConfig {
  static Future<String> getOpenAIKey() async {
    try {
      final result =
          await FirebaseFunctions.instance.httpsCallable('getOpenAIKey').call();

      if (result.data != null && result.data['key'] != null) {
        return result.data['key'] as String;
      }
      throw Exception('Failed to get OpenAI key');
    } catch (e) {
      throw Exception('Error getting OpenAI key: $e');
    }
  }
}
