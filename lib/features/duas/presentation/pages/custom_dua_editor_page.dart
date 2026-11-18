import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/duas/data/model/custom_dua.dart';
import 'package:ijaba/features/duas/presentation/controller/custom_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/widgets/page_bar.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_art.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Writes a new dua ([id] null) or edits / deletes one of the user's own:
/// its words, and the windows whose Dua screen it joins. No design yet.
class CustomDuaEditorPage extends HookConsumerWidget {
  const CustomDuaEditorPage({this.id, super.key});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duas = ref.read(customDuasProvider.notifier);
    // Read once: what's on screen is the draft until it's saved.
    final existing = useMemoized(() => id == null ? null : duas.byId(id!));
    final text = useTextEditingController(text: existing?.text);
    useListenable(text);
    final windows = useState<Set<DuaWindowType>>({
      ...existing?.windows ?? CustomDua.defaultWindows,
    });
    final canSave = text.text.trim().isNotEmpty;

    Future<void> save() async {
      final picked = windows.value.toList();
      if (existing == null) {
        await duas.add(text.text, picked);
      } else {
        await duas.edit(existing.id, text: text.text, windows: picked);
      }
      if (context.mounted) context.pop();
    }

    Future<void> delete() async {
      final sure = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: context.colors.paper,
          content: Text(
            context.tr(LocaleKeys.mine_delete_confirm),
            style: context.textStyles.cardTitle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: TextButton.styleFrom(
                foregroundColor: context.colors.muted,
                textStyle: context.textStyles.pagerButton,
              ),
              child: Text(context.tr(LocaleKeys.mine_cancel)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: context.colors.honey,
                textStyle: context.textStyles.pagerButton,
              ),
              child: Text(context.tr(LocaleKeys.mine_delete_yes)),
            ),
          ],
        ),
      );
      if (sure != true || existing == null) return;
      await duas.remove(existing.id);
      if (context.mounted) context.pop();
    }

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: context.colors.line),
    );

    return Scaffold(
      appBar: PageBar(
        title: context.tr(
          existing == null
              ? LocaleKeys.mine_new_title
              : LocaleKeys.mine_edit_title,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(22.w, 4.h, 22.w, 16.h),
                children: [
                  TextField(
                    controller: text,
                    autofocus: existing == null,
                    minLines: 4,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: context.colors.greenInk,
                    style: context.textStyles.dua.copyWith(
                      fontSize: 20.sp,
                      height: 1.7,
                    ),
                    decoration: InputDecoration(
                      hintText: context.tr(LocaleKeys.mine_text_hint),
                      hintStyle: context.textStyles.cardSubtitle.copyWith(
                        fontSize: 13.sp,
                      ),
                      filled: true,
                      fillColor: context.colors.paperSoft,
                      contentPadding: EdgeInsets.all(16.r),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(color: context.colors.greenMid),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    context.tr(LocaleKeys.mine_shows_in),
                    style: context.textStyles.sectionLabel,
                  ),
                  SizedBox(height: 7.h),
                  Material(
                    color: context.colors.paperSoft,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      side: BorderSide(color: context.colors.line),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        for (final (i, window)
                            in DuaWindowType.values.indexed) ...[
                          if (i > 0)
                            Divider(height: 1, color: context.colors.line),
                          _WindowChoice(
                            window: window,
                            selected: windows.value.contains(window),
                            onTap: () =>
                                windows.value = windows.value.contains(window)
                                ? windows.value.difference({window})
                                : {...windows.value, window},
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (windows.value.isEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      context.tr(LocaleKeys.mine_only_here),
                      style: context.textStyles.cardSubtitle,
                    ),
                  ],
                  if (existing != null) ...[
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
                        onPressed: delete,
                        style: TextButton.styleFrom(
                          foregroundColor: context.colors.muted,
                          textStyle: context.textStyles.pagerButton,
                        ),
                        icon: Icon(LucideIcons.trash2300, size: 18.r),
                        label: Text(context.tr(LocaleKeys.mine_delete)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 20.h),
              child: FilledButton(
                onPressed: canSave ? save : null,
                child: Text(context.tr(LocaleKeys.mine_save)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A window to tick: its icon, name, and a check when chosen.
class _WindowChoice extends StatelessWidget {
  const _WindowChoice({
    required this.window,
    required this.selected,
    required this.onTap,
  });

  final DuaWindowType window;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 12.h),
      child: Row(
        children: [
          AppIconView(
            windowIcon(window),
            size: 20.r,
            color: selected ? context.colors.greenInk : context.colors.faint,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              context.tr(windowNameKey(window)),
              style: context.textStyles.rowTitle,
            ),
          ),
          Icon(
            selected ? LucideIcons.circleCheck300 : LucideIcons.circle300,
            size: 22.r,
            color: selected ? context.colors.greenInk : context.colors.faint,
          ),
        ],
      ),
    ),
  );
}
