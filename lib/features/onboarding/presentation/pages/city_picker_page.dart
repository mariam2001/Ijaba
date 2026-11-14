import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Searchable list of the bundled cities; pops with the chosen `City`.
///
/// Not in the Figma screens yet — styled from the design tokens.
class CityPickerPage extends HookConsumerWidget {
  const CityPickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabic = context.locale.languageCode == 'ar';
    final query = useState('');
    final directory = ref.watch(cityDirectoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(LocaleKeys.location_picker_title),
          style: context.textStyles.cardTitle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 8.h),
            child: TextField(
              autofocus: true,
              onChanged: (value) => query.value = value,
              style: context.textStyles.cardTitle.copyWith(
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: context.tr(LocaleKeys.location_picker_search),
                hintStyle: context.textStyles.cardSubtitle,
                prefixIcon: Icon(
                  LucideIcons.search300,
                  color: context.colors.muted,
                ),
                filled: true,
                fillColor: context.colors.paperSoft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: context.colors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: context.colors.line),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: context.colors.greenInk),
                ),
              ),
            ),
          ),
          Expanded(
            child: directory.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorView(error: error),
              data: (cities) {
                final results = cities.search(query.value);
                if (results.isEmpty) {
                  return Center(
                    child: Text(
                      context.tr(LocaleKeys.location_picker_empty),
                      style: context.textStyles.cardSubtitle,
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: results.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: context.colors.line),
                  itemBuilder: (context, index) {
                    final city = results[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        arabic ? city.nameAr : city.nameEn,
                        style: context.textStyles.cardTitle,
                      ),
                      subtitle: Text(
                        arabic ? city.countryAr : city.countryEn,
                        style: context.textStyles.cardSubtitle,
                      ),
                      onTap: () => context.pop(city),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
