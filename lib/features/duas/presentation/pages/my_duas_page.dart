import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/duas/data/model/custom_dua.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/controller/custom_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/widgets/page_bar.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The user's own duas (Library → My duas): add one, open one to edit it,
/// or read them all on the Dua screen. No design yet — the Library's card
/// style.
class MyDuasPage extends ConsumerWidget {
  const MyDuasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duas = ref.watch(customDuasProvider);

    return Scaffold(
      appBar: PageBar(
        title: context.tr(LocaleKeys.mine_title),
        actions: [
          if (duas.isNotEmpty)
            TextButton(
              onPressed: () => context.push(
                AppRoutes.libraryCategory(LibraryCategory.mine.name),
              ),
              style: TextButton.styleFrom(
                foregroundColor: context.colors.greenInk,
                textStyle: context.textStyles.pagerButton,
              ),
              child: Text(context.tr(LocaleKeys.mine_read)),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: duas.isEmpty
                  ? const _Empty()
                  : ListView(
                      padding: EdgeInsets.fromLTRB(22.w, 4.h, 22.w, 16.h),
                      children: [
                        Text(
                          context.tr(LocaleKeys.mine_hint),
                          style: context.textStyles.body,
                        ),
                        SizedBox(height: 16.h),
                        for (final dua in duas)
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _DuaCard(dua: dua),
                          ),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 20.h),
              child: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.myDuaNew),
                icon: Icon(LucideIcons.plus300, size: 20.r),
                label: Text(context.tr(LocaleKeys.mine_add)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.honeyPale,
              shape: BoxShape.circle,
            ),
            child: AppIconView(
              AppIcon.duaHands,
              size: 32.r,
              color: context.colors.honey,
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            context.tr(LocaleKeys.mine_empty),
            textAlign: TextAlign.center,
            style: context.textStyles.cardTitle,
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr(LocaleKeys.mine_empty_hint),
            textAlign: TextAlign.center,
            style: context.textStyles.body,
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(LocaleKeys.mine_hint),
            textAlign: TextAlign.center,
            style: context.textStyles.cardSubtitle,
          ),
        ],
      ),
    ),
  );
}

/// One dua: its first lines and where it shows; tap to edit.
class _DuaCard extends StatelessWidget {
  const _DuaCard({required this.dua});

  final CustomDua dua;

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';
    final where = dua.windows.isEmpty
        ? context.tr(LocaleKeys.mine_only_here)
        : [
            for (final window in dua.windows) context.tr(windowNameKey(window)),
          ].join(arabic ? '، ' : ', ');

    return Material(
      color: context.colors.paperSoft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: context.colors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.myDuaEdit(dua.id)),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(17.w, 14.h, 12.w, 14.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dua.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.dua.copyWith(
                        fontSize: 19.sp,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(where, style: context.textStyles.listCardCaption),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                LucideIcons.chevronRight300Dir,
                size: 22.r,
                color: context.colors.faint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
