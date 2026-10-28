import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/config/themes/app_theme.dart';
import 'package:ijaba/core/controllers/theme_controller.dart';
import 'package:ijaba/features/alerts/presentation/controller/alerts_controller.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class App extends StatelessWidget {
  const App({super.key, this.translations = const RootBundleAssetLoader()});

  /// Where the JSON translations come from: the bundled assets, or an
  /// in-memory loader in widget tests (asset loading is unreliable there).
  final AssetLoader translations;

  @override
  Widget build(BuildContext context) {
    // Arabic (RTL) is the default whatever the device language; the user's
    // choice from the Language screen is persisted by easy_localization.
    return EasyLocalization(
      path: 'assets/translations',
      assetLoader: translations,
      supportedLocales: const [Locale('ar'), Locale('en')],
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      // Use each language's real plural forms: Arabic needs "few" for 3–10
      // ("٥ دقائق"), which the default value-only fallback never picks.
      ignorePluralRules: false,
      child: const _AppView(),
    );
  }
}

class _AppView extends ConsumerWidget {
  const _AppView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return ScreenUtilInit(
      // The Figma frames are 390 × 844.
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp.router(
        onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.light,
        darkTheme: AppTheme.night,
        themeMode: themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) => _AlertScheduler(child: child!),
      ),
    );
  }
}

/// Keeps the coming days' alerts scheduled: on start, when the language or
/// the windows switched on change, and on each return to the foreground
/// (throttled by the controller). It sits inside MaterialApp, which builds it
/// only once the translations have loaded — alert text is generated at
/// scheduling time.
class _AlertScheduler extends HookConsumerWidget {
  const _AlertScheduler({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeName = context.locale.toString();
    final enabled = ref.watch(enabledWindowTypesProvider);

    void reschedule({bool force = false}) => ref
        .read(alertsControllerProvider.notifier)
        .reschedule(localeName: localeName, force: force);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => reschedule(force: true),
      );
      return null;
    }, [localeName, enabled]);
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) reschedule();
    });

    return child;
  }
}
