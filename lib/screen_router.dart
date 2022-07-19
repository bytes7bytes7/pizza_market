import 'package:flutter/material.dart';

import 'constants/routes.dart' as const_routes;
import 'screens/screens.dart';

class ScreenRouter {
  ScreenRouter._();

  static final inst = ScreenRouter._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Route navigate(RouteSettings settings) {
    final name = settings.name ?? '';
    final args = <String, Object?>{};
    final rawArgs = settings.arguments;
    if (rawArgs is Map<String, Object?>) {
      args.addAll(rawArgs);
    }

    switch (name) {
      case const_routes.home:
        return _route(const HomeScreen());
      case const_routes.cart:
        return _route(const CartScreen());
      case const_routes.admin:
        return _route(const AdminScreen());
      default:
        return _route(const NotFoundScreen());
    }
  }

  MaterialPageRoute _route(Widget screen) =>
      MaterialPageRoute(builder: (context) => screen);
}
