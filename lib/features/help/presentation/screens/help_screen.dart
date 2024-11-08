 import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bantuan',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpSection(
                context,
                title: 'Panduan Penggunaan',
                children: [
                  _buildHelpTile(
                    context,
                    icon: Icons.chat_bubble_outline,
                    title: 'Memulai Percakapan',
                    description: 'Gunakan area input di bawah layar untuk mengirim pesan kepada AI.',
                  ),
                  _buildHelpTile(
                    context,
                    icon: Icons.image_outlined,
                    title: 'Analisis Dokumen',
                    description: 'Unggah dokumen atau gambar untuk dianalisis oleh AI.',
                  ),
                  _buildHelpTile(
                    context,
                    icon: Icons.mic_none,
                    title: 'Input Suara',
                    description: 'Gunakan fitur mikrofon untuk mengirim pesan melalui suara.',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildHelpSection(
                context,
                title: 'Fitur Utama',
                children: [
                  _buildHelpTile(
                    context,
                    icon: Icons.translate,
                    title: 'Terjemahan',
                    description: 'AI dapat membantu menerjemahkan teks ke berbagai bahasa.',
                  ),
                  _buildHelpTile(
                    context,
                    icon: Icons.text_fields,
                    title: 'Ringkasan Teks',
                    description: 'Dapatkan ringkasan cepat dari dokumen atau artikel panjang.',
                  ),
                  _buildHelpTile(
                    context,
                    icon: Icons.lightbulb_outline,
                    title: 'Bantuan Kreatif',
                    description: 'Gunakan AI untuk mendapatkan ide dan solusi kreatif.',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement contact support
                    print('Contact support functionality to be implemented');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Layanan dukungan dalam pengembangan')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32, 
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Hubungi Dukungan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(
    BuildContext context, {
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

  Widget _buildHelpTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryRed),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          color: subtextColor,
        ),
      ),
    );
  }
}
