class AppConstants {
  // Informasi Aplikasi
  static const String appName = 'IndonesAI';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Asisten AI Bahasa Indonesia';

  // Label Navigasi
  static const String chatLabel = 'Obrolan';
  static const String settingsLabel = 'Pengaturan';
  static const String profileLabel = 'Profil';
  static const String helpLabel = 'Bantuan';

  // Layar Obrolan
  static const String messageHint = 'Tulis pesan Anda di sini...';
  static const String sendButton = 'Kirim';
  static const String typingIndicator = 'AI sedang mengetik...';
  static const String clearChat = 'Hapus Obrolan';
  static const String copyMessage = 'Salin Pesan';
  static const String messageCopied = 'Pesan disalin';
  static const String welcomeMessage =
      'Halo! Saya asisten AI Indonesia Anda. Ada yang bisa saya bantu?';
  static const String noMessages = 'Belum ada pesan. Mulai mengobrol sekarang!';

  // Layar Pengaturan
  static const String themeSettings = 'Tema Aplikasi';
  static const String darkMode = 'Mode Gelap';
  static const String lightMode = 'Mode Terang';
  static const String systemMode = 'Ikuti Sistem';
  static const String fontSizeSettings = 'Ukuran Teks';
  static const String smallFont = 'Kecil';
  static const String mediumFont = 'Sedang';
  static const String largeFont = 'Besar';
  static const String languageSettings = 'Bahasa';
  static const String indonesian = 'Bahasa Indonesia';
  static const String voiceSettings = 'Pengaturan Suara';
  static const String enableVoice = 'Aktifkan Suara';
  static const String voiceSpeed = 'Kecepatan Suara';
  static const String voicePitch = 'Nada Suara';

  // Layar Profil
  static const String editProfile = 'Ubah Profil';
  static const String savedChats = 'Obrolan Tersimpan';
  static const String preferences = 'Preferensi';
  static const String about = 'Tentang Aplikasi';
  static const String logout = 'Keluar';
  static const String deleteAccount = 'Hapus Akun';

  // Pesan Error
  static const String errorGeneric =
      'Maaf, terjadi kesalahan. Silakan coba lagi.';
  static const String errorConnection =
      'Koneksi internet terputus. Periksa koneksi Anda.';
  static const String errorAPI =
      'Gagal terhubung dengan AI. Silakan coba lagi.';
  static const String errorTimeout =
      'Waktu permintaan habis. Silakan coba lagi.';

  // Pesan Sukses
  static const String settingsSaved = 'Pengaturan berhasil disimpan';
  static const String profileUpdated = 'Profil berhasil diperbarui';

  // Konfirmasi
  static const String confirmDelete = 'Anda yakin ingin menghapus?';
  static const String confirmLogout = 'Anda yakin ingin keluar?';
  static const String yes = 'Ya';
  static const String no = 'Tidak';
  static const String cancel = 'Batal';

  // API
  static const String apiBaseUrl = 'https://api.openai.com/v1';
  static const String apiModel = 'gpt-3.5-turbo';
  static const int maxTokens = 2000;

  // Kunci Shared Preferences
  static const String themeKey = 'app_theme';
  static const String fontSizeKey = 'font_size';
  static const String languageKey = 'language';
  static const String voiceKey = 'voice_enabled';
  static const String voiceSpeedKey = 'voice_speed';
  static const String voicePitchKey = 'voice_pitch';
}
