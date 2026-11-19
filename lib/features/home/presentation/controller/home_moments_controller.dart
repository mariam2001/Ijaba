import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/home/data/reminders.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_moments_controller.g.dart';

/// Which reminder Home's card opens on: the next one each time the app
/// starts (a keep-alive provider is built once per run).
@Riverpod(keepAlive: true)
int reminderStart(Ref ref) {
  final cache = ref.read(SimpleCache.provider);
  final last = int.tryParse(cache.read(CacheKey.reminderIndex) ?? '') ?? -1;
  final next = (last + 1) % reminders.length;
  cache.write(CacheKey.reminderIndex, '$next');
  return next;
}

/// The welcome card at the end of onboarding (Figma "Warm moments"): shown
/// on Home the first time after onboarding, until tapped away, and not on
/// later runs.
@Riverpod(keepAlive: true)
class WelcomeCard extends _$WelcomeCard {
  @override
  bool build() {
    final cache = ref.read(SimpleCache.provider);
    final pending = cache.read(CacheKey.welcomePending) == 'true';
    if (pending) cache.delete(CacheKey.welcomePending);
    return pending;
  }

  void dismiss() => state = false;
}
