import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

/// The location prayer times are calculated for; null until onboarding sets
/// it. Stored on the device only.
@Riverpod(keepAlive: true)
class LocationController extends _$LocationController {
  @override
  SavedLocation? build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.location);
    return saved == null
        ? null
        : SavedLocation.fromJson(jsonDecode(saved) as Json);
  }

  Future<void> save(SavedLocation location) async {
    state = location;
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.location, jsonEncode(location.toJson()));
  }
}
