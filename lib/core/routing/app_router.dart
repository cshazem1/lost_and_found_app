
import 'package:flutter/cupertino.dart';
import 'package:lost_and_found_app/core/routing/platform_route.dart';

import 'app_routes.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return platformRoute(Text("Error"));
    }
  }
}