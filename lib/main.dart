import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/app/provider.dart';
import 'package:karatte_kid/app/router.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_string.dart';
import 'package:provider/provider.dart';
import 'constant/app_constant.dart';
import 'service/navigation_srvices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: providers,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          theme: ThemeData(
                        scaffoldBackgroundColor: Palete.primaryColor,

                        highlightColor: Palete.primaryColor.withOpacity(0.1),
            splashColor: Palete.primaryColor.withOpacity(0.1),
            fontFamily: FontFamily.poppins,
            useMaterial3: true,
          ),
          initialRoute: RoutePaths.splashView,
          onGenerateRoute: PageRouter.generateRoute,
          navigatorKey: NavigationService.navigationKey,
        ),
      ),
    );
  }
}
