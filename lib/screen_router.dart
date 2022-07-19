import 'package:flutter/material.dart';

import 'constants/routes.dart' as const_routes;
import 'screens/screens.dart';

part 'custom_route_builder.dart';

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
        return _left(const HomeScreen());
      case const_routes.cart:
        return _left(const CartScreen());
      case const_routes.admin:
        return _left(const AdminScreen());
      default:
        return _left(const NotFoundScreen());
    }
  }

  Route _left(Widget page) => CustomRouteBuilder(
        page,
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      );
}
