import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/widgets/legacy.transition.promo.dialog.dart';

/// Decides whether to show the Legacy Transition Plan promo dialog and
/// caps it at 3 displays per ISO calendar week. The week-of-year and
/// year are stored alongside the count so the counter rolls over
/// automatically when the week changes — no scheduled cleanup needed.
class PLegacyTransitionPromoService {
  PLegacyTransitionPromoService._internal();
  static final PLegacyTransitionPromoService _instance =
      PLegacyTransitionPromoService._internal();
  factory PLegacyTransitionPromoService() => _instance;

  static const String _weekKey = 'legacy_transition_promo_week';
  static const String _yearKey = 'legacy_transition_promo_year';
  static const String _countKey = 'legacy_transition_promo_count';
  static const String _lastShownKey = 'legacy_transition_promo_last_shown';

  /// Maximum displays per ISO week.
  static const int _maxPerWeek = 3;

  /// Minimum days between consecutive displays.
  static const int _minDaysBetweenShows = 1;

  final _storage = GetStorage();

  /// True while a promo dialog is on screen. Synchronous re-entry guard
  /// for the window between deciding to show and actually awaiting the
  /// dialog — without this, a rebuild storm could queue multiple dialogs
  /// before the storage timestamp lands.
  bool _isShowing = false;

  /// Shows the promo dialog if the weekly cap hasn't been reached AND
  /// at least [_minDaysBetweenShows] days have passed since the last
  /// display. Increments the stored counter on display.
  Future<void> showIfEligible(BuildContext context) async {
    if (_isShowing) return;

    final now = DateTime.now();
    final week = _isoWeekOfYear(now);
    final year = _isoWeekYear(now);

    final storedWeek = _storage.read<int>(_weekKey);
    final storedYear = _storage.read<int>(_yearKey);
    final storedCount = _storage.read<int>(_countKey) ?? 0;

    final inSameWeek = storedWeek == week && storedYear == year;
    final count = inSameWeek ? storedCount : 0;

    if (count >= _maxPerWeek) {
      pensionAppLogger.i(
        'Legacy promo skipped: $count/$_maxPerWeek shown this week',
      );
      return;
    }

    final lastShownMs = _storage.read<int>(_lastShownKey);
    if (lastShownMs != null) {
      final lastShown = DateTime.fromMillisecondsSinceEpoch(lastShownMs);
      final hoursSince = now.difference(lastShown).inHours;
      if (hoursSince < _minDaysBetweenShows * 24) {
        pensionAppLogger.i(
          'Legacy promo skipped: only ${hoursSince}h since last show '
          '(min ${_minDaysBetweenShows * 24}h)',
        );
        return;
      }
    }

    if (!context.mounted) return;
    _isShowing = true;
    _storage.write(_weekKey, week);
    _storage.write(_yearKey, year);
    _storage.write(_countKey, count + 1);
    _storage.write(_lastShownKey, now.millisecondsSinceEpoch);
    try {
      await showLegacyTransitionPromoDialog(context);
    } finally {
      _isShowing = false;
    }
  }

  /// ISO 8601 week number (1–53). Mirrors the algorithm used by most
  /// date libraries: weeks start on Monday and the week containing
  /// the year's first Thursday is week 1.
  int _isoWeekOfYear(DateTime date) {
    final thursday = date.add(Duration(days: 4 - _isoWeekday(date)));
    final firstThursday = DateTime(thursday.year, 1, 4);
    final firstThursdayOffset = DateTime(
      firstThursday.year,
      1,
      1,
    ).add(Duration(days: 4 - _isoWeekday(firstThursday)));
    final diffDays = thursday.difference(firstThursdayOffset).inDays;
    return 1 + (diffDays / 7).floor();
  }

  /// The ISO week-numbering year for [date], which can differ from the
  /// calendar year around year boundaries (e.g. 2026-01-01 may belong
  /// to ISO week 53 of 2025).
  int _isoWeekYear(DateTime date) {
    final thursday = date.add(Duration(days: 4 - _isoWeekday(date)));
    return thursday.year;
  }

  /// 1=Monday … 7=Sunday.
  int _isoWeekday(DateTime date) => date.weekday;
}
