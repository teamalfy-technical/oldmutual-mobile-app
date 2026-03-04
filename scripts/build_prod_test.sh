#!/bin/bash

# Old Mutual Pensions - PROD (Test Environment) Build Script
# Builds a PROD flavor APK, App Bundle, or IPA pointing to the TEST API
# Usage:
#   ./scripts/build_prod_test.sh apk
#   ./scripts/build_prod_test.sh appbundle
#   ./scripts/build_prod_test.sh ipa

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

FLAVOR="prod"
TARGET="${1:-apk}"
FLAVOR_CONFIG="lib/flavor.config.dart"

if [[ ! "$TARGET" =~ ^(apk|appbundle|ipa)$ ]]; then
  echo -e "${RED}Usage: $0 <apk|appbundle|ipa>${NC}"
  exit 1
fi

VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //')
VERSION_NAME=$(echo "$VERSION" | cut -d'+' -f1)
VERSION_CODE=$(echo "$VERSION" | cut -d'+' -f2)

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Old Mutual Pensions - ${MAGENTA}PROD (TEST ENV)${BLUE} Build${NC}"
echo -e "${BLUE}  Flavor: ${MAGENTA}prod${NC}"
echo -e "${BLUE}  API:    ${MAGENTA}test-app.oldmutual.com.gh${NC}"
echo -e "${BLUE}  Target:  ${GREEN}$TARGET${NC}"
echo -e "${BLUE}  Version: ${GREEN}$VERSION_NAME+$VERSION_CODE${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${MAGENTA}================================================${NC}"
echo -e "${MAGENTA}  NOTE: This is a PROD build using the TEST API.${NC}"
echo -e "${MAGENTA}  The app will look and behave like production${NC}"
echo -e "${MAGENTA}  but will connect to test-app.oldmutual.com.gh${NC}"
echo -e "${MAGENTA}================================================${NC}"
echo ""
read -p "Continue with PROD (Test Env) build? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${YELLOW}Build cancelled.${NC}"
  exit 0
fi

# Swap prod API URL to test API URL
echo -e "${YELLOW}Switching prod API to test environment...${NC}"
sed -i '' 's|const apiBaseUrlProd = "https://app.oldmutual.com.gh/api";|const apiBaseUrlProd = "https://test-app.oldmutual.com.gh/api";|' "$FLAVOR_CONFIG"

# Restore the original URL on exit (success or failure)
restore_config() {
  echo -e "${YELLOW}Restoring prod API URL...${NC}"
  sed -i '' 's|const apiBaseUrlProd = "https://test-app.oldmutual.com.gh/api";|const apiBaseUrlProd = "https://app.oldmutual.com.gh/api";|' "$FLAVOR_CONFIG"
}
trap restore_config EXIT

echo -e "${YELLOW}Cleaning previous builds...${NC}"
flutter clean

echo -e "${YELLOW}Getting dependencies...${NC}"
flutter pub get

echo -e "${YELLOW}Running build_runner...${NC}"
dart run build_runner build --delete-conflicting-outputs

case "$TARGET" in
  apk)
    echo -e "\n${GREEN}Building PROD (Test Env) APK...${NC}"
    flutter build apk \
      --release \
      --flavor "$FLAVOR" \
      --obfuscate \
      --split-debug-info=build/app/outputs/symbols \
      --build-name="$VERSION_NAME" \
      --build-number="$VERSION_CODE"

    APK_PATH="build/app/outputs/flutter-apk/app-${FLAVOR}-release.apk"
    if [ -f "$APK_PATH" ]; then
      SIZE=$(du -h "$APK_PATH" | cut -f1)
      echo -e "${GREEN}PROD (Test Env) APK built successfully ($SIZE): $APK_PATH${NC}"
    else
      echo -e "${RED}PROD (Test Env) APK build failed!${NC}"
      exit 1
    fi
    ;;

  appbundle)
    echo -e "\n${GREEN}Building PROD (Test Env) App Bundle...${NC}"
    flutter build appbundle \
      --release \
      --flavor "$FLAVOR" \
      --obfuscate \
      --split-debug-info=build/app/outputs/symbols \
      --build-name="$VERSION_NAME" \
      --build-number="$VERSION_CODE"

    AAB_PATH="build/app/outputs/bundle/${FLAVOR}Release/app-${FLAVOR}-release.aab"
    if [ -f "$AAB_PATH" ]; then
      SIZE=$(du -h "$AAB_PATH" | cut -f1)
      echo -e "${GREEN}PROD (Test Env) App Bundle built successfully ($SIZE): $AAB_PATH${NC}"
    else
      echo -e "${RED}PROD (Test Env) App Bundle build failed!${NC}"
      exit 1
    fi
    ;;

  ipa)
    echo -e "\n${GREEN}Building PROD (Test Env) IPA...${NC}"
    flutter build ipa \
      --release \
      --flavor "$FLAVOR" \
      --obfuscate \
      --split-debug-info=build/ios/symbols \
      --build-name="$VERSION_NAME" \
      --build-number="$VERSION_CODE"

    echo -e "${GREEN}PROD (Test Env) iOS archive built successfully.${NC}"
    echo -e "${YELLOW}Open Xcode Organizer to distribute.${NC}"
    ;;
esac

echo -e "\n${GREEN}================================================${NC}"
echo -e "${GREEN}  PROD (Test Env) build complete! ($TARGET)${NC}"
echo -e "${GREEN}================================================${NC}"
