import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

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
          style: AppTextStyles.cardTitle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 8.h),
            child: TextField(
              autofocus: true,
              onChanged: (value) => query.value = value,
              style: AppTextStyles.cardTitle.copyWith(
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: context.tr(LocaleKeys.location_picker_search),
                hintStyle: AppTextStyles.cardSubtitle,
                prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                filled: true,
                fillColor: AppColors.paperSoft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(color: AppColors.green),
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
                      style: AppTextStyles.cardSubtitle,
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: results.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, color: AppColors.line),
                  itemBuilder: (context, index) {
                    final city = results[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        arabic ? city.nameAr : city.nameEn,
                        style: AppTextStyles.cardTitle,
                      ),
                      subtitle: Text(
                        arabic ? city.countryAr : city.countryEn,
                        style: AppTextStyles.cardSubtitle,
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
