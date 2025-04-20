import 'package:flutter/material.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/home/homeview.dart';
import 'package:karatte_kid/ui/login/loginview.dart';
import 'package:karatte_kid/ui/splash/splash_view.dart';
import 'package:karatte_kid/ui/student_entrolling/student_entroling_view.dart';
import 'package:karatte_kid/ui/class_view/class_view.dart';

import '../ui/bottom_nav/bottmnav_view.dart';

class PageRouter {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );

      case RoutePaths.splashView:
        return MaterialPageRoute(
            builder: (context) => const SplashView(), settings: settings);

      case RoutePaths.homeview:
        return MaterialPageRoute(
            builder: (context) => const Homeview(), settings: settings);

      case RoutePaths.bottonav:
        return MaterialPageRoute(
            builder: (context) => const BottomnavView(), settings: settings);

      case RoutePaths.studentView:
        return MaterialPageRoute(
            builder: (context) => const StudentEntrolingView(),
            settings: settings);

      case RoutePaths.studentListView:
        return MaterialPageRoute(
            builder: (context) => const ClassView(), settings: settings);

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
