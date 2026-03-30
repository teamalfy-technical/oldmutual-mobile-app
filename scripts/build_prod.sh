#!/bin/bash

# Old Mutual Pensions - PROD Build Script
# Builds APK, App Bundle, or IPA for the PROD flavor
# Usage:
#   ./scripts/build_prod.sh apk
#   ./scripts/build_prod.sh appbundle
#   ./scripts/build_prod.sh ipa

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

FLAVOR="prod"
TARGET="${1:-apk}"

if [[ ! "$TARGET" =~ ^(apk|appbundle|ipa)$ ]]; then
  echo -e "${RED}Usage: $0 <apk|appbundle|ipa>${NC}"
  exit 1
fi

VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //')
VERSION_NAME=$(echo "$VERSION" | cut -d'+' -f1)
VERSION_CODE=$(echo "$VERSION" | cut -d'+' -f2)

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Old Mutual Pensions - ${RED}PROD${BLUE} Build${NC}"
echo -e "${BLUE}  API: ${RED}app.oldmutual.com.gh${NC}"
echo -e "${BLUE}  Target:  ${GREEN}$TARGET${NC}"
echo -e "${BLUE}  Version: ${GREEN}$VERSION_NAME+$VERSION_CODE${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${RED}================================================${NC}"
echo -e "${RED}  WARNING: You are building for PRODUCTION!${NC}"
echo -e "${RED}  This will point to the LIVE API.${NC}"
echo -e "${RED}================================================${NC}"
echo ""
read -p "Continue with PROD build? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${YELLOW}Build cancelled.${NC}"
  exit 0
fi

echo -e "${YELLOW}Cleaning previous builds...${NC}"
flutter clean

echo -e "${YELLOW}Getting dependencies...${NC}"
flutter pub get

echo -e "${YELLOW}Running build_runner...${NC}"
dart run build_runner build --delete-conflicting-outputs

case "$TARGET" in
  apk)
    echo -e "\n${GREEN}Building PROD APK...${NC}"
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
      echo -e "${GREEN}PROD APK built successfully ($SIZE): $APK_PATH${NC}"
    else
      echo -e "${RED}PROD APK build failed!${NC}"
      exit 1
    fi
    ;;

  appbundle)
    echo -e "\n${GREEN}Building PROD App Bundle...${NC}"
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
      echo -e "${GREEN}PROD App Bundle built successfully ($SIZE): $AAB_PATH${NC}"
    else
      echo -e "${RED}PROD App Bundle build failed!${NC}"
      exit 1
    fi
    ;;

  ipa)
    echo -e "\n${GREEN}Building PROD IPA...${NC}"
    flutter build ipa \
      --release \
      --flavor "$FLAVOR" \
      --obfuscate \
      --split-debug-info=build/ios/symbols \
      --build-name="$VERSION_NAME" \
      --build-number="$VERSION_CODE"

    echo -e "${GREEN}PROD iOS archive built successfully.${NC}"
    echo -e "${YELLOW}Open Xcode Organizer to distribute.${NC}"
    ;;
esac

echo -e "\n${GREEN}================================================${NC}"
echo -e "${GREEN}  PROD build complete! ($TARGET)${NC}"
echo -e "${GREEN}================================================${NC}"
