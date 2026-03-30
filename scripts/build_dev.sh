#!/bin/bash

# Old Mutual Pensions - DEV Build Script
# Builds APK, App Bundle, or IPA for the DEV flavor
# Usage:
#   ./scripts/build_dev.sh apk
#   ./scripts/build_dev.sh appbundle
#   ./scripts/build_dev.sh ipa

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

FLAVOR="dev"
TARGET="${1:-apk}"

if [[ ! "$TARGET" =~ ^(apk|appbundle|ipa)$ ]]; then
  echo -e "${RED}Usage: $0 <apk|appbundle|ipa>${NC}"
  exit 1
fi

VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //')
VERSION_NAME=$(echo "$VERSION" | cut -d'+' -f1)
VERSION_CODE=$(echo "$VERSION" | cut -d'+' -f2)

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Old Mutual Pensions - ${YELLOW}DEV${BLUE} Build${NC}"
echo -e "${BLUE}  API: ${YELLOW}test-app.oldmutual.com.gh${NC}"
echo -e "${BLUE}  Target:  ${GREEN}$TARGET${NC}"
echo -e "${BLUE}  Version: ${GREEN}$VERSION_NAME+$VERSION_CODE${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${YELLOW}Cleaning previous builds...${NC}"
flutter clean

echo -e "${YELLOW}Getting dependencies...${NC}"
flutter pub get

echo -e "${YELLOW}Running build_runner...${NC}"
dart run build_runner build --delete-conflicting-outputs

case "$TARGET" in
  apk)
    echo -e "\n${GREEN}Building DEV APK...${NC}"
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
      echo -e "${GREEN}DEV APK built successfully ($SIZE): $APK_PATH${NC}"
    else
      echo -e "${RED}DEV APK build failed!${NC}"
      exit 1
    fi
    ;;

  appbundle)
    echo -e "\n${GREEN}Building DEV App Bundle...${NC}"
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
      echo -e "${GREEN}DEV App Bundle built successfully ($SIZE): $AAB_PATH${NC}"
    else
      echo -e "${RED}DEV App Bundle build failed!${NC}"
      exit 1
    fi
    ;;

  ipa)
    echo -e "\n${GREEN}Building DEV IPA...${NC}"
    flutter build ipa \
      --release \
      --flavor "$FLAVOR" \
      --obfuscate \
      --split-debug-info=build/ios/symbols \
      --build-name="$VERSION_NAME" \
      --build-number="$VERSION_CODE"

    echo -e "${GREEN}DEV iOS archive built successfully.${NC}"
    echo -e "${YELLOW}Open Xcode Organizer to distribute.${NC}"
    ;;
esac

echo -e "\n${GREEN}================================================${NC}"
echo -e "${GREEN}  DEV build complete! ($TARGET)${NC}"
echo -e "${GREEN}================================================${NC}"
