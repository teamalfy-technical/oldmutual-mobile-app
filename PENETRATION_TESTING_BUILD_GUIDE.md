# Penetration Testing Build Guide
## Old Mutual Pensions Mobile App

This guide explains how to build two versions of the app for penetration testing:
1. **Protected Version** - Regular production build with all security features enabled
2. **Unprotected Version** - Build with security features disabled for penetration testing

---

## Security Features Analysis

### Current Security Posture

Based on codebase analysis, the following security features are currently implemented:

#### ✅ Implemented Security Features:
- **Secure Storage**: FlutterSecureStorage with encrypted SharedPreferences (Android) and Keychain (iOS)
- **HTTPS Enforcement**: All API endpoints use HTTPS
- **Environment Variable Obfuscation**: Using `@Envied` with obfuscation
- **Token-based Authentication**: Bearer tokens stored securely
- **Biometric Authentication**: Face ID/Touch ID/Fingerprint support

#### ❌ NOT Currently Implemented:
- **Root/Jailbreak Detection**: No root or jailbreak detection library found
- **SSL Pinning**: No SSL certificate pinning configured
- **Code Obfuscation**: Not currently enabled in build configuration (now added)

---

## Build Configurations

### 1. Protected Version (Production Build)

This is the regular production build that will be distributed on app stores.

#### Features:
- ✅ Code obfuscation enabled (ProGuard/R8)
- ✅ Resource shrinking enabled
- ✅ Secure storage for sensitive data
- ✅ HTTPS-only communication
- ✅ Release signing
- ❌ Not debuggable

#### Android Build Commands:

**For Production (dev flavor):**
```bash
flutter build apk --release --flavor dev --obfuscate --split-debug-info=build/app/outputs/symbols
```

**For Production (prod flavor):**
```bash
flutter build apk --release --flavor prod --obfuscate --split-debug-info=build/app/outputs/symbols
```

**Output Location:**
- APK: `build/app/outputs/flutter-apk/app-dev-release.apk`
- Symbols: `build/app/outputs/symbols/` (needed for crash reports)

#### iOS Build Commands:

**For Production:**
```bash
# Build archive
flutter build ios --release --obfuscate --split-debug-info=build/ios/symbols

# Then use Xcode to archive and export:
# 1. Open ios/Runner.xcworkspace in Xcode
# 2. Product > Archive
# 3. Export IPA for distribution
```

---

### 2. Unprotected Version (Penetration Testing)

This version has all security features disabled to facilitate penetration testing.

#### Features:
- ❌ Code obfuscation DISABLED
- ❌ Resource shrinking DISABLED
- ✅ Debuggable enabled
- ✅ Same functionality as production
- ✅ Signed with same release keys
- ⚠️ Clearly marked as "pentest" version

#### Android Build Commands:

**For Pentest (dev flavor):**
```bash
flutter build apk --build-name 2.0.0-pentest --build-number 42 --flavor dev --dart-define=PENTEST_MODE=true
```

**For Pentest (prod flavor):**
```bash
flutter build apk --build-name 2.0.0-pentest --build-number 42 --flavor prod --dart-define=PENTEST_MODE=true
```

**Alternative using custom build type:**
```bash
cd android
./gradlew assembleDevPentest
./gradlew assembleProdPentest
cd ..
```

**Output Location:**
- APK: `build/app/outputs/flutter-apk/app-dev-pentest.apk`
- Package name: `com.oldmutual.pensions.app.dev.pentest`

#### iOS Build (Pentest):

**Note**: iOS requires creating a separate scheme for pentest builds

```bash
# Build unobfuscated debug version with release configuration
flutter build ios --release --no-obfuscate --flavor prod
```

---

## Detailed Build Steps

### Prerequisites

1. **Flutter SDK**: Ensure Flutter is installed and up-to-date
   ```bash
   flutter doctor -v
   ```

2. **Signing Keys**:
   - Android: Ensure `android/key.properties` exists with valid keystore info
   - iOS: Valid provisioning profiles in Xcode

3. **Dependencies**:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

---

### Building Protected Version (Step-by-Step)

#### Android Protected Build:

```bash
# 1. Clean previous builds
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Generate required files (env, assets, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Build PROTECTED APK with obfuscation
flutter build apk --release --flavor prod --obfuscate --split-debug-info=build/app/outputs/symbols

# 5. Verify the build
ls -lh build/app/outputs/flutter-apk/

# 6. Rename for clarity
cp build/app/outputs/flutter-apk/app-prod-release.apk \
   build/OldMutual_Pensions_v2.0.0_PROTECTED.apk
```

#### iOS Protected Build:

```bash
# 1. Clean previous builds
flutter clean

# 2. Get dependencies
flutter pub get
cd ios && pod install && cd ..

# 3. Build with obfuscation
flutter build ios --release --obfuscate --split-debug-info=build/ios/symbols

# 4. Open Xcode to create archive
open ios/Runner.xcworkspace

# In Xcode:
# - Select "Any iOS Device" as target
# - Product > Archive
# - Distribute App > Export IPA
# - Save as: OldMutual_Pensions_v2.0.0_PROTECTED.ipa
```

---

### Building Unprotected Version (Step-by-Step)

#### Android Unprotected Build:

```bash
# 1. Clean previous builds
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Generate required files
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Build UNPROTECTED APK (no obfuscation)
cd android
./gradlew assembleProdPentest
cd ..

# Alternative method:
# flutter build apk --build-name 2.0.0-pentest --build-number 42 --flavor prod --dart-define=PENTEST_MODE=true

# 5. Verify the build
ls -lh android/app/build/outputs/apk/prod/pentest/

# 6. Rename for clarity
cp android/app/build/outputs/apk/prod/pentest/app-prod-pentest.apk \
   build/OldMutual_Pensions_v2.0.0_UNPROTECTED_PENTEST.apk
```

#### iOS Unprotected Build:

```bash
# 1. Clean previous builds
flutter clean

# 2. Get dependencies
flutter pub get
cd ios && pod install && cd ..

# 3. Build WITHOUT obfuscation
flutter build ios --release --no-obfuscate

# 4. Open Xcode
open ios/Runner.xcworkspace

# In Xcode:
# - Change Build Configuration to "Release"
# - Ensure GCC_OPTIMIZATION_LEVEL is set to "-O0" for pentest
# - Product > Archive
# - Export IPA
# - Save as: OldMutual_Pensions_v2.0.0_UNPROTECTED_PENTEST.ipa
```

---

## Verification Checklist

### Protected Version:
- [ ] APK/IPA size is smaller than unprotected version
- [ ] Code is obfuscated (check with APK analyzer or class-dump)
- [ ] Debug symbols are stripped
- [ ] Package name: `com.oldmutual.pensions.app` (prod)
- [ ] Version name: `2.0.0`
- [ ] isDebuggable: false

### Unprotected Version:
- [ ] APK/IPA size is larger than protected version
- [ ] Code is NOT obfuscated (readable class names)
- [ ] Debug symbols are present
- [ ] Package name: `com.oldmutual.pensions.app.pentest` (Android)
- [ ] Version name: `2.0.0-pentest`
- [ ] isDebuggable: true

---

## Verification Commands

### Android APK Analysis:

```bash
# Check if obfuscated
unzip -l build/OldMutual_Pensions_v2.0.0_PROTECTED.apk | grep "classes.dex"

# Verify package info
aapt dump badging build/OldMutual_Pensions_v2.0.0_PROTECTED.apk | grep "package:"

# Check if debuggable
aapt dump badging build/OldMutual_Pensions_v2.0.0_PROTECTED.apk | grep "debuggable"
```

### iOS IPA Analysis:

```bash
# Extract and check Info.plist
unzip OldMutual_Pensions_v2.0.0_PROTECTED.ipa
plutil -p Payload/Runner.app/Info.plist

# Check for debug symbols
ls -la Payload/Runner.app/
```

---

## File Naming Convention

Use this naming convention for the penetration test deliverables:

**Protected Version:**
- Android: `OldMutual_Pensions_v2.0.0+42_PROTECTED_Android.apk`
- iOS: `OldMutual_Pensions_v2.0.0+42_PROTECTED_iOS.ipa`

**Unprotected Version:**
- Android: `OldMutual_Pensions_v2.0.0+42_UNPROTECTED_PENTEST_Android.apk`
- iOS: `OldMutual_Pensions_v2.0.0+42_UNPROTECTED_PENTEST_iOS.ipa`

---

## Important Notes

### Security Features NOT Present:

Since the following features are **not currently implemented** in the codebase, you don't need to disable them:

1. ❌ **Root/Jailbreak Detection** - Not implemented
   - No libraries like `flutter_jailbreak_detection`, `freeRASP`, or `safe_device` found

2. ❌ **SSL Pinning** - Not configured
   - No certificate pinning in Dio client
   - No `SecurityContext` with pinned certificates found

3. ✅ **Code Obfuscation** - NOW CONFIGURED
   - Added ProGuard/R8 configuration
   - Enabled in protected builds, disabled in pentest builds

### What Makes Them Different:

| Feature | Protected Build | Unprotected Build |
|---------|----------------|-------------------|
| Code Obfuscation | ✅ Enabled | ❌ Disabled |
| Resource Shrinking | ✅ Enabled | ❌ Disabled |
| Debuggable | ❌ False | ✅ True |
| Symbols | 🗑️ Stripped | ✅ Included |
| ProGuard/R8 | ✅ Applied | ❌ Not Applied |
| Package Suffix | None | `.pentest` |

---

## Troubleshooting

### Build Fails with Signing Error:
```bash
# Verify key.properties exists
cat android/key.properties

# Check keystore file path is correct
ls -la /path/to/keystore.jks
```

### Gradle Build Issues:
```bash
cd android
./gradlew clean
./gradlew --refresh-dependencies
cd ..
flutter clean
flutter pub get
```

### iOS Provisioning Issues:
- Ensure you have valid provisioning profiles in Xcode
- Check Bundle Identifier matches your App ID
- Verify signing certificate is valid

---

## Delivery Package

Create a ZIP file containing both versions:

```bash
# Create delivery directory
mkdir -p pentest_delivery

# Copy APKs
cp build/OldMutual_Pensions_v2.0.0+42_PROTECTED_Android.apk pentest_delivery/
cp build/OldMutual_Pensions_v2.0.0+42_UNPROTECTED_PENTEST_Android.apk pentest_delivery/

# Copy IPAs (if available)
cp OldMutual_Pensions_v2.0.0+42_PROTECTED_iOS.ipa pentest_delivery/
cp OldMutual_Pensions_v2.0.0+42_UNPROTECTED_PENTEST_iOS.ipa pentest_delivery/

# Create README
echo "Protected Version: Regular production build with obfuscation
Unprotected Version: Pentest build without obfuscation
Build Date: $(date)
Flutter Version: $(flutter --version | head -1)" > pentest_delivery/README.txt

# Create ZIP
zip -r OldMutual_Pensions_PenTest_Builds_$(date +%Y%m%d).zip pentest_delivery/
```

---

## Contact

For questions about the build process, contact the development team.

**Build Date**: November 27, 2025
**App Version**: 2.0.0 (Build 42)
**Flutter Version**: 3.8.1+
