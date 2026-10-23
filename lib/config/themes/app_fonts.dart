import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract final class AppFonts {
  /// All UI text.
  static const readexPro = 'ReadexPro';

  /// Quranic / dua text and big Arabic titles.
  static const amiri = 'Amiri';

  /// The bundled fonts are OFL-licensed, which requires shipping the license;
  /// this also lists them on Flutter's licenses page (Settings → About).
  static void registerLicenses() {
    LicenseRegistry.addLicense(() async* {
      for (final font in const [amiri, readexPro]) {
        final license = await rootBundle.loadString(
          'assets/fonts/OFL-$font.txt',
        );
        yield LicenseEntryWithLineBreaks([font], license);
      }
    });
  }
}
