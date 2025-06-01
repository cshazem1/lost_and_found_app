
import 'package:flutter/cupertino.dart';
import 'package:lost_and_found_app/core/routing/platform_route.dart';
import 'package:lost_and_found_app/futures/home_store/presentation/page/home_store_page.dart';

import 'app_routes.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeStore:
        return platformRoute(HomeStorePage());
      default:
        return platformRoute(Text("Error"));
    }
  }
}