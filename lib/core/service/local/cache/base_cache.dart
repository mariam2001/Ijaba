import 'package:ijaba/core/utils/enums.dart';

abstract interface class BaseCache {
  String? read(CacheKey key);

  Future<void> write(CacheKey key, String value);

  Future<void> delete(CacheKey key);

  /// Removes every [CacheKey] this app stores, leaving other entries intact.
  Future<void> clear();
}
