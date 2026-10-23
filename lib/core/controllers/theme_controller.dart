import 'package:flutter/material.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

/// Light by default; the design's "night mode" (auto after Maghrib) will
/// drive this once prayer times exist. It deliberately ignores the OS
/// dark-mode setting.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.themeMode);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(SimpleCache.provider).write(CacheKey.themeMode, mode.name);
  }
}
