import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final cache = await SimpleCache.create();

  runApp(
    ProviderScope(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
      child: const App(),
    ),
  );
}
