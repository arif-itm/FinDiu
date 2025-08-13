/// App configuration and constants for FinDiu
class AppConfig {
  // App Identity
  static const String appName = 'FinDiu';
  static const String appSlogan = 'Smart Money, Smarter Students';
  static const String appDescription = 'Your AI-Powered Financial Companion for Secure & Simple Money Management';
  static const String appTagline = 'Simple • Smart • Secure';
  
  // Enhanced AI-Generated Slogans (alternatives)
  static const List<String> alternativeSlogans = [
    'Empowering Students, One Smart Dollar at a Time',
    'Where Financial Intelligence Meets Student Life',
    'Your Personal Finance Professor in Your Pocket',
    'Building Tomorrow\'s Financial Leaders Today',
    'Smart Budgets, Brighter Futures',
    'Making Money Management as Easy as Learning',
  ];
  
  // App Identity Details
  static const String packageName = 'com.findiu.app';
  static const String version = '1.0.0';
  static const int buildNumber = 1;
  
  // Brand Colors
  static const int primaryColorValue = 0xFF2563EB; // Blue-600
  static const int secondaryColorValue = 0xFF10B981; // Emerald-500
  static const int accentColorValue = 0xFFF59E0B; // Amber-500
  
  // Assets
  static const String logoPath = 'assets/logos/logo.png';
  static const String imagesPath = 'assets/images/';
  
  // Platform Support
  static const List<String> supportedPlatforms = [
    'Android',
    'iOS', 
    'Web',
    'Windows',
    'macOS',
    'Linux'
  ];
  
  // Features
  static const List<String> keyFeatures = [
    'AI-Powered Expense Tracking',
    'Smart Budget Recommendations',
    'Savings Goal Management',
    'Secure Data Protection',
    'Student-Friendly Interface',
    'Real-time Analytics',
    'Multi-Platform Sync',
  ];
  
  // Target Audience
  static const String targetAudience = 'Students and Young Adults';
  static const String ageRange = '16-25 years';
  
  // App Store Information
  static const String category = 'Finance & Education';
  static const List<String> keywords = [
    'financial management',
    'student budget',
    'money tracking',
    'expense tracker',
    'savings goals',
    'AI finance',
    'budget planner',
    'student finance',
    'money management',
    'personal finance',
  ];
  
  // Social & Support
  static const String supportEmail = 'support@findiu.com';
  static const String website = 'https://findiu.com';
  static const String privacyPolicy = 'https://findiu.com/privacy';
  static const String termsOfService = 'https://findiu.com/terms';
}

/// App theme configuration
class AppTheme {
  static const String fontFamily = 'Inter';
  
  // Light Theme Colors
  static const Map<String, int> lightColors = {
    'primary': 0xFF2563EB,
    'secondary': 0xFF10B981,
    'accent': 0xFFF59E0B,
    'background': 0xFFFFFFFF,
    'surface': 0xFFF8FAFC,
    'error': 0xFFEF4444,
    'success': 0xFF10B981,
    'warning': 0xFFF59E0B,
    'text': 0xFF1E293B,
    'textSecondary': 0xFF64748B,
  };
  
  // Dark Theme Colors
  static const Map<String, int> darkColors = {
    'primary': 0xFF3B82F6,
    'secondary': 0xFF34D399,
    'accent': 0xFFFBBF24,
    'background': 0xFF0F172A,
    'surface': 0xFF1E293B,
    'error': 0xFFF87171,
    'success': 0xFF34D399,
    'warning': 0xFFFBBF24,
    'text': 0xFFF1F5F9,
    'textSecondary': 0xFF94A3B8,
  };
}
