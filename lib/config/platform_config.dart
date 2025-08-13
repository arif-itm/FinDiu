/// Platform-specific configurations for FinDiu
class PlatformConfig {
  // Android Configuration
  static const Map<String, dynamic> android = {
    'applicationId': 'com.findiu.app',
    'minSdkVersion': 21,
    'targetSdkVersion': 34,
    'compileSdkVersion': 34,
    'buildToolsVersion': '34.0.0',
    'ndkVersion': '25.1.8937393',
    'proguardEnabled': true,
    'signedApk': true,
    'playStoreCategory': 'FINANCE',
    'permissions': [
      'android.permission.INTERNET',
      'android.permission.ACCESS_NETWORK_STATE',
      'android.permission.CAMERA', // For receipt scanning
      'android.permission.USE_BIOMETRIC', // For biometric auth
      'android.permission.USE_FINGERPRINT', // Fallback for older devices
    ],
  };

  // iOS Configuration
  static const Map<String, dynamic> ios = {
    'bundleIdentifier': 'com.findiu.app',
    'deploymentTarget': '12.0',
    'targetName': 'Runner',
    'infoPlistVersion': '1.0',
    'appStoreCategory': 'Finance',
    'capabilities': [
      'Face ID',
      'Touch ID',
      'Camera',
      'Network',
    ],
    'permissions': [
      'NSCameraUsageDescription',
      'NSFaceIDUsageDescription',
    ],
  };

  // Web Configuration
  static const Map<String, dynamic> web = {
    'title': 'FinDiu - Smart Money, Smarter Students',
    'description': 'Smart Money, Smarter Students - Your AI-Powered Financial Companion for Secure & Simple Money Management',
    'baseHref': '/',
    'renderer': 'html', // or 'canvaskit'
    'serviceWorker': true,
    'offlineCapable': true,
    'installable': true,
    'categories': ['finance', 'productivity', 'education'],
    'screenshots': [
      {
        'src': 'screenshots/desktop-dashboard.png',
        'sizes': '1920x1080',
        'type': 'image/png',
        'form_factor': 'wide',
        'label': 'Dashboard view on desktop'
      },
      {
        'src': 'screenshots/mobile-dashboard.png',
        'sizes': '390x844',
        'type': 'image/png',
        'form_factor': 'narrow',
        'label': 'Dashboard view on mobile'
      }
    ],
  };

  // Windows Configuration
  static const Map<String, dynamic> windows = {
    'packageName': 'FinDiu',
    'publisherName': 'FinDiu Team',
    'packageVersion': '1.0.0.0',
    'minimumWindowsVersion': '10.0.17763.0',
    'targetDeviceFamily': 'Windows.Universal',
    'capabilities': [
      'internetClient',
      'picturesLibrary',
      'documentsLibrary',
    ],
  };

  // macOS Configuration
  static const Map<String, dynamic> macos = {
    'bundleIdentifier': 'com.findiu.app',
    'deploymentTarget': '10.14',
    'category': 'public.app-category.finance',
    'copyright': 'Copyright © 2024 FinDiu Team. All rights reserved.',
    'permissions': [
      'NSCameraUsageDescription',
      'NSDocumentsFolderUsageDescription',
    ],
  };

  // Linux Configuration
  static const Map<String, dynamic> linux = {
    'applicationId': 'com.findiu.app',
    'executableName': 'findiu',
    'genericName': 'Finance Manager',
    'comment': 'Smart Money Management for Students',
    'categories': ['Finance', 'Office', 'Utility'],
    'mimeTypes': [
      'application/x-findiu-backup',
      'text/csv',
    ],
    'startupNotify': true,
  };

  // Build Configuration
  static const Map<String, dynamic> buildConfig = {
    'flutter': {
      'minVersion': '3.8.1',
      'channel': 'stable',
    },
    'dart': {
      'minVersion': '3.8.1',
    },
    'targets': {
      'android': {
        'apk': true,
        'appbundle': true,
        'architectures': ['arm64-v8a', 'armeabi-v7a', 'x86_64'],
      },
      'ios': {
        'ipa': true,
        'architectures': ['arm64'],
      },
      'web': {
        'pwa': true,
        'seo': true,
        'responsive': true,
      },
      'desktop': {
        'windows': true,
        'macos': true,
        'linux': true,
      },
    },
  };

  // Development Configuration
  static const Map<String, dynamic> development = {
    'hotReload': true,
    'debugMode': true,
    'debugBanner': true,
    'performanceOverlay': false,
    'showSemanticsDebugger': false,
    'checkerboardRasterCacheImages': false,
    'checkerboardOffscreenLayers': false,
  };

  // Production Configuration
  static const Map<String, dynamic> production = {
    'obfuscation': true,
    'treeShaking': true,
    'minification': true,
    'compression': true,
    'analytics': true,
    'crashReporting': true,
    'performanceMonitoring': true,
  };

  // Store Listings
  static const Map<String, dynamic> storeListing = {
    'googlePlay': {
      'title': 'FinDiu - Smart Student Finance',
      'shortDescription': 'AI-powered money management for students',
      'fullDescription': '''
Transform your financial future with FinDiu, the smart money management app designed specifically for students and young adults.

🎯 WHY FINDIU?
• AI-powered insights tailored for student life
• Simple expense tracking that actually works
• Smart savings goals you can achieve
• Secure data protection you can trust
• Beautiful, intuitive design

💡 KEY FEATURES
• Automatic expense categorization
• Budget recommendations based on your habits
• Savings challenges and goal tracking
• Financial education content
• Multi-platform sync across all devices
• Bank-level security and privacy

🎓 PERFECT FOR STUDENTS
Whether you're managing a tight budget, saving for spring break, or learning financial responsibility, FinDiu makes money management as easy as your favorite social media app.

Join thousands of students who are already building better financial habits with FinDiu!
      ''',
      'keywords': 'student finance, budget tracker, expense manager, savings goals, money management, financial planning, student budget, AI finance',
      'category': 'FINANCE',
      'contentRating': 'Everyone',
      'targetAudience': ['YOUNG_ADULTS', 'STUDENTS'],
    },
    'appStore': {
      'title': 'FinDiu: Smart Student Finance',
      'subtitle': 'AI-Powered Money Management',
      'description': '''
FinDiu transforms how students manage money with AI-powered insights, smart budgeting tools, and an intuitive interface designed for the next generation of financially responsible adults.

FEATURES THAT MAKE A DIFFERENCE:
• Smart expense tracking with AI categorization
• Personalized budget recommendations
• Achievement-based savings goals
• Financial education content
• Cross-platform synchronization
• Bank-level security

Perfect for college students, young professionals, and anyone starting their financial journey. Download FinDiu and take control of your financial future today!
      ''',
      'keywords': 'student,finance,budget,money,savings,expense,tracker,AI',
      'category': 'Finance',
      'contentRating': '4+',
    },
  };
}
