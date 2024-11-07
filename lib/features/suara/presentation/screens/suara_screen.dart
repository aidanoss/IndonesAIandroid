import 'package:flutter/material.dart';

class SuaraScreen extends StatefulWidget {
  const SuaraScreen({super.key});

  @override
  _SuaraScreenState createState() => _SuaraScreenState();
}

class _SuaraScreenState extends State<SuaraScreen> {
  bool _isListening = false;
  String _recognizedText = '';
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suara'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap the microphone to start voice chat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _toggleListening,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color:
                      _isListening ? Colors.red.shade100 : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 60,
                  color: _isListening ? Colors.red : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isListening ? 'Listening...' : 'Tap to start',
              style: TextStyle(
                fontSize: 16,
                color: _isListening ? Colors.red : Colors.grey,
              ),
            ),
            if (_isListening) ...[
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Speak or type your message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _recognizedText = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Text('Send'),
              ),
            ],
            if (_recognizedText.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'Recognized Text: $_recognizedText',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (!_isListening) {
        _recognizedText = _textController.text;
        _textController.clear();
      }
    });
  }

  void _sendMessage() {
    // TODO: Implement sending the message to the AI chatbot
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending message: $_recognizedText')),
    );
    setState(() {
      _recognizedText = '';
      _textController.clear();
      _isListening = false;
    });
  }
}
