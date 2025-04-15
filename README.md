# Pensions Mobile App

---

## Getting Started 🚀

Pensions App is a digital platform that allows users to manage their retirement savings efficiently. It provides a secure and user-friendly interface for individuals to track their pension contributions, monitor investment growth, and plan for their future financial security.

## Update generated files

dart run build_runner build --delete-conflicting-outputs

## Update generated files if error occurs

flutter clean && flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs

## Build APK for Production

flutter build apk --flavor prod

## Build AppBundle for Production

flutter build appbundle --flavor prod

## Project Structure 📁

This document provides an overview of our Flutter project's folder structure to ensure consistency and maintainability.

## Root Directory

```
lib/
├── env/
├── gen/
├── src/
├── main.dart
```

### main.dart

- Entry point of the app where the root widget is defined.
- Handling initialization logic as well

## Commons Directory

- Consist of all resusable animation, constant and other widgets used acrossed the app

## Env Directory

The `env` directory contains configuration API endpoints, secrets, and environment viarables.

```
lib/env/
├── env.dart
├── env.g.dart
```

## Gen Directory

The `gen` directory contains configuration generated fonts and assets files for app configuration.

```
lib/gen/
├── assets.gen.dart
├── fonts.gen.dart
```

## Src Directory

The `src` directory contains all the sources files for the project, including assets, font, networking, ui, data, etc. files.

```
lib/src/
├── commons/
├── core/
├── features/
├── localization/
├── routes/
├── utils/
```

## Commons Directory

The `commons` directory contains all resuable widgets or components utilized across all parts of the app.

```
lib/src/
│ └── commons/
```

## Core Directory

The `core` directory contains configuration files, API endpoints, exceptions, injections (bindings) and network.

```
lib/core/
├── bindings/
├── errors/
├── network/
```

### bindings (injections)

- Defines custom class to perform dependency injection for the application.

### errors

- Defines custom exception classes for the application.

### network

- Contains utility classes, wrappers for network calls.

## Localization Directory

The `localization` directory contains configuration all messages or texts for localization and internationalization.

```
lib/src/
├── localization/
├──     └── messages.dart
```

## Routes Directory

The `routes` directory contains all named routes used in this projects.

```
lib/src/
│ └── routes/
│     └── app.pages.dart
│     └── app.routes.dart
```

## Utils Directory

The `utils` directory contains all utility files including device util, formatters, helpers, validators, local storage (sharedpreferences), loggers and app theme utilized across all parts of the app.

```
lib/src/
│ └── utils/
```

## Data Directory

The `data` directory contains localization files.

```
lib/data/
├── local/
└── remote/
└── data_source/
└── helpers/
└── mappers/
└── repository/
└── service/
└── wrappers/
```

## Features Directory

The `features` directory contains the presentation layer, that is where all UI logic is written.

```
lib/src/features
├── alert/
└── auth/
└── categories/
└── customer/
└── dashboard/
├── history/
├── product/
└── settings/
└── today.sales/
├── transaction/
├── webview/
├── welcome/
```

## Common Directory in each featured folder

### application

- #### service
  - Consist of the abstract classes and it's implementation which services as a bridge between the view model and UI.

### data

- #### ds (Data source)
  - Consist of the abstract classes and it's implementation where all endpoints are defined. It serves as a source of truth
    for all data coming in from outside the app.
- #### repo (Repository)
  - Consist of the abstract classes and it's implementation for handling api errors. This is a layer between the repository
    and the services providing data to the service.

### domain

- #### models
  This includes entity models in the domain layer.
- #### vw (ViewModel)
  This includes business logic in the domain layer.

### presentation

- #### pages
  This includes ui widgets of each feature in the presentation layer.
- #### widgets
  This includes reusable widgets used in each corresponding feature in the presentation layer.

# Guidelines for Development 📝

## Naming Conventions 📛

- **File Names**: Use `dot.case` for file names.
- **Class Names**: Use `PascalCase` for class names.
- **Variable Names**: Use `camelCase` for variable names.
- **Constants**: Use `camelCase` for constants.

## Code Style 🎨

- **Formatting**: Have to check all warnings and errors before pushing the code.
- **User Font, Color, and Size Constants**: from `utils` && `constants` folder
- **Use messages**: for all the strings in the app.

# **IOS APP BUILD AND DEPLOYMENT GUIDES**

This document outlines the professional build process and deployment steps for deploying an iOS app.

---

## **Prerequisites**

### **Requirements**

1. **Apple Developer Account**
   - A valid Apple Developer account enrolled in the Apple Developer Program.
2. **macOS Environment**
   - A Mac machine with the latest macOS version.
3. **Xcode**
   - Install the latest stable version of Xcode from the Mac App Store.
4. **App Assets**
   - Complete app icons, launch screen assets, and other necessary media in the required resolutions.
5. **Provisioning Profiles and Certificates**
   - Generate appropriate provisioning profiles and certificates in the Apple Developer Console.

---

## **Build Process**

### **1. Setup Xcode Project**

1. Open your project in Xcode.
2. Ensure all app resources (e.g., icons, launch screens, assets) are added correctly.
3. Verify the **Bundle Identifier** in `General > Identity` matches the identifier created in the Apple Developer Console.

### **2. Configure Signing & Capabilities**

1. Navigate to `Signing & Capabilities`.
2. Enable **Automatically manage signing**.
3. Select your Apple Developer team.
4. Ensure the correct provisioning profiles and certificates are applied.

### **3. Build and Test the App**

1. Select the appropriate target (e.g., Development or Release).
2. Connect a physical device or use the iOS Simulator.
3. Build and run the `Pensions App` app (`Cmd + R`) to ensure it compiles and runs without issues.

---

## **Testing**

### **1. Test on Physical Devices**

- Test `Pensions App` app on various physical devices to confirm compatibility and performance.

### **2. Distribute via TestFlight**

1. **Archive the App**:
   - Go to `Product > Archive` in Xcode.
2. **Upload to App Store Connect**:
   - Open the **Organizer** window in Xcode.
   - Select the archived build and click **Distribute App**.
   - Choose **App Store Connect** > **Upload**.
3. **Set Up TestFlight**:
   - Log in to [App Store Connect](https://appstoreconnect.apple.com/).
   - Navigate to `Sumundi Keepsales`, go to the **TestFlight** tab, and add internal/external testers.
4. **Apple Review for External Testing**:
   - Submit the build for review if inviting external testers.

---

## **Deployment to App Store**

### **1. Prepare for App Submission**

1. Update the app version in Xcode (`General > Identity > Version`).
2. Upload the latest build assets (screenshots, descriptions, keywords, etc.) in App Store Connect.

### **2. Submit Build for Review**

1. Archive `Pensions App` app using `Product > Archive`.
2. Distribute `Pensions App` app:
   - Select **App Store Connect** > **Submit for Review**.
3. Assign the uploaded build to the desired version in App Store Connect.
4. Fill in necessary metadata and compliance information (e.g., age rating, export compliance).

### **3. Wait for Apple Review**

- Apple reviews typically take 1-3 business days. Address any feedback promptly.

### **4. Publish the App**

- Once approved, release the `Pensions App` to the App Store.
