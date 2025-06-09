import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_and_found_app/core/di/service_locator.dart';
import 'package:lost_and_found_app/core/routing/platform_route.dart';
import 'package:lost_and_found_app/futures/auth/presentaion/cubits/auth_cubit.dart';
import 'package:lost_and_found_app/futures/auth/presentaion/pages/sign_up_page.dart';
import 'package:lost_and_found_app/futures/home_store/presentation/page/home_store_page.dart';
import 'package:lost_and_found_app/futures/splash_screen/presentation/page/splash_screen_page.dart';

import '../../futures/home_store/presentation/cubits/home_store_cubit.dart';
import 'app_routes.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeStore:
        return platformRoute(
          child: BlocProvider(
            create: (context) =>
            getIt.get<HomeStoreCubit>()
              ..getHomeStoreData(),
            child: HomeStorePage(),
          ),
        );
      case AppRoutes.splash:
        return platformRoute(child: SplashScreenPage());
      case AppRoutes.signUp:
        return platformRoute(child: BlocProvider(
          create: (context) => getIt.get<AuthCubit>(),
          child: SignUpPage(),
        ));
      default:
        return platformRoute(child: Text("Error"));
    }
  }
}
