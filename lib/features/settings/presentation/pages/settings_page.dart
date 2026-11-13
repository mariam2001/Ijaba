import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/option_sheet.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/location/data/model/city.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';
import 'package:ijaba/features/location/data/repository/location_repository.dart';
import 'package:ijaba/features/location/presentation/controller/location_controller.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/settings/presentation/widgets/about_sheet.dart';
import 'package:ijaba/features/settings/presentation/widgets/adjustment_sheet.dart';
import 'package:ijaba/features/settings/presentation/widgets/iqama_sheet.dart';
import 'package:ijaba/features/settings/presentation/widgets/settings_section.dart';
import 'package:ijaba/features/windows/data/model/window_config.dart';
import 'package:ijaba/features/windows/presentation/controller/window_config_controller.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Prayer-time inputs, alert sound and vibration, language, about. Changes to
/// the location or prayer-time settings re-plan the alerts (see
/// `_AlertScheduler`).
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = context.locale.languageCode;
    final location = ref.watch(locationControllerProvider);
    final settings = ref.watch(prayerSettingsProvider);
    final windowConfig = ref.watch(windowConfigProvider);
    final controller = ref.read(prayerSettingsControllerProvider.notifier);
    final notifications = ref.read(NotificationService.provider);

    String madhabName(Madhab madhab) => context.tr(
      madhab == Madhab.hanafi
          ? LocaleKeys.settings_madhab_hanafi
          : LocaleKeys.settings_madhab_shafi,
    );

    final adjusted = [
      for (final prayer in Prayer.values)
        if (settings.adjustmentOf(prayer) != 0)
          '${context.tr(prayerNameKey(prayer))} '
              '${signedMinutes(settings.adjustmentOf(prayer), language)}',
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 33.h, 22.w, 24.h),
          children: [
            Text(
              context.tr(LocaleKeys.settings_title),
              style: AppTextStyles.screenTitleFor(context.locale),
            ),
            SizedBox(height: 17.h),
            SettingsSection(
              label: context.tr(LocaleKeys.settings_section_times),
              rows: [
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_location),
                  value: location?.city?.label(arabic: language == 'ar'),
                  onTap: () => _changeLocation(context, ref, location),
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_method),
                  value: context.tr('methods.${settings.method.name}'),
                  onTap: () async {
                    final method = await showOptionSheet(
                      context: context,
                      title: context.tr(LocaleKeys.settings_method),
                      selected: settings.method,
                      options: [
                        // "Other" means custom angles, which we don't offer.
                        for (final method in CalculationMethod.values)
                          if (method != CalculationMethod.other)
                            (
                              value: method,
                              label: context.tr('methods.${method.name}'),
                              hint: null,
                            ),
                      ],
                    );
                    if (method != null) await controller.setMethod(method);
                  },
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_madhab),
                  value: madhabName(settings.madhab),
                  onTap: () async {
                    final madhab = await showOptionSheet(
                      context: context,
                      title: context.tr(LocaleKeys.settings_madhab),
                      selected: settings.madhab,
                      options: [
                        (
                          value: Madhab.shafi,
                          label: madhabName(Madhab.shafi),
                          hint: context.tr(
                            LocaleKeys.settings_madhab_shafi_hint,
                          ),
                        ),
                        (
                          value: Madhab.hanafi,
                          label: madhabName(Madhab.hanafi),
                          hint: null,
                        ),
                      ],
                    );
                    if (madhab != null) await controller.setMadhab(madhab);
                  },
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_adjustment),
                  value: adjusted.isEmpty
                      ? context.tr(LocaleKeys.settings_no_adjustment)
                      : adjusted.join('، '),
                  onTap: () => showAppSheet<void>(
                    context: context,
                    title: context.tr(LocaleKeys.settings_adjustment),
                    child: const AdjustmentSheet(),
                  ),
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_iqama),
                  value: context.tr(
                    windowConfig == const WindowConfig()
                        ? LocaleKeys.settings_defaults
                        : LocaleKeys.settings_custom,
                  ),
                  onTap: () => showAppSheet<void>(
                    context: context,
                    title: context.tr(LocaleKeys.settings_iqama),
                    child: const IqamaSheet(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SettingsSection(
              label: context.tr(LocaleKeys.settings_section_alerts),
              rows: [
                // Android keeps a channel's sound and vibration for the user
                // to choose, in the phone's settings.
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_tone),
                  value: context.tr(LocaleKeys.settings_in_phone_settings),
                  onTap: notifications.openAlertChannelSettings,
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_vibration),
                  value: context.tr(LocaleKeys.settings_in_phone_settings),
                  onTap: notifications.openAlertChannelSettings,
                ),
                // Waits for the night palette.
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_night_mode),
                  value: context.tr(LocaleKeys.common_coming_soon),
                  onTap: null,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SettingsSection(
              label: context.tr(LocaleKeys.settings_section_app),
              rows: [
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_language),
                  value: context.tr(
                    language == 'ar'
                        ? LocaleKeys.language_arabic
                        : LocaleKeys.language_english,
                  ),
                  onTap: () async {
                    final code = await showOptionSheet(
                      context: context,
                      title: context.tr(LocaleKeys.settings_language),
                      selected: language,
                      options: [
                        (
                          value: 'ar',
                          label: context.tr(LocaleKeys.language_arabic),
                          hint: null,
                        ),
                        (
                          value: 'en',
                          label: context.tr(LocaleKeys.language_english),
                          hint: null,
                        ),
                      ],
                    );
                    if (code != null && context.mounted) {
                      await context.setLocale(Locale(code));
                    }
                  },
                ),
                SettingsRow(
                  title: context.tr(LocaleKeys.settings_about),
                  value: null,
                  onTap: () => showAppSheet<void>(
                    context: context,
                    title: context.tr(LocaleKeys.app_name),
                    child: const AboutSheet(),
                  ),
                ),
              ],
            ),
            // Temporary, for testing alerts on a real phone; debug builds only.
            if (kDebugMode) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => context.push(AppRoutes.alertsDebug),
                child: const Text('Alert test (developer)'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// GPS (labelled with the nearest bundled city) or a city picked by hand —
  /// as in onboarding; the position stays on the device either way.
  Future<void> _changeLocation(
    BuildContext context,
    WidgetRef ref,
    SavedLocation? current,
  ) async {
    final manual = await showOptionSheet(
      context: context,
      title: context.tr(LocaleKeys.settings_location),
      selected: current?.manual ?? false,
      options: [
        (
          value: false,
          label: context.tr(LocaleKeys.location_current),
          hint: null,
        ),
        (
          value: true,
          label: context.tr(LocaleKeys.location_manual),
          hint: context.tr(LocaleKeys.location_manual_hint),
        ),
      ],
    );
    if (manual == null || !context.mounted) return;
    final locations = ref.read(locationControllerProvider.notifier);

    if (manual) {
      final city = await context.push<City>(AppRoutes.cityPicker);
      if (city != null) await locations.save(SavedLocation.ofCity(city));
      return;
    }
    final messenger = ScaffoldMessenger.of(context)
      ..showSnackBar(
        SnackBar(
          content: Text(context.tr(LocaleKeys.location_current_detecting)),
        ),
      );
    final result = await ref.read(LocationRepository.provider).detect();
    messenger.hideCurrentSnackBar();
    await result.fold(
      (failure) async =>
          messenger.showSnackBar(SnackBar(content: Text(failure.message))),
      locations.save,
    );
  }
}
