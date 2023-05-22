import 'package:flutter/material.dart';
import 'package:orbi_test/src/ui/screens/detail/detail_screen.dart';
import 'package:orbi_test/src/ui/screens/home/home_screen.dart';
import 'package:orbi_test/src/ui/screens/splash/splash_screen.dart';

enum Routes { splash, home, details }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String details = '/details';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.details: _Paths.details,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: const SplashScreen());
      case _Paths.details:
        return FadeRoute(
            page: DetailScreen(
          index: (settings.arguments ?? 0) as int,
        ));
      case _Paths.home:
      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}
