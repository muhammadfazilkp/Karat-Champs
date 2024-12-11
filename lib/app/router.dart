import 'package:flutter/material.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/login/loginview.dart';
import 'package:karatte_kid/ui/splash/splash_view.dart';

class PageRouter {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.login:
        return MaterialPageRoute(
          builder: (context) => const Loginview(),
          settings: settings,
        );

      case RoutePaths.splashView:
        return MaterialPageRoute(
            builder: (context) => const SplashView(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for page ${settings.name}'),
            ),
          ),
        );
    }
  }
}
