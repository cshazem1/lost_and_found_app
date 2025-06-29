import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/app_bloc_observer.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'generated/l10n.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(context, child) =>  MaterialApp(
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        darkTheme: AppTheme.darkTheme,
        locale: Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
      ),
    );
  }
}