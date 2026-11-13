import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/controller/saved_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_search_result.dart';
import 'package:ijaba/features/duas/presentation/widgets/library_category_card.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The Duas tab: search, and the shelves — morning, evening, last third,
/// ma'thur, saved. A shelf opens in the Dua screen, one dua at a time.
class LibraryPage extends HookConsumerWidget {
  const LibraryPage({this.searchRequest, super.key});

  /// Set (to a new value each time) when opened to search, from Home: the
  /// search field takes the focus.
  final String? searchRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useTextEditingController();
    final searchFocus = useFocusNode();
    useEffect(() {
      if (searchRequest != null) searchFocus.requestFocus();
      return null;
    }, [searchRequest]);
    final query = useValueListenable(search).text.trim();
    final catalog = ref.watch(duaCatalogProvider);
    final saved = ref.watch(savedDuasProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 32.h, 22.w, 24.h),
          children: [
            Text(
              context.tr(LocaleKeys.library_title),
              style: AppTextStyles.screenTitleFor(context.locale),
            ),
            SizedBox(height: 14.h),
            _SearchField(controller: search, focusNode: searchFocus),
            SizedBox(height: 22.h),
            ...catalog.when(
              loading: () => [const Center(child: CircularProgressIndicator())],
              error: (error, _) => [ErrorView(error: error)],
              data: (catalog) => query.isEmpty
                  ? [
                      for (final category in LibraryCategory.values)
                        _Spaced(
                          LibraryCategoryCard(
                            category: category,
                            count: category.of(catalog, saved).length,
                            onTap: category.of(catalog, saved).isEmpty
                                ? null
                                : () => context.push(
                                    AppRoutes.libraryCategory(category.name),
                                  ),
                          ),
                        ),
                    ]
                  : _results(context, catalog.search(query)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _results(BuildContext context, List<Dua> found) {
    if (found.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: Text(
            context.tr(LocaleKeys.library_no_results),
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle,
          ),
        ),
      ];
    }
    return [
      for (final dua in found)
        _Spaced(
          DuaSearchResult(
            dua: dua,
            onTap: () => context.push(AppRoutes.libraryDua(dua.id)),
          ),
        ),
    ];
  }
}

class _Spaced extends StatelessWidget {
  const _Spaced(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: child,
  );
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.r),
      borderSide: const BorderSide(color: AppColors.line),
    );
    return SizedBox(
      height: 44.h,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        style: AppTextStyles.searchInput,
        cursorColor: AppColors.green,
        decoration: InputDecoration(
          hintText: context.tr(LocaleKeys.library_search_hint),
          hintStyle: AppTextStyles.searchInput.copyWith(
            fontSize: 12.sp,
            color: AppColors.faint,
          ),
          prefixIcon: Icon(
            LucideIcons.search300,
            size: 18.r,
            color: AppColors.faint,
          ),
          filled: true,
          fillColor: AppColors.paperSoft,
          contentPadding: EdgeInsets.zero,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.greenMid),
          ),
        ),
      ),
    );
  }
}
