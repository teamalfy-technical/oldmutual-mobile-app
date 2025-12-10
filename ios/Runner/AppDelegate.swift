import Flutter
import UIKit
import flutter_local_notifications
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  // Privacy overlay view to hide sensitive content in app switcher
  private var privacyOverlayView: UIView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
  }

  // MARK: - App Switcher Privacy Protection

  override func applicationWillResignActive(_ application: UIApplication) {
    // Add privacy overlay when app goes to background/app switcher
    showPrivacyOverlay()
    super.applicationWillResignActive(application)
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    // Remove privacy overlay when app becomes active
    hidePrivacyOverlay()
    super.applicationDidBecomeActive(application)
  }

  private func showPrivacyOverlay() {
    guard privacyOverlayView == nil, let window = self.window else { return }

    // Create a blur effect overlay
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = window.bounds
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    // Add app logo/icon in center (optional - creates a branded privacy screen)
    let logoImageView = UIImageView(image: UIImage(named: "AppIcon"))
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    logoImageView.center = blurView.contentView.center
    blurView.contentView.addSubview(logoImageView)

    window.addSubview(blurView)
    privacyOverlayView = blurView
  }

  private func hidePrivacyOverlay() {
    privacyOverlayView?.removeFromSuperview()
    privacyOverlayView = nil
  }

}
