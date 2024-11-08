import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChatHistoryDrawer extends StatelessWidget {
  const ChatHistoryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 56, bottom: 24),
              color: AppTheme.primaryRed,
              child: const Center(
                child: Text(
                  'Riwayat Obrolan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // TODO: Replace with actual chat history
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Percakapan ${index + 1}',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: subtextColor),
                      onPressed: () {
                        // TODO: Implement delete chat history
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement clear all chat history
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  foregroundColor: AppTheme.primaryRed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32, 
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: AppTheme.primaryRed),
                  ),
                ),
                child: const Text('Hapus Semua Riwayat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
