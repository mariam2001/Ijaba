import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/core/service/local/cache/base_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/features/location/data/datasource/location_service.dart';
import 'package:ijaba/features/onboarding/data/datasource/device_power_settings.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';

class MemoryCache implements BaseCache {
  final _values = <CacheKey, String>{};

  @override
  String? read(CacheKey key) => _values[key];

  @override
  Future<void> write(CacheKey key, String value) async => _values[key] = value;

  @override
  Future<void> delete(CacheKey key) async => _values.remove(key);

  @override
  Future<void> clear() async => _values.clear();
}

/// Both permissions granted; records what gets scheduled.
class FakeNotifications extends Fake implements NotificationService {
  final scheduled = <({int id, String title, bool quiet})>[];

  @override
  Future<bool> notificationsEnabled() async => true;

  @override
  Future<bool> canScheduleExactAlarms() async => true;

  @override
  Future<void> ensureChannels({
    required String name,
    required String quietName,
  }) async {}

  @override
  Future<void> cancelWindowAlerts() async => scheduled.clear();

  @override
  Future<void> schedule({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    required AndroidScheduleMode mode,
    bool quiet = false,
    String? payload,
  }) async => scheduled.add((id: id, title: title, quiet: quiet));
}

class FakeOppoPhone extends Fake implements DevicePowerSettings {
  @override
  Future<String?> brand() async => 'Oppo';
}

/// Location access already granted, positioned in Alexandria.
class FakeGpsInAlexandria extends Fake implements LocationService {
  @override
  Future<bool> hasPermission() async => true;

  @override
  Future<GeoPoint> currentPosition() async =>
      const GeoPoint(latitude: 31.2001, longitude: 29.9187);
}

/// The real translation files, read once and served from memory, so widget
/// tests don't depend on asset loading.
class TestTranslations extends AssetLoader {
  TestTranslations()
    : _byLanguage = {
        for (final language in const ['ar', 'en'])
          language:
              jsonDecode(
                    File(
                      'assets/translations/$language.json',
                    ).readAsStringSync(),
                  )
                  as Map<String, dynamic>,
      };

  final Map<String, Map<String, dynamic>> _byLanguage;

  @override
  // A plain Future: easy_localization combines loaders with Future.wait,
  // which mishandles SynchronousFuture.
  Future<Map<String, dynamic>?> load(String path, Locale locale) async =>
      _byLanguage[locale.languageCode];
}

/// The bundled city list, read from disk instead of the asset bundle.
CityDirectory testCityDirectory() => CityDirectory.fromJson(
  jsonDecode(File('assets/data/cities.json').readAsStringSync()) as Json,
);
