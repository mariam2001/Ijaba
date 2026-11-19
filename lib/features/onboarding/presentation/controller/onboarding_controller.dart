import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

/// Whether the user has finished onboarding (Language → Permissions).
@Riverpod(keepAlive: true)
class OnboardingController extends _$OnboardingController {
  @override
  bool build() =>
      ref.watch(SimpleCache.provider).read(CacheKey.onboardingDone) == 'true';

  Future<void> complete() async {
    state = true;
    final cache = ref.read(SimpleCache.provider);
    await cache.write(CacheKey.onboardingDone, 'true');
    // Home welcomes them, once (Figma "Warm moments").
    await cache.write(CacheKey.welcomePending, 'true');
  }
}
