import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                AppConstants.profileLabel,
                style: TextStyle(
                  color: AppTheme.indonesianWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.indonesianRed,
                      AppTheme.indonesianRed.withOpacity(0.8),
                    ],
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.indonesianWhite,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppTheme.indonesianRed,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                context: context,
                title: AppConstants.preferences,
                items: [
                  _buildListTile(
                    context: context,
                    icon: Icons.translate,
                    title: AppConstants.languageSettings,
                    subtitle: AppConstants.indonesian,
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.record_voice_over,
                    title: AppConstants.voiceSettings,
                    subtitle: AppConstants.enableVoice,
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                ],
              ),
              _buildSection(
                context: context,
                title: AppConstants.savedChats,
                items: [
                  _buildListTile(
                    context: context,
                    icon: Icons.history,
                    title: 'Riwayat Obrolan',
                    subtitle: 'Lihat obrolan sebelumnya',
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.bookmark,
                    title: 'Obrolan Favorit',
                    subtitle: 'Obrolan yang ditandai',
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                ],
              ),
              _buildSection(
                context: context,
                title: AppConstants.about,
                items: [
                  _buildListTile(
                    context: context,
                    icon: Icons.info_outline,
                    title: 'Tentang ${AppConstants.appName}',
                    subtitle: 'Versi ${AppConstants.appVersion}',
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Kebijakan Privasi',
                    subtitle: 'Informasi penggunaan data',
                    onTap: () {
                      // Akan diimplementasikan nanti
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Akan diimplementasikan nanti
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                    foregroundColor: AppTheme.indonesianRed,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    AppConstants.logout,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Widget> items,
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
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.indonesianRed),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
