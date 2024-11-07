import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isVoiceEnabled = true;
  double _voiceSpeed = 1.0;
  double _voicePitch = 1.0;
  String _selectedFontSize = AppConstants.mediumFont;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.settingsLabel,
          style: TextStyle(
            color: AppTheme.indonesianWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            title: AppConstants.themeSettings,
            children: [
              SwitchListTile(
                title: const Text(AppConstants.darkMode),
                subtitle: Text(_isDarkMode
                    ? AppConstants.darkMode
                    : AppConstants.lightMode),
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  // Akan diimplementasikan dengan provider
                },
                secondary: Icon(
                  _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: AppTheme.indonesianRed,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.format_size,
                  color: AppTheme.indonesianRed,
                ),
                title: const Text(AppConstants.fontSizeSettings),
                subtitle: Text(_selectedFontSize),
                trailing: DropdownButton<String>(
                  value: _selectedFontSize,
                  underline: const SizedBox(),
                  items: [
                    AppConstants.smallFont,
                    AppConstants.mediumFont,
                    AppConstants.largeFont,
                  ].map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedFontSize = value;
                      });
                      // Akan diimplementasikan dengan provider
                    }
                  },
                ),
              ),
            ],
          ),
          _buildSection(
            title: AppConstants.voiceSettings,
            children: [
              SwitchListTile(
                title: const Text(AppConstants.enableVoice),
                value: _isVoiceEnabled,
                onChanged: (value) {
                  setState(() {
                    _isVoiceEnabled = value;
                  });
                  // Akan diimplementasikan dengan provider
                },
                secondary: const Icon(
                  Icons.record_voice_over,
                  color: AppTheme.indonesianRed,
                ),
              ),
              if (_isVoiceEnabled) ...[
                ListTile(
                  leading: const Icon(
                    Icons.speed,
                    color: AppTheme.indonesianRed,
                  ),
                  title: const Text(AppConstants.voiceSpeed),
                  subtitle: Slider(
                    value: _voiceSpeed,
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    label: _voiceSpeed.toString(),
                    onChanged: (value) {
                      setState(() {
                        _voiceSpeed = value;
                      });
                      // Akan diimplementasikan dengan provider
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.tune,
                    color: AppTheme.indonesianRed,
                  ),
                  title: const Text(AppConstants.voicePitch),
                  subtitle: Slider(
                    value: _voicePitch,
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    label: _voicePitch.toString(),
                    onChanged: (value) {
                      setState(() {
                        _voicePitch = value;
                      });
                      // Akan diimplementasikan dengan provider
                    },
                  ),
                ),
              ],
            ],
          ),
          _buildSection(
            title: AppConstants.languageSettings,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.translate,
                  color: AppTheme.indonesianRed,
                ),
                title: const Text('Bahasa'),
                subtitle: const Text('Bahasa Indonesia'),
                trailing: const Icon(Icons.check),
                onTap: () {
                  // Saat ini hanya mendukung Bahasa Indonesia
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Saat ini hanya tersedia dalam Bahasa Indonesia'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
