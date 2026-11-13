import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The app's own line icons (assets/icons — 24px masters, 1.5 stroke, round
/// caps: the weight of the Lucide `…300` icons used elsewhere). The rain,
/// sleep and lantern icons there are kept for v1.1.
enum AppIcon {
  adhanIqama('ic_adhan_iqama'),
  afterPrayer('ic_after_prayer'),
  duaHands('ic_dua_hands'),
  evening('ic_evening'),
  fridayHour('ic_friday_hour'),
  ijabaMark('ic_ijaba_mark'),
  lastThird('ic_last_third'),
  morning('ic_morning'),
  mushaf('ic_mushaf'),
  saved('ic_saved'),
  tasbih('ic_tasbih')
  ;

  const AppIcon(this._file);

  final String _file;

  String get asset => 'assets/icons/$_file.svg';
}

/// [icon] at [size], tinted [color].
class AppIconView extends StatelessWidget {
  const AppIconView(
    this.icon, {
    required this.size,
    required this.color,
    super.key,
  });

  final AppIcon icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    icon.asset,
    width: size,
    height: size,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
