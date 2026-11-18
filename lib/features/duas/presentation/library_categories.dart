import 'package:flutter/widgets.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// How each Library shelf is labelled, drawn and tinted.
extension LibraryCategoryLabels on LibraryCategory {
  String get titleKey => switch (this) {
    LibraryCategory.morning => LocaleKeys.library_morning,
    LibraryCategory.evening => LocaleKeys.library_evening,
    LibraryCategory.sleep => LocaleKeys.library_sleep,
    LibraryCategory.waking => LocaleKeys.library_waking,
    LibraryCategory.lastThird => LocaleKeys.library_last_third,
    LibraryCategory.mathur => LocaleKeys.library_mathur,
    LibraryCategory.saved => LocaleKeys.library_saved,
  };

  /// Plural key for "23 adhkar" / "7 duas" / "3 saved".
  String get countKey => switch (this) {
    LibraryCategory.morning ||
    LibraryCategory.evening ||
    LibraryCategory.sleep ||
    LibraryCategory.waking => LocaleKeys.library_adhkar_count,
    LibraryCategory.lastThird ||
    LibraryCategory.mathur => LocaleKeys.library_duas_count,
    LibraryCategory.saved => LocaleKeys.library_saved_count,
  };

  /// Its glyph at [size], tinted [color]: the handover's icons, and
  /// Lucide's sun for waking (the handover's sunrise is the morning's).
  Widget icon({required double size, required Color color}) {
    final asset = switch (this) {
      LibraryCategory.morning => AppIcon.morning,
      LibraryCategory.evening => AppIcon.evening,
      LibraryCategory.sleep => AppIcon.sleep,
      LibraryCategory.waking => null,
      LibraryCategory.lastThird => AppIcon.lastThird,
      LibraryCategory.mathur => AppIcon.duaHands,
      LibraryCategory.saved => AppIcon.saved,
    };
    return asset == null
        ? Icon(LucideIcons.sun300, size: size, color: color)
        : AppIconView(asset, size: size, color: color);
  }

  /// Honey for the daytime adhkar, waking and saved; green for sleep, the
  /// last third and the ma'thur duas.
  bool get _honey => switch (this) {
    LibraryCategory.morning ||
    LibraryCategory.evening ||
    LibraryCategory.waking ||
    LibraryCategory.saved => true,
    LibraryCategory.sleep ||
    LibraryCategory.lastThird ||
    LibraryCategory.mathur => false,
  };

  Color tileColor(AppColors colors) =>
      _honey ? colors.honeyPale : colors.greenPale;

  Color iconColor(AppColors colors) => _honey ? colors.honey : colors.greenInk;
}
