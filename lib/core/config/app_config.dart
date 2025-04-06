class AppConfig {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    // Add initialization logic here
    // Example: Firebase, Maps API key, etc.

    _initialized = true;
  }

  // API endpoints
  static const String baseUrl = 'https://api.joolaspot.com';

  // Feature flags
  static const bool enableBackgroundLocation = false;
  static const bool enablePhotoUpload = false;

  // App settings
  static const int courtSearchRadius = 50; // kilometers
  static const int maxPhotosPerCourt = 5;
}
