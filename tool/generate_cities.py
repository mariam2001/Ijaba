"""Builds assets/data/cities.json from Natural Earth (public domain).

The app labels the user's GPS position with the nearest city and offers a
city search, entirely offline, so the location never leaves the phone.

Usage (downloads are ~22 MB, needed only when regenerating):
    curl -LO https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_10m_populated_places.geojson
    curl -LO https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_50m_admin_0_countries.geojson
    python tool/generate_cities.py ne_10m_populated_places.geojson ne_50m_admin_0_countries.geojson

Output: {"countries": {code: [en, ar]}, "cities": [[en, ar, code, lat, lng], ...]}
with cities sorted by population, largest first (search ranks by that order).
"""
import json
import sys
from pathlib import Path

OUTPUT = Path(__file__).resolve().parent.parent / 'assets' / 'data' / 'cities.json'


def tidy(name):
    # A few Natural Earth English names are lowercase (e.g. "sharkia").
    return name[:1].upper() + name[1:] if name else name


def main(places_path, countries_path):
    countries = {}
    for feature in json.load(open(countries_path, encoding='utf-8'))['features']:
        p = feature['properties']
        countries[p['ADM0_A3']] = [p['NAME_EN'], p.get('NAME_AR') or p['NAME_EN']]

    cities = []
    for feature in json.load(open(places_path, encoding='utf-8'))['features']:
        p = feature['properties']
        code = p['ADM0_A3']
        if code not in countries:
            countries[code] = [p['ADM0NAME'], p['ADM0NAME']]
        en = tidy(p.get('NAME_EN') or p['NAME'])
        cities.append((p['POP_MAX'] or 0, [en, p.get('NAME_AR') or en, code,
                                            round(p['LATITUDE'], 4), round(p['LONGITUDE'], 4)]))
    cities.sort(key=lambda item: -item[0])

    used = {city[2] for _, city in cities}
    data = {
        'countries': {code: names for code, names in sorted(countries.items()) if code in used},
        'cities': [city for _, city in cities],
    }
    OUTPUT.write_text(json.dumps(data, ensure_ascii=False, separators=(',', ':')), encoding='utf-8')
    print(f'{len(data["cities"])} cities, {len(data["countries"])} countries -> {OUTPUT} '
          f'({OUTPUT.stat().st_size // 1024} KB)')


if __name__ == '__main__':
    main(*sys.argv[1:3])
