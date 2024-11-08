import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  VoiceScreenState createState() => VoiceScreenState();
}

class VoiceScreenState extends State<VoiceScreen> {
  bool _isRecording = false;
  String _recognizedText = '';
  final TextEditingController _textController = TextEditingController();

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      if (!_isRecording) {
        // TODO: Implement actual speech recognition
        print('Speech recognition functionality to be implemented');
        _recognizedText = 'Sample recognized text';
        _textController.text = _recognizedText;
      }
    });
  }

  void _sendMessage() {
    if (_recognizedText.isNotEmpty) {
      // TODO: Implement sending voice message
      print('Voice message sending functionality to be implemented');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sending: $_recognizedText')),
      );
      setState(() {
        _recognizedText = '';
        _textController.clear();
        _isRecording = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suara',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the microphone to start voice chat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _toggleRecording,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryRed,
                      AppTheme.primaryRed.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isRecording ? 'Recording...' : 'Tap to start',
              style: TextStyle(
                fontSize: 16,
                color: _isRecording 
                  ? AppTheme.primaryRed 
                  : subtextColor,
              ),
            ),
            const SizedBox(height: 20),
            if (_isRecording || _recognizedText.isNotEmpty)
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Speak or type your message...',
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: _recognizedText.isNotEmpty 
                        ? AppTheme.primaryRed 
                        : subtextColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _recognizedText = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
