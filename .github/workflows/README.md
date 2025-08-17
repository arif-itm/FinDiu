# GitHub Actions Workflows

This repository includes automated GitHub Actions workflows for building and releasing the FinDiu Flutter application.

## Workflows

### 1. CI - Build and Test (`ci.yml`)

**Triggers:**
- Push to `main`, `flutter`, or `develop` branches
- Pull requests to `main` or `flutter` branches

**What it does:**
- Runs Flutter analysis and tests
- Builds web version
- Builds Android APK
- Uploads build artifacts for download

### 2. Build and Release (`build-and-release.yml`)

**Triggers:**
- Push of version tags (e.g., `v1.0.0`)
- Manual trigger via GitHub Actions UI

**What it does:**
- Builds web version and packages it as a ZIP
- Builds Android APK
- Creates a GitHub release with downloadable assets

## How to Create a Release

### Method 1: Using Git Tags (Recommended)

1. Update the version in `pubspec.yaml`
2. Commit your changes
3. Create and push a version tag:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. The workflow will automatically trigger and create a release

### Method 2: Manual Trigger

1. Go to the "Actions" tab in your GitHub repository
2. Select "Build and Release Flutter App"
3. Click "Run workflow"
4. Enter the version number (e.g., `1.0.0`)
5. Click "Run workflow"

## Build Artifacts

The workflows generate the following artifacts:

- **Android APK**: `findiu-v{version}-release.apk` - Ready to install on Android devices
- **Web Build**: `findiu-v{version}-web.zip` - Extract and deploy to any web server

## Prerequisites

Make sure your repository has:
- Valid `pubspec.yaml` file
- All Flutter dependencies properly configured
- Tests that pass (if any exist)
- Proper Android build configuration

## Customization

You can customize the workflows by:
- Modifying the trigger conditions
- Adding additional build targets (iOS, macOS, etc.)
- Changing the release notes template
- Adding deployment steps
- Configuring code signing for production releases

## Notes

- The workflows use the stable Flutter channel
- Web builds use the HTML renderer for better compatibility
- APK builds are unsigned (suitable for testing, not production Play Store)
- For production releases, consider adding code signing and other security measures
