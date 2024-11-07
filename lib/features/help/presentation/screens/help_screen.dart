import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bantuan',
          style: TextStyle(
            color: AppTheme.indonesianWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Cara Menggunakan IndonesAI',
            'IndonesAI adalah asisten AI yang dirancang khusus untuk pengguna Indonesia. '
                'Anda dapat mengobrol dengan AI dalam Bahasa Indonesia tentang berbagai topik.',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Fitur Utama',
            '• Obrolan dalam Bahasa Indonesia\n'
                '• Suara AI dengan aksen Indonesia\n'
                '• Simpan obrolan favorit\n'
                '• Sesuaikan tema dan ukuran teks\n'
                '• Dukungan mode gelap',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Pertanyaan Umum',
            'T: Apakah aplikasi ini gratis?\n'
                'J: Ya, aplikasi ini gratis untuk digunakan.\n\n'
                'T: Apakah saya perlu koneksi internet?\n'
                'J: Ya, Anda memerlukan koneksi internet untuk menggunakan fitur AI.\n\n'
                'T: Apakah data saya aman?\n'
                'J: Ya, kami tidak menyimpan data pribadi Anda.',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Kontak Kami',
            'Jika Anda memiliki pertanyaan atau masukan, silakan hubungi kami:\n\n'
                'Email: support@indonesai.com\n'
                'Twitter: @IndonesAI\n'
                'Telegram: @IndonesAI_Support',
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Tentang Kami',
            'IndonesAI dikembangkan oleh tim Indonesia untuk membantu masyarakat Indonesia '
                'dalam mengakses teknologi AI dengan cara yang lebih personal dan sesuai '
                'dengan budaya lokal.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.indonesianRed,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
