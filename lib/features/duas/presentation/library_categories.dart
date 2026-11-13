import 'package:flutter/painting.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// How each Library shelf is labelled and tinted, as in the design.
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

  Color get tileColor => switch (this) {
    LibraryCategory.morning || LibraryCategory.lastThird => AppColors.greenPale,
    LibraryCategory.evening => AppColors.honeyPale,
    LibraryCategory.mathur || LibraryCategory.saved => AppColors.paperWarm,
  };
}
