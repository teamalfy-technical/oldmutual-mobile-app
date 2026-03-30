import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// Service that manages in-app review prompts following platform best practices:
/// - Only prompts after the user has opened the app a minimum number of times
/// - Rate-limits review requests to once every 90 days
/// - Checks device/store availability before requesting
/// - Increments app open count on each initialization
class PInAppReviewService {
  PInAppReviewService._internal();
  static final PInAppReviewService _instance = PInAppReviewService._internal();
  factory PInAppReviewService() => _instance;

  static const String _appOpenCountKey = 'in_app_review_open_count';
  static const String _lastReviewRequestKey = 'in_app_review_last_request';

  /// Minimum app opens before prompting for review
  static const int _minAppOpens = 5;

  /// Minimum days between review requests
  static const int _minDaysBetweenRequests = 90;

  final _storage = GetStorage();
  final _inAppReview = InAppReview.instance;

  /// Initialize the service and increment app open count.
  Future<void> init() async {
    _incrementAppOpenCount();
  }

  void _incrementAppOpenCount() {
    final currentCount = _storage.read<int>(_appOpenCountKey) ?? 0;
    _storage.write(_appOpenCountKey, currentCount + 1);
  }

  int get _appOpenCount => _storage.read<int>(_appOpenCountKey) ?? 0;

  DateTime? get _lastReviewRequest {
    final timestamp = _storage.read<int>(_lastReviewRequestKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Request an in-app review if all conditions are met.
  /// Call this after the user has landed on a key screen (e.g., home page).
  Future<void> requestReviewIfEligible() async {
    if (!_isEligible()) return;

    try {
      final isAvailable = await _inAppReview.isAvailable();
      if (!isAvailable) {
        pensionAppLogger.i('In-app review not available on this device');
        return;
      }

      await _inAppReview.requestReview();
      _storage.write(
        _lastReviewRequestKey,
        DateTime.now().millisecondsSinceEpoch,
      );
      pensionAppLogger.i('In-app review requested successfully');
    } catch (e) {
      pensionAppLogger.e('In-app review request failed: $e');
    }
  }

  bool _isEligible() {
    // Never prompt in debug mode
    if (kDebugMode) return false;

    // Must have enough app opens
    if (_appOpenCount < _minAppOpens) {
      pensionAppLogger.i(
        'In-app review skipped: only $_appOpenCount/$_minAppOpens opens',
      );
      return false;
    }

    // Rate-limit: check days since last request
    final lastRequest = _lastReviewRequest;
    if (lastRequest != null) {
      final daysSince = DateTime.now().difference(lastRequest).inDays;
      if (daysSince < _minDaysBetweenRequests) {
        pensionAppLogger.i(
          'In-app review skipped: only $daysSince/$_minDaysBetweenRequests days since last request',
        );
        return false;
      }
    }

    return true;
  }
}
