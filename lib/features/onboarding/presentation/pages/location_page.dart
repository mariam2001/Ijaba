import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/choice_card.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/features/location/data/datasource/location_service.dart';
import 'package:ijaba/features/location/data/model/city.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';
import 'package:ijaba/features/location/data/repository/location_repository.dart';
import 'package:ijaba/features/location/presentation/controller/location_controller.dart';
import 'package:ijaba/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Current location (GPS, labelled with the nearest bundled city) or a city
/// picked by hand. Either way the position stays on the device.
class LocationPage extends HookConsumerWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabic = context.locale.languageCode == 'ar';
    final saved = ref.read(locationControllerProvider);
    final useGps = useState(!(saved?.manual ?? false));
    final detected = useState<SavedLocation?>(
      saved != null && !saved.manual ? saved : null,
    );
    final picked = useState<City?>(saved?.manual ?? false ? saved?.city : null);
    final busy = useState(false);
    final method = ref.watch(prayerSettingsProvider).method;

    Future<SavedLocation?> detect() async {
      busy.value = true;
      final result = await ref.read(LocationRepository.provider).detect();
      if (!context.mounted) return null;
      busy.value = false;
      return result.fold((failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
        if (failure is LocationFailure) useGps.value = false;
        return null;
      }, (location) => detected.value = location);
    }

    // If location access was already granted, show the city straight away.
    useEffect(() {
      if (detected.value == null) {
        ref.read(LocationService.provider).hasPermission().then((granted) {
          if (granted && context.mounted) detect();
        });
      }
      return null;
    }, const []);

    Future<void> pickCity() async {
      final city = await context.push<City>(AppRoutes.cityPicker);
      if (city == null) return;
      picked.value = city;
      useGps.value = false;
    }

    Future<void> next() async {
      final location = useGps.value
          ? detected.value ?? await detect()
          : (picked.value == null ? null : SavedLocation.ofCity(picked.value!));
      if (location == null) {
        if (!useGps.value && context.mounted) await pickCity();
        return;
      }
      await ref.read(locationControllerProvider.notifier).save(location);
      if (context.mounted) context.go(AppRoutes.permissions);
    }

    final gpsSubtitle = busy.value
        ? context.tr(LocaleKeys.location_current_detecting)
        : detected.value?.city?.label(arabic: arabic) ??
              (detected.value == null
                  ? context.tr(LocaleKeys.location_current_pending)
                  : _coordinates(detected.value!));

    return OnboardingLayout(
      step: 1,
      action: FilledButton(
        onPressed: busy.value ? null : next,
        child: Text(context.tr(LocaleKeys.location_continue)),
      ),
      children: [
        SizedBox(height: 70.h),
        Center(
          child: Container(
            width: 72.r,
            height: 72.r,
            decoration: const BoxDecoration(
              color: AppColors.greenPale,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: 28.r,
              color: AppColors.green,
            ),
          ),
        ),
        SizedBox(height: 22.h),
        Text(
          context.tr(LocaleKeys.location_title),
          textAlign: TextAlign.center,
          style: AppTextStyles.screenTitleFor(context.locale),
        ),
        SizedBox(height: 26.h),
        Text(
          context.tr(LocaleKeys.location_subtitle),
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle,
        ),
        SizedBox(height: 38.h),
        ChoiceCard(
          title: context.tr(LocaleKeys.location_current),
          subtitle: gpsSubtitle,
          selected: useGps.value,
          onTap: () {
            useGps.value = true;
            if (detected.value == null && !busy.value) detect();
          },
        ),
        SizedBox(height: 12.h),
        ChoiceCard(
          title: context.tr(LocaleKeys.location_manual),
          subtitle:
              picked.value?.label(arabic: arabic) ??
              context.tr(LocaleKeys.location_manual_hint),
          selected: !useGps.value,
          onTap: pickCity,
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: AppColors.paperWarm,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Text(
                context.tr(LocaleKeys.location_method_label),
                style: AppTextStyles.cardSubtitle,
              ),
              SizedBox(width: 12.w),
              // Method names can be long (especially in English): let the
              // value take the remaining width and wrap if it must.
              Expanded(
                child: Text(
                  context.tr('methods.${method.name}'),
                  textAlign: TextAlign.end,
                  style: AppTextStyles.cardSubtitle.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _coordinates(SavedLocation location) =>
      '${location.latitude.toStringAsFixed(2)}, '
      '${location.longitude.toStringAsFixed(2)}';
}
