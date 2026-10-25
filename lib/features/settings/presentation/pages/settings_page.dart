import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/core/components/coming_soon_view.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Placeholder until Settings (handover step 7). Hosts the temporary entry to
/// the developer alert test page.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => ComingSoonView(
    title: context.tr(LocaleKeys.tabs_settings),
    extra: TextButton(
      onPressed: () => context.push(AppRoutes.alertsDebug),
      child: const Text('Alert test (developer)'),
    ),
  );
}
