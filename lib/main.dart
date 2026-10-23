import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/themes/app_fonts.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFonts.registerLicenses();
  await EasyLocalization.ensureInitialized();
  // Alert texts format times ("٢:٤١ ص") outside the widget tree.
  await initializeDateFormatting();
  final cache = await SimpleCache.create();

  runApp(
    ProviderScope(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
      child: const App(),
    ),
  );
}
