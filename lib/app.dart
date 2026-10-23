import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/config/themes/app_theme.dart';
import 'package:ijaba/core/controllers/theme_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Arabic (RTL) is the default whatever the device language; the user's
    // choice from the Language screen is persisted by easy_localization.
    return EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar'), Locale('en')],
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
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
      designSize: const Size(375, 812),
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
      ),
    );
  }
}
