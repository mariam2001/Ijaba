import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';

void main() {
  // The real bundled asset, so the data itself is covered too.
  final directory = CityDirectory.fromJson(
    jsonDecode(File('assets/data/cities.json').readAsStringSync()) as Json,
  );

  test('labels a GPS fix in Alexandria with the design text', () {
    final city = directory.nearest(
      const GeoPoint(latitude: 31.2001, longitude: 29.9187),
    );

    expect(city?.label(arabic: true), 'الإسكندرية، مصر');
    expect(city?.label(arabic: false), 'Alexandria, Egypt');
  });

  test('returns no city when nothing is within reach', () {
    // Mid-Atlantic.
    expect(
      directory.nearest(const GeoPoint(latitude: 30, longitude: -40)),
      isNull,
    );
  });

  test('search ignores hamza forms, taa marbuta and case', () {
    expect(directory.search('الاسكندريه').first.nameEn, 'Alexandria');
    expect(directory.search('CAIRO').first.nameAr, 'القاهرة');
  });

  test('an empty search lists the biggest cities first', () {
    expect(directory.search('', limit: 3), hasLength(3));
  });

  test('a manually chosen city round-trips through storage', () {
    final cairo = directory.search('Cairo').first;
    final saved = SavedLocation.ofCity(cairo);

    expect(SavedLocation.fromJson(saved.toJson()), saved);
    expect(saved.manual, isTrue);
  });
}
