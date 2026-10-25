import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ijaba/core/components/coming_soon_view.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Placeholder until the Windows (alert control) design is exported.
class WindowsPage extends StatelessWidget {
  const WindowsPage({super.key});

  @override
  Widget build(BuildContext context) =>
      ComingSoonView(title: context.tr(LocaleKeys.tabs_windows));
}
