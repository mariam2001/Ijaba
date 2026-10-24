import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/data/model/city.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_directory.g.dart';

/// The bundled city list (assets/data/cities.json, built by
/// tool/generate_cities.py from Natural Earth). Lookups are offline, so the
/// user's location never leaves the phone.
class CityDirectory {
  const CityDirectory(this.cities);

  /// Parses the asset format: countries `{code: [en, ar]}` and cities
  /// `[en, ar, code, lat, lng]`, largest population first.
  factory CityDirectory.fromJson(Json json) {
    final countries = (json['countries']! as Json).map(
      (code, names) => MapEntry(code, names! as List<Object?>),
    );
    return CityDirectory([
      for (final row in json['cities']! as List<Object?>)
        if (row case [
          final String en,
          final String ar,
          final String code,
          final num lat,
          final num lng,
        ])
          City(
            nameEn: en,
            nameAr: ar,
            countryEn: countries[code]?[0] as String? ?? code,
            countryAr: countries[code]?[1] as String? ?? code,
            latitude: lat.toDouble(),
            longitude: lng.toDouble(),
          ),
    ]);
  }

  final List<City> cities;

  /// The closest city within [maxKm], or null when nothing is that close.
  City? nearest(GeoPoint point, {double maxKm = 60}) {
    City? best;
    var bestKm = maxKm;
    for (final city in cities) {
      final km = _distanceKm(
        point.latitude,
        point.longitude,
        city.latitude,
        city.longitude,
      );
      if (km < bestKm) {
        bestKm = km;
        best = city;
      }
    }
    return best;
  }

  /// Cities whose English or Arabic name contains [query] (Arabic matched
  /// without diacritics or hamza variants), biggest cities first.
  List<City> search(String query, {int limit = 50}) {
    final needle = normalize(query);
    if (needle.isEmpty) return cities.take(limit).toList();
    return cities
        .where(
          (city) =>
              normalize(city.nameEn).contains(needle) ||
              normalize(city.nameAr).contains(needle),
        )
        .take(limit)
        .toList();
  }

  static final _diacritics = RegExp('[ً-ٰٟـ]');

  /// Lowercase, no Arabic diacritics/tatweel, and one form of alef, yaa and
  /// taa marbuta, so "الاسكندريه" finds "الإسكندرية".
  static String normalize(String text) => text
      .toLowerCase()
      .replaceAll(_diacritics, '')
      .replaceAll(RegExp('[إأآٱ]'), 'ا')
      .replaceAll('ى', 'ي')
      .replaceAll('ة', 'ه')
      .trim();

  static double _distanceKm(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadiusKm = 6371.0;
    double rad(double degrees) => degrees * math.pi / 180;
    final dLat = rad(lat2 - lat1);
    final dLng = rad(lng2 - lng1);
    final a =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(rad(lat1)) *
            math.cos(rad(lat2)) *
            math.pow(math.sin(dLng / 2), 2);
    return 2 * earthRadiusKm * math.asin(math.sqrt(a));
  }
}

/// Loaded once, on first use.
@Riverpod(keepAlive: true)
Future<CityDirectory> cityDirectory(Ref ref) async {
  final raw = await rootBundle.loadString('assets/data/cities.json');
  return CityDirectory.fromJson(jsonDecode(raw) as Json);
}
