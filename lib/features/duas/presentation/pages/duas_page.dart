import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ijaba/core/components/coming_soon_view.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Placeholder until the Dua screen and Library (handover step 6).
class DuasPage extends StatelessWidget {
  const DuasPage({super.key});

  @override
  Widget build(BuildContext context) =>
      ComingSoonView(title: context.tr(LocaleKeys.tabs_duas));
}
