import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/service/local/cache/base_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// On-device key/value storage for settings. Values are loaded once at
/// startup by [create], so reads are synchronous.
class SimpleCache implements BaseCache {
  const SimpleCache(this._preferences);

  /// Overridden in `main()` with the instance returned by [create].
  static final provider = Provider<BaseCache>(
    (ref) =>
        throw UnimplementedError('Override SimpleCache.provider in main()'),
  );

  static Future<SimpleCache> create() async => SimpleCache(
    await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: CacheKey.values.map((key) => key.name).toSet(),
      ),
    ),
  );

  final SharedPreferencesWithCache _preferences;

  @override
  String? read(CacheKey key) => _preferences.getString(key.name);

  @override
  Future<void> write(CacheKey key, String value) =>
      _preferences.setString(key.name, value);

  @override
  Future<void> delete(CacheKey key) => _preferences.remove(key.name);

  @override
  Future<void> clear() => _preferences.clear();
}
