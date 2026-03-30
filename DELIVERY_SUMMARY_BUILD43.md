# Penetration Test Delivery - Build 43
## Old Mutual Pensions Mobile Application

**Date:** November 27, 2025
**Version:** 2.0.0 (Build 43)
**Platform:** Android

---

## ✅ PACKAGE READY FOR DELIVERY

### Package Information
- **Filename:** `OldMutual_Pensions_PenTest_Builds_v2.0.0_Build43_20251127.zip`
- **Size:** 82 MB (compressed)
- **Location:** `/Users/icode/FlutterProjects/oldmutual_pensions_app/`
- **SHA-256:** `f67a9bc8c545b388c73513870fbb33a0003c55b7054731b0cb6928681eac267e`

---

## 📦 Package Contents

```
OldMutual_Pensions_PenTest_Builds_v2.0.0_Build43_20251127.zip (82 MB)
└── pentest_delivery/
    ├── OldMutual_Pensions_v2.0.0+43_PROTECTED.apk (69 MB)
    │   ✅ Code Obfuscation: ENABLED
    │   ✅ Resource Shrinking: ENABLED
    │   ✅ Production-Ready Build
    │
    ├── OldMutual_Pensions_v2.0.0+43_UNPROTECTED_PENTEST.apk (74 MB)
    │   ❌ Code Obfuscation: DISABLED
    │   ❌ Resource Shrinking: DISABLED
    │   ✅ Pentest-Friendly Build
    │
    ├── CHECKSUMS.txt
    │   - SHA-256 checksums for both APKs
    │
    ├── README.txt
    │   - Installation instructions
    │   - Security features overview
    │   - Testing recommendations
    │
    └── BUILD_COMPARISON.md
        - Technical comparison
        - Build commands used
        - Testing guidelines
```

---

## 🔐 APK Checksums (SHA-256)

### Protected Version:
```
b36ad2624381b93e90bf2b5d028c22655c8c24769dbccd9855983841b9f491c0
OldMutual_Pensions_v2.0.0+43_PROTECTED.apk
```

### Unprotected Version:
```
69e42fa36ce406debc10587e8c0cab32cd7a78eab1119a37ed729212666a0553
OldMutual_Pensions_v2.0.0+43_UNPROTECTED_PENTEST.apk
```

### Verify Checksums:
```bash
# After extracting the ZIP
cd pentest_delivery/
shasum -a 256 -c CHECKSUMS.txt
```

---

## 📊 Build Specifications

### Protected Version
| Property | Value |
|----------|-------|
| **File Size** | 69 MB |
| **Version** | 2.0.0 (Build 43) |
| **Obfuscation** | ✅ Enabled (R8/ProGuard) |
| **Shrinking** | ✅ Enabled |
| **Package** | com.oldmutual.pensions.app |
| **Purpose** | Production release candidate |

**Build Command:**
```bash
flutter build apk --release --flavor prod \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --build-name=2.0.0 \
  --build-number=43
```

### Unprotected Version
| Property | Value |
|----------|-------|
| **File Size** | 74 MB (+5 MB vs protected) |
| **Version** | 2.0.0-pentest (Build 43) |
| **Obfuscation** | ❌ Disabled |
| **Shrinking** | ❌ Disabled |
| **Package** | com.oldmutual.pensions.app |
| **Purpose** | Penetration testing |

**Build Command:**
```bash
flutter build apk --release --flavor prod \
  --no-obfuscate \
  --build-name=2.0.0-pentest \
  --build-number=43
```

---

## 🔒 Security Features Status

### ✅ Implemented (Both Versions)
1. **Secure Storage**
   - FlutterSecureStorage with AES encryption
   - Encrypted SharedPreferences (Android)
   - Location: `lib/core/utils/local.storage/secure.storage.dart`

2. **HTTPS Communication**
   - All API endpoints use HTTPS
   - Base URL: `https://app.oldmutual.com.gh/api`
   - No insecure HTTP connections

3. **Token-based Authentication**
   - Bearer token authentication
   - Tokens stored in secure storage
   - Location: `lib/core/network/helpers/dio.client.dart`

4. **Biometric Authentication**
   - Fingerprint/Face ID support
   - Using `local_auth` package

5. **Environment Variable Protection**
   - Using `@Envied` with obfuscation
   - No hardcoded API keys

### ❌ NOT Implemented (Both Versions)
1. **Root Detection** - No library implemented
2. **SSL Certificate Pinning** - Not configured
3. **Anti-tampering** - No runtime integrity checks
4. **Screen Capture Prevention** - Screenshots allowed

### 🔄 Different Between Versions
- **Code Obfuscation**: Enabled in Protected, Disabled in Unprotected
- **File Size**: Protected is 7% smaller due to shrinking

---

## ⚠️ Known Vulnerabilities (Intentionally NOT Fixed)

These issues are **intentionally left unfixed** for the penetration test:

### Medium Severity
1. **Sensitive Data Logging**
   - File: `lib/core/network/helpers/dio.client.dart:46-56`
   - Issue: Authorization headers and payloads logged
   - Impact: Token exposure in logs

2. **Unencrypted File Storage**
   - File: `lib/core/utils/helpers/helper.functions.dart:258-303`
   - Issue: Downloaded PDFs not encrypted
   - Impact: Sensitive documents accessible

### Low Severity
3. **Migration Flag Not Persisted**
4. **Debug Print Statements**
5. **WebView URL Validation Missing**

---

## 📋 Installation & Testing

### Install APKs
```bash
# Via ADB
adb install pentest_delivery/OldMutual_Pensions_v2.0.0+43_PROTECTED.apk
adb install pentest_delivery/OldMutual_Pensions_v2.0.0+43_UNPROTECTED_PENTEST.apk

# Note: Installing one will replace the other (same package name)
```

### Recommended Tools
- **Proxy:** Burp Suite, Charles Proxy
- **Decompilation:** APKTool, dex2jar, JD-GUI
- **Static Analysis:** MobSF, QARK
- **Dynamic Analysis:** Frida, objection
- **Device:** Rooted Android device recommended

### Testing Focus Areas
1. Authentication & Session Management
2. Data Storage Security
3. Network Communication
4. Sensitive Data Exposure
5. Business Logic Vulnerabilities

---

## 🎯 Delivery Checklist

- [x] Protected APK built with obfuscation (Build 43)
- [x] Unprotected APK built without obfuscation (Build 43)
- [x] Both APKs signed with release keys
- [x] File sizes verified (69 MB vs 74 MB)
- [x] SHA-256 checksums generated
- [x] Documentation created (README.txt, BUILD_COMPARISON.md)
- [x] Package compressed to ZIP
- [x] Final package checksum generated
- [x] Known vulnerabilities documented

---

## 📊 Expected Timeline

| Phase | Duration | Description |
|-------|----------|-------------|
| **Setup** | 1 day | Installation, tool setup, test accounts |
| **Testing** | 5-7 days | Comprehensive security assessment |
| **Reporting** | 2-3 days | Documentation and proof-of-concepts |
| **Total** | **1-2 weeks** | Complete pentest cycle |

---

## 🔄 Post-Pentest Action Plan

1. **Review** (Week 1)
   - Receive and analyze pentest report
   - Compare findings with internal audit
   - Prioritize vulnerabilities

2. **Remediation** (Weeks 2-3)
   - Fix critical and high-severity issues
   - Address medium-severity findings
   - Review low-severity items

3. **Verification** (Week 4)
   - Internal QA testing
   - Code review of security fixes
   - Request retest if needed

4. **Deployment** (Week 5)
   - Build hardened production version
   - Security regression testing
   - Deploy to Play Store

---

## 📞 Contact & Support

**For Testing Questions:**
- Coordinate with development team for test credentials
- Establish communication channel
- Report critical findings immediately

**For Technical Issues:**
- Build-related questions
- API access problems
- Backend connectivity issues

---

## ✅ Summary

### What's Ready:
✅ Two fully functional APKs (Protected & Unprotected)
✅ Complete documentation package
✅ Checksums for integrity verification
✅ Build 43 with latest codebase
✅ Same vulnerabilities in both versions
✅ Professional delivery package

### What's Different:
🔄 Only code obfuscation (Protected: ON, Unprotected: OFF)
🔄 File size (Protected: 69 MB, Unprotected: 74 MB)
🔄 Version name (Protected: 2.0.0, Unprotected: 2.0.0-pentest)

### What's NOT Changed:
✅ Same functionality
✅ Same vulnerabilities
✅ Same package name
✅ Same security features
✅ Same backend APIs

---

## 🚀 Ready for Delivery!

**Package Location:**
```
/Users/icode/FlutterProjects/oldmutual_pensions_app/
OldMutual_Pensions_PenTest_Builds_v2.0.0_Build43_20251127.zip
```

**Transfer the ZIP file to your penetration testing team and you're all set!**

---

*Document Generated: November 27, 2025*
*Build Number: 43*
*Flutter Version: 3.8.1+*
*Package Verified: ✅*
