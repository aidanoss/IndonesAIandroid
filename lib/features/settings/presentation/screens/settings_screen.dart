import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/app_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsSection(
            title: 'Tampilan',
            children: [
              _buildSettingsTile(
                icon: Icons.brightness_6,
                title: 'Mode Gelap',
                trailing: Switch(
                  value: appProvider.themeMode == ThemeMode.dark,
                  activeColor: AppTheme.primaryRed,
                  onChanged: (bool value) {
                    appProvider.toggleThemeMode();
                  },
                ),
              ),
              _buildSettingsTile(
                icon: Icons.text_fields,
                title: 'Ukuran Teks',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: subtextColor),
                      onPressed: () => appProvider.decreaseFontSize(),
                    ),
                    Text(
                      '${appProvider.fontSizeScale.toStringAsFixed(1)}x',
                      style: TextStyle(color: textColor),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: subtextColor),
                      onPressed: () => appProvider.increaseFontSize(),
                    ),
                  ],
                ),
              ),
              _buildSettingsTile(
                icon: Icons.language,
                title: 'Bahasa',
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                  },
                  items: ['Indonesia', 'English']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value, 
                          style: TextStyle(color: textColor),
                        ),
                      );
                    }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            title: 'Privasi',
            children: [
              _buildSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Kebijakan Privasi',
                onTap: () => _showPrivacyDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
          title: Text(
            'Kebijakan Privasi', 
            style: TextStyle(color: textColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Informasi Penggunaan Data:',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Data yang Anda kirim digunakan untuk meningkatkan layanan AI',
                  style: TextStyle(color: subtextColor),
                ),
                Text(
                  '• Semua percakapan bersifat anonim',
                  style: TextStyle(color: subtextColor),
                ),
                Text(
                  '• Data tidak dibagikan dengan pihak ketiga',
                  style: TextStyle(color: subtextColor),
                ),
                Text(
                  '• Anda dapat menghapus riwayat percakapan kapan saja',
                  style: TextStyle(color: subtextColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kami berkomitmen melindungi privasi Anda.',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tutup', 
                style: TextStyle(color: AppTheme.primaryRed),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return ListTile(
      leading: Icon(
        icon, 
        color: AppTheme.primaryRed,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? 
        (onTap != null 
          ? Icon(Icons.chevron_right, color: subtextColor) 
          : null),
      onTap: onTap,
    );
  }
}
