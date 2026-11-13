import 'package:flutter/painting.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// How each Library shelf is labelled, drawn and tinted.
extension LibraryCategoryLabels on LibraryCategory {
  String get titleKey => switch (this) {
    LibraryCategory.morning => LocaleKeys.library_morning,
    LibraryCategory.evening => LocaleKeys.library_evening,
    LibraryCategory.lastThird => LocaleKeys.library_last_third,
    LibraryCategory.mathur => LocaleKeys.library_mathur,
    LibraryCategory.saved => LocaleKeys.library_saved,
  };

  /// Plural key for "23 adhkar" / "7 duas" / "3 saved".
  String get countKey => switch (this) {
    LibraryCategory.morning ||
    LibraryCategory.evening => LocaleKeys.library_adhkar_count,
    LibraryCategory.lastThird ||
    LibraryCategory.mathur => LocaleKeys.library_duas_count,
    LibraryCategory.saved => LocaleKeys.library_saved_count,
  };

  AppIcon get icon => switch (this) {
    LibraryCategory.morning => AppIcon.morning,
    LibraryCategory.evening => AppIcon.evening,
    LibraryCategory.lastThird => AppIcon.lastThird,
    LibraryCategory.mathur => AppIcon.duaHands,
    LibraryCategory.saved => AppIcon.saved,
  };

  /// Honey for morning, evening and saved; green for the last third and
  /// the ma'thur duas.
  bool get _honey => switch (this) {
    LibraryCategory.morning ||
    LibraryCategory.evening ||
    LibraryCategory.saved => true,
    LibraryCategory.lastThird || LibraryCategory.mathur => false,
  };

  Color get tileColor => _honey ? AppColors.honeyPale : AppColors.greenPale;

  Color get iconColor => _honey ? AppColors.honey : AppColors.green;
}
