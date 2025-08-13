#!/bin/bash

# FinDiu Multi-Platform Build Script
# This script builds FinDiu for all supported platforms

echo "🚀 FinDiu Multi-Platform Build Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Check Flutter doctor
print_status "Checking Flutter doctor..."
flutter doctor

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean
flutter pub get

# Generate app icons
print_status "Generating app icons..."
flutter pub run flutter_launcher_icons

# Build directory
BUILD_DIR="builds"
mkdir -p $BUILD_DIR

print_status "Starting multi-platform build process..."

# Build for Android
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Building for Android..."
    
    # APK
    print_status "Building Android APK..."
    if flutter build apk --release; then
        cp build/app/outputs/flutter-apk/app-release.apk $BUILD_DIR/findiu-android.apk
        print_success "Android APK built successfully"
    else
        print_error "Failed to build Android APK"
    fi
    
    # App Bundle
    print_status "Building Android App Bundle..."
    if flutter build appbundle --release; then
        cp build/app/outputs/bundle/release/app-release.aab $BUILD_DIR/findiu-android.aab
        print_success "Android App Bundle built successfully"
    else
        print_error "Failed to build Android App Bundle"
    fi
fi

# Build for iOS (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Building for iOS..."
    if flutter build ios --release --no-codesign; then
        print_success "iOS build completed successfully"
        print_warning "Note: iOS build requires code signing for distribution"
    else
        print_error "Failed to build for iOS"
    fi
fi

# Build for Web
print_status "Building for Web..."
if flutter build web --release; then
    cp -r build/web $BUILD_DIR/web
    print_success "Web build completed successfully"
else
    print_error "Failed to build for Web"
fi

# Build for Windows (Windows only)
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    print_status "Building for Windows..."
    if flutter build windows --release; then
        cp -r build/windows/x64/runner/Release $BUILD_DIR/windows
        print_success "Windows build completed successfully"
    else
        print_error "Failed to build for Windows"
    fi
fi

# Build for macOS (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Building for macOS..."
    if flutter build macos --release; then
        cp -r build/macos/Build/Products/Release/findiu.app $BUILD_DIR/
        print_success "macOS build completed successfully"
    else
        print_error "Failed to build for macOS"
    fi
fi

# Build for Linux (Linux only)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_status "Building for Linux..."
    if flutter build linux --release; then
        cp -r build/linux/x64/release/bundle $BUILD_DIR/linux
        print_success "Linux build completed successfully"
    else
        print_error "Failed to build for Linux"
    fi
fi

# Summary
echo ""
echo "📋 Build Summary"
echo "================"
print_status "Build artifacts saved in: $BUILD_DIR/"

ls -la $BUILD_DIR/

echo ""
print_success "Multi-platform build process completed!"
echo ""
echo "🎉 FinDiu is ready for deployment across all platforms!"
echo "   Smart Money, Smarter Students - Your AI-Powered Financial Companion"
