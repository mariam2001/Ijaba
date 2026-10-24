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
    await ref.read(SimpleCache.provider).write(CacheKey.onboardingDone, 'true');
  }
}
