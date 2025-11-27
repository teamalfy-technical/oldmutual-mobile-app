# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase Crashlytics
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Dio
-keep class com.squareup.okhttp3.** { *; }
-dontwarn com.squareup.okhttp3.**

# Keep annotations
-keepattributes *Annotation*

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep model classes (adjust package name as needed)
-keep class com.oldmutual.pensions.app.** { *; }

# Flutter wrapper
-dontwarn io.flutter.embedding.**
